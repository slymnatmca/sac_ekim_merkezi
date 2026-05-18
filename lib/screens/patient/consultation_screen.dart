import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/auth_provider.dart';
import '../../providers/patient_provider.dart';
import '../../models/patient_model.dart';
import '../../models/consultation_model.dart';
import '../../utils/colors.dart';
import '../../utils/helpers.dart';

class ConsultationScreen extends StatefulWidget {
  const ConsultationScreen({super.key});
  
  @override
  State<ConsultationScreen> createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends State<ConsultationScreen> {
  final TextEditingController _noteController = TextEditingController();
  
  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }
  
  void _showConsultationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Consultation'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(
                labelText: 'Your Question/Note',
                hintText: 'Describe your concern...',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                // Photo upload functionality would go here
              },
              icon: const Icon(Icons.photo_camera),
              label: const Text('Add Photo (Optional)'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_noteController.text.isNotEmpty) {
                final authProvider = Provider.of<AuthProvider>(context, listen: false);
                final patient = authProvider.currentUser as PatientModel;
                final newConsultation = ConsultationModel(
                  id: 'cons_${DateTime.now().millisecondsSinceEpoch}',
                  patientId: patient.id,
                  doctorId: patient.doctorId,
                  patientNote: _noteController.text,
                  date: DateTime.now(),
                  isAnswered: false,
                );
                
                try {
                  await Provider.of<PatientProvider>(context, listen: false)
                      .addConsultation(newConsultation);
                  _noteController.clear();
                  Navigator.pop(context);
                  Helpers.showSnackBar(context, 'Consultation submitted successfully!');
                } catch (e) {
                  Helpers.showSnackBar(context, 'Failed to submit consultation');
                }
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final authProvider = Provider.of<AuthProvider>(context);
    final patient = authProvider.currentUser as PatientModel;
    final patientProvider = Provider.of<PatientProvider>(context);
    final consultations = patientProvider.consultations;
    
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(l10n.consultation),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: patient.isPremium ? AppColors.premiumGradient : AppColors.primaryGradient,
          ),
        ),
      ),
      body: consultations.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.medical_services_outlined, size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No consultations yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap + to ask your doctor',
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: consultations.length,
              itemBuilder: (context, index) {
                final consultation = consultations[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: consultation.isAnswered
                        ? Border.all(color: AppColors.success.withValues(alpha: 0.3), width: 2)
                        : null,
                    boxShadow: [
                      BoxShadow(
                        color: consultation.isAnswered
                            ? AppColors.success.withValues(alpha: 0.1)
                            : Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: consultation.isAnswered
                              ? AppColors.success.withValues(alpha: 0.1)
                              : AppColors.warning.withValues(alpha: 0.1),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: consultation.isAnswered ? AppColors.success : AppColors.warning,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                consultation.isAnswered ? Icons.check_circle : Icons.pending,
                                color: Colors.white,
                                size: 20,
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
                                  Text(
                                    consultation.isAnswered ? l10n.answered : l10n.pending,
                                    style: TextStyle(
                                      color: consultation.isAnswered ? AppColors.success : AppColors.warning,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (consultation.photoUrl != null)
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.accentBlue.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(Icons.photo, color: AppColors.accentBlue, size: 20),
                              ),
                          ],
                        ),
                      ),
                      
                      // Patient Note
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.person, size: 18, color: AppColors.primaryLight),
                                const SizedBox(width: 8),
                                Text(
                                  l10n.patientNote,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white.withValues(alpha: 0.05)
                                    : Colors.grey[100],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                consultation.patientNote,
                                style: const TextStyle(fontSize: 15, height: 1.6),
                              ),
                            ),
                            
                            // Doctor Comment
                            if (consultation.doctorComment != null) ...[
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Icon(Icons.medical_services, size: 18, color: AppColors.success),
                                  const SizedBox(width: 8),
                                  Text(
                                    l10n.doctorComment,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors.success.withValues(alpha: 0.1),
                                      AppColors.success.withValues(alpha: 0.05),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppColors.success.withValues(alpha: 0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      consultation.doctorComment!,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        height: 1.6,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.verified,
                                          size: 16,
                                          color: AppColors.success,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          'Answered by your doctor',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.success,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ] else ...[
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColors.warning.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppColors.warning.withValues(alpha: 0.3),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.schedule, color: AppColors.warning, size: 20),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        'Waiting for doctor\'s response...',
                                        style: TextStyle(
                                          color: AppColors.warning,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showConsultationDialog(context),
        icon: const Icon(Icons.add),
        label: const Text('New Question'),
        backgroundColor: patient.isPremium ? AppColors.premiumGold : AppColors.primaryLight,
      ),
    );
  }
}
