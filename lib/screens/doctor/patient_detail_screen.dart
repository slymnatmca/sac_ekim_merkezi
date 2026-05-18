import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/auth_provider.dart';
import '../../providers/doctor_provider.dart';
import '../../models/patient_model.dart';
import '../../models/doctor_model.dart';
import '../../utils/colors.dart';
import '../../utils/helpers.dart';

class PatientDetailScreen extends StatefulWidget {
  const PatientDetailScreen({super.key});
  
  @override
  State<PatientDetailScreen> createState() => _PatientDetailScreenState();
}

class _PatientDetailScreenState extends State<PatientDetailScreen> {
  final Map<String, TextEditingController> _commentControllers = {};
  
  TextEditingController _getController(String consultationId) {
    if (!_commentControllers.containsKey(consultationId)) {
      _commentControllers[consultationId] = TextEditingController();
    }
    return _commentControllers[consultationId]!;
  }
  
  @override
  void dispose() {
    for (var controller in _commentControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }
  
  Color _getWeekColor(int week) {
    if (week <= 2) return AppColors.week1Color;
    if (week <= 4) return AppColors.week4Color;
    if (week <= 8) return AppColors.week8Color;
    if (week <= 12) return AppColors.week12Color;
    return AppColors.week16Color;
  }
  
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final patient = ModalRoute.of(context)!.settings.arguments as PatientModel;
    final authProvider = Provider.of<AuthProvider>(context);
    final doctor = authProvider.currentUser as DoctorModel;
    final doctorProvider = Provider.of<DoctorProvider>(context);
    final weekColor = _getWeekColor(patient.currentWeek);
    
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(patient.name),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: AppColors.doctorGradient),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Patient Info Card
          Container(
            decoration: BoxDecoration(
              gradient: patient.isPremium ? AppColors.premiumGradient : AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: (patient.isPremium ? AppColors.premiumGold : AppColors.primaryLight)
                      .withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Text(
                    patient.name[0],
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: patient.isPremium ? AppColors.premiumGold : AppColors.primaryLight,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  patient.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  patient.email,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildInfoChip(
                      icon: Icons.calendar_today,
                      label: '${l10n.week} ${patient.currentWeek}',
                      color: weekColor,
                    ),
                    if (patient.isPremium)
                      _buildInfoChip(
                        icon: Icons.star,
                        label: l10n.premium,
                        color: Colors.white,
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${l10n.transplantDate}: ${Helpers.formatDate(patient.transplantDate)}',
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Real-time Consultations Stream
          StreamBuilder(
            stream: doctorProvider.getConsultationsStream(doctor.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              
              final allConsultations = snapshot.data ?? [];
              final consultations = allConsultations
                  .where((c) => c.patientId == patient.id)
                  .toList()
                  ..sort((a, b) => b.date.compareTo(a.date));
              
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats Row
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.photo_library,
                          count: consultations.length.toString(),
                          label: 'Total Consultations',
                          color: AppColors.accentBlue,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.pending_actions,
                          count: consultations.where((c) => !c.isAnswered).length.toString(),
                          label: 'Pending',
                          color: AppColors.warning,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Consultations
                  Row(
                    children: [
                      Icon(Icons.medical_services, color: AppColors.primaryLight),
                      const SizedBox(width: 8),
                      Text(
                        l10n.consultation,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  
                  if (consultations.isEmpty)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Center(
                          child: Column(
                            children: [
                              Icon(Icons.inbox, size: 64, color: Colors.grey[400]),
                              const SizedBox(height: 16),
                              Text(
                                'No consultations yet',
                                style: TextStyle(color: Colors.grey[600], fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  else
                    ...consultations.map((consultation) => Card(
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            consultation.photoUrl != null ? Icons.photo_camera : Icons.note,
                            color: AppColors.primaryLight,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Helpers.formatDate(consultation.date),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: consultation.isAnswered
                                      ? AppColors.success.withValues(alpha: 0.1)
                                      : AppColors.warning.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  consultation.isAnswered ? l10n.answered : l10n.pending,
                                  style: TextStyle(
                                    color: consultation.isAnswered ? AppColors.success : AppColors.warning,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white.withValues(alpha: 0.05)
                            : Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.person, size: 16, color: Colors.grey[600]),
                              const SizedBox(width: 4),
                              Text(
                                l10n.patientNote,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(consultation.patientNote, style: const TextStyle(height: 1.5)),
                        ],
                      ),
                    ),
                    if (consultation.doctorComment != null) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.success.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.medical_services, size: 16, color: AppColors.success),
                                const SizedBox(width: 4),
                                Text(
                                  l10n.doctorComment,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.success,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(consultation.doctorComment!, style: const TextStyle(height: 1.5)),
                          ],
                        ),
                      ),
                    ] else ...[
                      const SizedBox(height: 12),
                      TextField(
                        controller: _getController(consultation.id),
                        decoration: InputDecoration(
                          hintText: 'Add your comment...',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            final controller = _getController(consultation.id);
                            if (controller.text.isNotEmpty) {
                              try {
                                await doctorProvider.addCommentToConsultation(
                                  consultation.id,
                                  controller.text,
                                );
                                controller.clear();
                                Helpers.showSnackBar(context, 'Comment added successfully!');
                              } catch (e) {
                                Helpers.showSnackBar(context, 'Failed to add comment');
                              }
                            }
                          },
                          icon: const Icon(Icons.send),
                          label: Text(l10n.reply),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            )),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildInfoChip({required IconData icon, required String label, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
  
  Widget _buildStatCard({
    required IconData icon,
    required String count,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            count,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: color),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
