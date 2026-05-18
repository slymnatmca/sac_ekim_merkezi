import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/auth_provider.dart';
import '../../providers/doctor_provider.dart';
import '../../providers/chat_provider.dart';
import '../../models/doctor_model.dart';
import '../../models/patient_model.dart';
import '../../utils/colors.dart';
import '../../utils/helpers.dart';
import 'doctor_chat_screen.dart';

class DoctorChatListScreen extends StatefulWidget {
  const DoctorChatListScreen({super.key});
  
  @override
  State<DoctorChatListScreen> createState() => _DoctorChatListScreenState();
}

class _DoctorChatListScreenState extends State<DoctorChatListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final doctor = authProvider.currentUser as DoctorModel;
      Provider.of<DoctorProvider>(context, listen: false).loadPatients(doctor.id);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final authProvider = Provider.of<AuthProvider>(context);
    final doctor = authProvider.currentUser as DoctorModel;
    final doctorProvider = Provider.of<DoctorProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.chat_bubble, size: 24),
            const SizedBox(width: 8),
            Text(l10n.chat),
          ],
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: AppColors.doctorGradient),
        ),
      ),
      body: doctorProvider.patients.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_outline, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No patients yet',
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: doctorProvider.patients.length,
              itemBuilder: (context, index) {
                final patient = doctorProvider.patients[index];
                
                // Premium hastalar için chat göster
                if (!patient.isPremium) {
                  return const SizedBox.shrink();
                }
                
                return StreamBuilder<List<dynamic>>(
                  stream: chatProvider.getChatMessagesStream(doctor.id, patient.id),
                  builder: (context, snapshot) {
                    final messages = snapshot.data ?? [];
                    final lastMessage = messages.isNotEmpty ? messages.last : null;
                    final unreadCount = messages
                        .where((m) => m.receiverId == doctor.id && !m.isRead)
                        .length;
                    
                    // Mesaj yoksa (silinmişse) listede gösterme
                    if (snapshot.connectionState != ConnectionState.waiting && messages.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoctorChatScreen(patient: patient),
                            ),
                          );
                        },
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Delete Chat'),
                              content: Text('Delete all messages with ${patient.name}?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    try {
                                      await chatProvider.deleteAllMessages(doctor.id, patient.id, doctor.id);
                                      Helpers.showSnackBar(context, 'Chat deleted');
                                    } catch (e) {
                                      Helpers.showSnackBar(context, 'Failed to delete chat', isError: true);
                                    }
                                  },
                                  child: const Text('Delete', style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              // Avatar
                              Stack(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColors.premiumGold,
                                        width: 2,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      radius: 28,
                                      backgroundColor: AppColors.premiumGold.withValues(alpha: 0.1),
                                      child: Text(
                                        patient.name[0],
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.premiumGold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (patient.isPremium)
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: const BoxDecoration(
                                          color: AppColors.premiumGold,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.star,
                                          color: Colors.white,
                                          size: 12,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(width: 16),
                              
                              // Patient Info & Last Message
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            patient.name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        if (lastMessage != null)
                                          Text(
                                            Helpers.formatTime(lastMessage.timestamp),
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            lastMessage?.message ?? 'No messages yet',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: unreadCount > 0
                                                  ? Colors.black87
                                                  : Colors.grey[600],
                                              fontWeight: unreadCount > 0
                                                  ? FontWeight.w600
                                                  : FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        if (unreadCount > 0)
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4,
                                            ),
                                            decoration: const BoxDecoration(
                                              gradient: AppColors.doctorGradient,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Text(
                                              '$unreadCount',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
