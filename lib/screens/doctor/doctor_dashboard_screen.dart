import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/auth_provider.dart';
import '../../providers/doctor_provider.dart';
import '../../providers/chat_provider.dart';
import '../../models/doctor_model.dart';
import '../../utils/helpers.dart';
import '../../utils/colors.dart';

class DoctorDashboardScreen extends StatefulWidget {
  const DoctorDashboardScreen({super.key});
  
  @override
  State<DoctorDashboardScreen> createState() => _DoctorDashboardScreenState();
}

class _DoctorDashboardScreenState extends State<DoctorDashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final doctor = authProvider.currentUser as DoctorModel;
      final doctorProvider = Provider.of<DoctorProvider>(context, listen: false);
      doctorProvider.loadPatients(doctor.id);
      doctorProvider.loadConsultations(doctor.id);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final authProvider = Provider.of<AuthProvider>(context);
    final doctor = authProvider.currentUser as DoctorModel;
    final doctorProvider = Provider.of<DoctorProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(l10n.patients),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: AppColors.doctorGradient),
        ),
        actions: [
          // Chat icon with badge
          StreamBuilder<int>(
            stream: _getUnreadMessagesCount(doctor.id, doctorProvider),
            builder: (context, snapshot) {
              final unreadCount = snapshot.data ?? 0;
              
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chat_bubble),
                    onPressed: () => Navigator.pushNamed(context, '/doctor-chat-list'),
                  ),
                  if (unreadCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          unreadCount > 9 ? '9+' : '$unreadCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.pushNamed(context, '/doctor-profile'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor Info Card with Gradient
            Container(
              decoration: BoxDecoration(
                gradient: AppColors.doctorGradient,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondaryDark.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.medical_services,
                        size: 40,
                        color: AppColors.secondaryDark,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    doctor.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    doctor.specialization,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatChip(
                        icon: Icons.people,
                        count: '${doctorProvider.patients.length}',
                        label: l10n.totalPatients,
                      ),
                      Container(width: 1, height: 40, color: Colors.white30),
                      _buildStatChip(
                        icon: Icons.pending_actions,
                        count: '${doctorProvider.unansweredCount}',
                        label: l10n.unansweredConsultations,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Icon(Icons.people, color: AppColors.secondaryLight),
                const SizedBox(width: 8),
                Text(l10n.patients, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),
            ...doctorProvider.patients.map((patient) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                gradient: patient.isPremium ? AppColors.premiumGradient : null,
                color: patient.isPremium ? null : Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: patient.isPremium
                        ? AppColors.premiumGold.withValues(alpha: 0.3)
                        : Colors.black.withValues(alpha: 0.05),
                    blurRadius: patient.isPremium ? 15 : 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => Navigator.pushNamed(context, '/patient-detail', arguments: patient),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: patient.isPremium ? Colors.white : AppColors.primaryLight,
                              width: 2,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 28,
                            backgroundColor: patient.isPremium ? Colors.white : AppColors.primaryLight.withValues(alpha: 0.1),
                            child: Text(
                              patient.name[0],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: patient.isPremium ? AppColors.premiumGold : AppColors.primaryLight,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    patient.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: patient.isPremium ? Colors.white : null,
                                    ),
                                  ),
                                  if (patient.isPremium) ...[
                                    const SizedBox(width: 8),
                                    const Icon(Icons.star, color: Colors.white, size: 18),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '${l10n.week} ${patient.currentWeek} • ${Helpers.formatDate(patient.transplantDate)}',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: patient.isPremium ? Colors.white70 : Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: patient.isPremium ? Colors.white : Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
  
  // Okunmamış mesaj sayısını hesapla
  Stream<int> _getUnreadMessagesCount(String doctorId, DoctorProvider doctorProvider) async* {
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    
    // Tüm premium hastalar için mesajları kontrol et
    int totalUnread = 0;
    
    for (var patient in doctorProvider.patients) {
      if (patient.isPremium) {
        await for (var messages in chatProvider.getChatMessagesStream(doctorId, patient.id)) {
          final unread = messages.where((m) => m.receiverId == doctorId && !m.isRead).length;
          totalUnread += unread;
          yield totalUnread;
          totalUnread = 0; // Reset for next iteration
        }
      }
    }
  }
  
  Widget _buildStatChip({
    required IconData icon,
    required String count,
    required String label,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 8),
        Text(
          count,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
