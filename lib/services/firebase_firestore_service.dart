import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../models/patient_model.dart';
import '../models/doctor_model.dart';
import '../models/consultation_model.dart';
import '../models/chat_message_model.dart';

class FirebaseFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ==================== USERS ====================
  
  Future<UserModel?> getUser(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        final data = doc.data()!;
        if (data['role'] == 'patient') {
          return PatientModel.fromMap({...data, 'id': doc.id});
        } else if (data['role'] == 'doctor') {
          return DoctorModel.fromMap({...data, 'id': doc.id});
        }
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get user: ${e.toString()}');
    }
  }

  Future<void> createUser(String userId, Map<String, dynamic> userData) async {
    try {
      await _firestore.collection('users').doc(userId).set(userData);
    } catch (e) {
      throw Exception('Failed to create user: ${e.toString()}');
    }
  }

  Future<void> updateUser(String userId, Map<String, dynamic> updates) async {
    try {
      await _firestore.collection('users').doc(userId).update(updates);
    } catch (e) {
      throw Exception('Failed to update user: ${e.toString()}');
    }
  }

  // ==================== PATIENTS ====================
  
  Future<List<PatientModel>> getPatientsByDoctorId(String doctorId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .where('role', isEqualTo: 'patient')
          .where('doctorId', isEqualTo: doctorId)
          .get();

      return snapshot.docs
          .map((doc) => PatientModel.fromMap({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e) {
      throw Exception('Failed to get patients: ${e.toString()}');
    }
  }

  Future<PatientModel?> getPatient(String patientId) async {
    try {
      final doc = await _firestore.collection('users').doc(patientId).get();
      if (doc.exists && doc.data()?['role'] == 'patient') {
        return PatientModel.fromMap({...doc.data()!, 'id': doc.id});
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get patient: ${e.toString()}');
    }
  }

  // ==================== CONSULTATIONS ====================
  
  Future<List<ConsultationModel>> getConsultationsByPatientId(String patientId) async {
    try {
      final snapshot = await _firestore
          .collection('consultations')
          .where('patientId', isEqualTo: patientId)
          .orderBy('date', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => ConsultationModel.fromMap({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e) {
      throw Exception('Failed to get consultations: ${e.toString()}');
    }
  }

  Future<List<ConsultationModel>> getConsultationsByDoctorId(String doctorId) async {
    try {
      final snapshot = await _firestore
          .collection('consultations')
          .where('doctorId', isEqualTo: doctorId)
          .orderBy('date', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => ConsultationModel.fromMap({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e) {
      throw Exception('Failed to get consultations: ${e.toString()}');
    }
  }

  // Real-time consultation streams
  Stream<List<ConsultationModel>> getConsultationsByDoctorIdStream(String doctorId) {
    return _firestore
        .collection('consultations')
        .where('doctorId', isEqualTo: doctorId)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ConsultationModel.fromMap({...doc.data(), 'id': doc.id}))
            .toList());
  }

  Stream<List<ConsultationModel>> getConsultationsByPatientIdStream(String patientId) {
    return _firestore
        .collection('consultations')
        .where('patientId', isEqualTo: patientId)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ConsultationModel.fromMap({...doc.data(), 'id': doc.id}))
            .toList());
  }

  Future<void> addConsultation(ConsultationModel consultation) async {
    try {
      await _firestore.collection('consultations').doc(consultation.id).set({
        'patientId': consultation.patientId,
        'doctorId': consultation.doctorId,
        'patientNote': consultation.patientNote,
        'doctorComment': consultation.doctorComment,
        'photoUrl': consultation.photoUrl,
        'date': consultation.date.toIso8601String(),
        'isAnswered': consultation.isAnswered,
      });
    } catch (e) {
      throw Exception('Failed to add consultation: ${e.toString()}');
    }
  }

  Future<void> updateConsultation(String consultationId, Map<String, dynamic> updates) async {
    try {
      await _firestore.collection('consultations').doc(consultationId).update(updates);
    } catch (e) {
      throw Exception('Failed to update consultation: ${e.toString()}');
    }
  }

  // ==================== CHAT MESSAGES ====================
  
  Future<List<ChatMessageModel>> getChatMessages(String userId1, String userId2) async {
    try {
      final snapshot = await _firestore
          .collection('chatMessages')
          .where('senderId', whereIn: [userId1, userId2])
          .orderBy('timestamp', descending: false)
          .get();

      return snapshot.docs
          .where((doc) {
            final data = doc.data();
            return (data['senderId'] == userId1 && data['receiverId'] == userId2) ||
                   (data['senderId'] == userId2 && data['receiverId'] == userId1);
          })
          .map((doc) => ChatMessageModel.fromMap({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e) {
      throw Exception('Failed to get chat messages: ${e.toString()}');
    }
  }

  Future<void> addChatMessage(ChatMessageModel message) async {
    try {
      await _firestore.collection('chatMessages').doc(message.id).set({
        'senderId': message.senderId,
        'receiverId': message.receiverId,
        'message': message.message,
        'timestamp': message.timestamp.toIso8601String(),
        'isRead': message.isRead,
      });
    } catch (e) {
      throw Exception('Failed to add chat message: ${e.toString()}');
    }
  }

  Stream<List<ChatMessageModel>> getChatMessagesStream(String userId1, String userId2) {
    return _firestore
        .collection('chatMessages')
        .where('senderId', whereIn: [userId1, userId2])
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .where((doc) {
              final data = doc.data();
              final deletedFor = List<String>.from(data['deletedFor'] ?? []);
              // Bu mesaj bu konuşmaya ait mi?
              final isInConversation =
                  (data['senderId'] == userId1 && data['receiverId'] == userId2) ||
                  (data['senderId'] == userId2 && data['receiverId'] == userId1);
              if (!isInConversation) return false;
              // userId1 bu mesajı sildiyse gösterme
              if (deletedFor.contains(userId1)) return false;
              return true;
            })
            .map((doc) => ChatMessageModel.fromMap({...doc.data(), 'id': doc.id}))
            .toList());
  }

  Future<void> deleteChatMessage(String messageId, String userId) async {
    try {
      final doc = await _firestore.collection('chatMessages').doc(messageId).get();
      if (doc.exists) {
        final deletedFor = List<String>.from(doc.data()?['deletedFor'] ?? []);
        if (!deletedFor.contains(userId)) {
          deletedFor.add(userId);
        }
        await _firestore.collection('chatMessages').doc(messageId).update({
          'deletedFor': deletedFor,
        });
      }
    } catch (e) {
      throw Exception('Failed to delete chat message: ${e.toString()}');
    }
  }

  Future<void> deleteAllChatMessages(String userId1, String userId2, String currentUserId) async {
    try {
      final snapshot = await _firestore
          .collection('chatMessages')
          .where('senderId', whereIn: [userId1, userId2])
          .get();

      final batch = _firestore.batch();
      
      for (var doc in snapshot.docs) {
        final data = doc.data();
        if ((data['senderId'] == userId1 && data['receiverId'] == userId2) ||
            (data['senderId'] == userId2 && data['receiverId'] == userId1)) {
          final deletedFor = List<String>.from(data['deletedFor'] ?? []);
          if (!deletedFor.contains(currentUserId)) {
            deletedFor.add(currentUserId);
          }
          batch.update(doc.reference, {'deletedFor': deletedFor});
        }
      }
      
      await batch.commit();
    } catch (e) {
      throw Exception('Failed to delete chat: ${e.toString()}');
    }
  }
}
