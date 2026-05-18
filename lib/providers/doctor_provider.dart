import 'package:flutter/material.dart';
import '../models/patient_model.dart';
import '../models/consultation_model.dart';
import '../models/chat_message_model.dart';
import '../services/firebase_firestore_service.dart';

class DoctorProvider with ChangeNotifier {
  final FirebaseFirestoreService _firestoreService = FirebaseFirestoreService();
  
  List<PatientModel> _patients = [];
  List<ConsultationModel> _consultations = [];
  List<ChatMessageModel> _chatMessages = [];
  
  List<PatientModel> get patients => _patients;
  List<ConsultationModel> get consultations => _consultations;
  List<ChatMessageModel> get chatMessages => _chatMessages;
  
  // Doktorun hastalarını yükle
  Future<void> loadPatients(String doctorId) async {
    try {
      _patients = await _firestoreService.getPatientsByDoctorId(doctorId);
      notifyListeners();
    } catch (e) {
      print('Error loading patients: $e');
      _patients = [];
      notifyListeners();
    }
  }
  
  // Doktorun tüm konsültasyonlarını yükle
  Future<void> loadConsultations(String doctorId) async {
    try {
      _consultations = await _firestoreService.getConsultationsByDoctorId(doctorId);
      notifyListeners();
    } catch (e) {
      print('Error loading consultations: $e');
      _consultations = [];
      notifyListeners();
    }
  }
  
  // Real-time konsültasyon stream'i
  Stream<List<ConsultationModel>> getConsultationsStream(String doctorId) {
    return _firestoreService.getConsultationsByDoctorIdStream(doctorId);
  }
  
  // Belirli hastanın konsültasyonlarını al
  List<ConsultationModel> getConsultationsForPatient(String patientId) {
    return _consultations.where((c) => c.patientId == patientId).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }
  
  // Chat mesajlarını yükle
  Future<void> loadChatMessages(String doctorId, String patientId) async {
    try {
      _chatMessages = await _firestoreService.getChatMessages(doctorId, patientId);
      notifyListeners();
    } catch (e) {
      print('Error loading chat messages: $e');
      _chatMessages = [];
      notifyListeners();
    }
  }
  
  // Konsültasyona yorum ekle
  Future<void> addCommentToConsultation(String consultationId, String comment) async {
    try {
      await _firestoreService.updateConsultation(consultationId, {
        'doctorComment': comment,
        'isAnswered': true,
      });
      
      // Local listeyi güncelle
      final index = _consultations.indexWhere((c) => c.id == consultationId);
      if (index != -1) {
        _consultations[index] = _consultations[index].copyWithComment(comment);
      }
      
      notifyListeners();
    } catch (e) {
      print('Error adding comment: $e');
      throw Exception('Failed to add comment');
    }
  }
  
  // Chat mesajı gönder
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
  
  // Cevaplanmamış konsültasyon sayısı
  int get unansweredCount {
    return _consultations.where((c) => !c.isAnswered).length;
  }
  
  // Belirli hastayı ID ile bul
  PatientModel? getPatientById(String patientId) {
    try {
      return _patients.firstWhere((p) => p.id == patientId);
    } catch (e) {
      return null;
    }
  }
}
