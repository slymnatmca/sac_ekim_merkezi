import 'package:flutter/material.dart';
import '../models/consultation_model.dart';
import '../models/chat_message_model.dart';
import '../models/care_guide_model.dart';
import '../services/mock_data_service.dart';
import '../services/firebase_firestore_service.dart';

class PatientProvider with ChangeNotifier {
  final FirebaseFirestoreService _firestoreService = FirebaseFirestoreService();
  
  List<ConsultationModel> _consultations = [];
  List<ChatMessageModel> _chatMessages = [];
  final List<CareGuideModel> _careGuides = MockDataService.careGuides;
  
  List<ConsultationModel> get consultations => _consultations;
  List<ChatMessageModel> get chatMessages => _chatMessages;
  List<CareGuideModel> get careGuides => _careGuides;
  
  // Hasta konsültasyonlarını yükle
  Future<void> loadConsultations(String patientId) async {
    try {
      _consultations = await _firestoreService.getConsultationsByPatientId(patientId);
      notifyListeners();
    } catch (e) {
      print('Error loading consultations: $e');
      _consultations = [];
      notifyListeners();
    }
  }
  
  // Chat mesajlarını yükle
  Future<void> loadChatMessages(String patientId, String doctorId) async {
    try {
      _chatMessages = await _firestoreService.getChatMessages(patientId, doctorId);
      notifyListeners();
    } catch (e) {
      print('Error loading chat messages: $e');
      _chatMessages = [];
      notifyListeners();
    }
  }
  
  // Yeni konsültasyon ekle
  Future<void> addConsultation(ConsultationModel consultation) async {
    try {
      await _firestoreService.addConsultation(consultation);
      _consultations.insert(0, consultation);
      notifyListeners();
    } catch (e) {
      print('Error adding consultation: $e');
      throw Exception('Failed to add consultation');
    }
  }
  
  // Yeni chat mesajı gönder
  Future<void> sendChatMessage(ChatMessageModel message) async {
    try {
      await _firestoreService.addChatMessage(message);
      _chatMessages.add(message);
      notifyListeners();
    } catch (e) {
      print('Error sending chat message: $e');
      throw Exception('Failed to send message');
    }
  }
  
  // Belirli haftanın bakım rehberini al
  CareGuideModel? getCareGuideForWeek(int week) {
    try {
      return _careGuides.firstWhere((guide) => guide.week == week);
    } catch (e) {
      return null;
    }
  }
  
  // Cevaplanmamış konsültasyon sayısı
  int get unansweredCount {
    return _consultations.where((c) => !c.isAnswered).length;
  }
}
