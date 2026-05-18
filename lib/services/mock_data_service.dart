import '../models/doctor_model.dart';
import '../models/patient_model.dart';
import '../models/care_guide_model.dart';
import '../models/consultation_model.dart';
import '../models/chat_message_model.dart';
import '../models/notification_model.dart';

class MockDataService {
  // Singleton pattern
  static final MockDataService _instance = MockDataService._internal();
  factory MockDataService() => _instance;
  MockDataService._internal();
  
  // Mock Doktorlar
  static final List<DoctorModel> doctors = [
    DoctorModel(
      id: 'doc1',
      email: 'ahmet@clinic.com',
      name: 'Dr. Ahmet Yılmaz',
      specialization: 'Saç Ekim Uzmanı',
      patientIds: ['pat1', 'pat2'],
    ),
    DoctorModel(
      id: 'doc2',
      email: 'ayse@clinic.com',
      name: 'Dr. Ayşe Demir',
      specialization: 'Estetik Cerrah',
      patientIds: ['pat3', 'pat4'],
    ),
    DoctorModel(
      id: 'doc3',
      email: 'mehmet@clinic.com',
      name: 'Dr. Mehmet Kaya',
      specialization: 'Dermatoloji Uzmanı',
      patientIds: ['pat5', 'pat6'],
    ),
  ];
  
  // Mock Hastalar (1-16 hafta arası)
  static final List<PatientModel> patients = [
    // Dr. Ahmet'in hastaları
    PatientModel(
      id: 'pat1',
      email: 'ali@mail.com',
      name: 'Ali Veli',
      isPremium: false,
      transplantDate: DateTime.now().subtract(const Duration(days: 21)), // 3 hafta önce
      doctorId: 'doc1',
    ),
    PatientModel(
      id: 'pat2',
      email: 'fatma@mail.com',
      name: 'Fatma Şahin',
      isPremium: true,
      transplantDate: DateTime.now().subtract(const Duration(days: 77)), // 11 hafta önce
      doctorId: 'doc1',
    ),
    
    // Dr. Ayşe'nin hastaları
    PatientModel(
      id: 'pat3',
      email: 'can@mail.com',
      name: 'Can Öz',
      isPremium: false,
      transplantDate: DateTime.now().subtract(const Duration(days: 7)), // 1 hafta önce
      doctorId: 'doc2',
    ),
    PatientModel(
      id: 'pat4',
      email: 'zeynep@mail.com',
      name: 'Zeynep Arslan',
      isPremium: true,
      transplantDate: DateTime.now().subtract(const Duration(days: 105)), // 15 hafta önce
      doctorId: 'doc2',
    ),
    
    // Dr. Mehmet'in hastaları
    PatientModel(
      id: 'pat5',
      email: 'emre@mail.com',
      name: 'Emre Yıldız',
      isPremium: false,
      transplantDate: DateTime.now().subtract(const Duration(days: 35)), // 5 hafta önce
      doctorId: 'doc3',
    ),
    PatientModel(
      id: 'pat6',
      email: 'selin@mail.com',
      name: 'Selin Aydın',
      isPremium: true,
      transplantDate: DateTime.now().subtract(const Duration(days: 56)), // 8 hafta önce
      doctorId: 'doc3',
    ),
  ];
  
  // Bakım Rehberi (16 hafta)
  static final List<CareGuideModel> careGuides = [
    CareGuideModel(week: 1, titleKey: 'week1Title', descriptionKey: 'week1Desc', tipsKey: 'week1Tips'),
    CareGuideModel(week: 2, titleKey: 'week1Title', descriptionKey: 'week1Desc', tipsKey: 'week1Tips'),
    CareGuideModel(week: 3, titleKey: 'week3Title', descriptionKey: 'week3Desc', tipsKey: 'week3Tips'),
    CareGuideModel(week: 4, titleKey: 'week3Title', descriptionKey: 'week3Desc', tipsKey: 'week3Tips'),
    CareGuideModel(week: 5, titleKey: 'week5Title', descriptionKey: 'week5Desc', tipsKey: 'week5Tips'),
    CareGuideModel(week: 6, titleKey: 'week5Title', descriptionKey: 'week5Desc', tipsKey: 'week5Tips'),
    CareGuideModel(week: 7, titleKey: 'week5Title', descriptionKey: 'week5Desc', tipsKey: 'week5Tips'),
    CareGuideModel(week: 8, titleKey: 'week5Title', descriptionKey: 'week5Desc', tipsKey: 'week5Tips'),
    CareGuideModel(week: 9, titleKey: 'week9Title', descriptionKey: 'week9Desc', tipsKey: 'week9Tips'),
    CareGuideModel(week: 10, titleKey: 'week9Title', descriptionKey: 'week9Desc', tipsKey: 'week9Tips'),
    CareGuideModel(week: 11, titleKey: 'week9Title', descriptionKey: 'week9Desc', tipsKey: 'week9Tips'),
    CareGuideModel(week: 12, titleKey: 'week9Title', descriptionKey: 'week9Desc', tipsKey: 'week9Tips'),
    CareGuideModel(week: 13, titleKey: 'week13Title', descriptionKey: 'week13Desc', tipsKey: 'week13Tips'),
    CareGuideModel(week: 14, titleKey: 'week13Title', descriptionKey: 'week13Desc', tipsKey: 'week13Tips'),
    CareGuideModel(week: 15, titleKey: 'week13Title', descriptionKey: 'week13Desc', tipsKey: 'week13Tips'),
    CareGuideModel(week: 16, titleKey: 'week13Title', descriptionKey: 'week13Desc', tipsKey: 'week13Tips'),
  ];
  
  // Mock Konsültasyonlar
  static List<ConsultationModel> consultations = [
    // Ali Veli'nin konsültasyonları (Basic)
    ConsultationModel(
      id: 'cons1',
      patientId: 'pat1',
      doctorId: 'doc1',
      photoUrl: 'medical_services', // Material icon
      patientNote: 'İlk haftam geçti, hafif şişlik var. Normal mi?',
      doctorComment: 'Evet, bu tamamen normal. Şişlik 3-4 gün içinde azalacaktır. Soğuk kompres uygulayabilirsiniz.',
      date: DateTime.now().subtract(const Duration(days: 21)),
      isAnswered: true,
    ),
    ConsultationModel(
      id: 'cons2',
      patientId: 'pat1',
      doctorId: 'doc1',
      photoUrl: 'photo_camera',
      patientNote: '4. hafta fotoğrafım. Kabuklar döküldü.',
      doctorComment: null,
      date: DateTime.now().subtract(const Duration(days: 2)),
      isAnswered: false,
    ),
    
    // Fatma Şahin'in konsültasyonları (Premium)
    ConsultationModel(
      id: 'cons3',
      patientId: 'pat2',
      doctorId: 'doc1',
      photoUrl: 'healing',
      patientNote: 'Şok dökülme başladı, endişeliyim.',
      doctorComment: 'Endişelenmeyin, bu sürecin doğal bir parçası. Yeni saçlar 3-4 ay içinde çıkacak.',
      date: DateTime.now().subtract(const Duration(days: 35)),
      isAnswered: true,
    ),
    
    // Can Öz'ün konsültasyonları (Basic)
    ConsultationModel(
      id: 'cons4',
      patientId: 'pat3',
      doctorId: 'doc2',
      photoUrl: 'local_hospital',
      patientNote: 'İlk yıkamayı ne zaman yapabilirim?',
      doctorComment: '3. günden sonra özel şampuanla nazikçe yıkayabilirsiniz.',
      date: DateTime.now().subtract(const Duration(days: 10)),
      isAnswered: true,
    ),
    
    // Zeynep Arslan'ın konsültasyonları (Premium)
    ConsultationModel(
      id: 'cons5',
      patientId: 'pat4',
      doctorId: 'doc2',
      photoUrl: 'photo_library',
      patientNote: '12. hafta kontrol fotoğrafları',
      doctorComment: 'Harika ilerleme! Saçlar çok güzel çıkmış.',
      date: DateTime.now().subtract(const Duration(days: 5)),
      isAnswered: true,
    ),
  ];
  
  // Mock Chat Mesajları (Sadece Premium hastalar için)
  static List<ChatMessageModel> chatMessages = [
    // Fatma Şahin - Dr. Ahmet chat
    ChatMessageModel(
      id: 'msg1',
      senderId: 'pat2',
      receiverId: 'doc1',
      message: 'Merhaba doktor, bugün saç dökülmesi arttı.',
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      isRead: true,
    ),
    ChatMessageModel(
      id: 'msg2',
      senderId: 'doc1',
      receiverId: 'pat2',
      message: 'Merhaba Fatma Hanım, bu şok dökülme dönemi için normal. Endişelenmeyin.',
      timestamp: DateTime.now().subtract(const Duration(hours: 4, minutes: 30)),
      isRead: true,
    ),
    ChatMessageModel(
      id: 'msg3',
      senderId: 'pat2',
      receiverId: 'doc1',
      message: 'Teşekkür ederim, rahatladım.',
      timestamp: DateTime.now().subtract(const Duration(hours: 4)),
      isRead: true,
    ),
    
    // Zeynep Arslan - Dr. Ayşe chat
    ChatMessageModel(
      id: 'msg4',
      senderId: 'pat4',
      receiverId: 'doc2',
      message: 'Doktor hanım, yeni saçlar ne zaman uzayacak?',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      isRead: true,
    ),
    ChatMessageModel(
      id: 'msg5',
      senderId: 'doc2',
      receiverId: 'pat4',
      message: '6-12 ay içinde tam uzunluğa ulaşacaklar. Sabırlı olun.',
      timestamp: DateTime.now().subtract(const Duration(hours: 20)),
      isRead: true,
    ),
    
    // Selin Aydın - Dr. Mehmet chat
    ChatMessageModel(
      id: 'msg6',
      senderId: 'pat6',
      receiverId: 'doc3',
      message: 'Saç boyası kullanabilir miyim?',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: false,
    ),
  ];
  
  // Mock Bildirimler
  static List<NotificationModel> notifications = [
    NotificationModel(
      id: 'notif1',
      userId: 'pat1',
      type: 'consultation_reply',
      message: 'Dr. Ahmet Yılmaz konsültasyonunuza cevap verdi',
      isRead: true,
      timestamp: DateTime.now().subtract(const Duration(days: 21)),
    ),
    NotificationModel(
      id: 'notif2',
      userId: 'pat2',
      type: 'chat_message',
      message: 'Dr. Ahmet Yılmaz size mesaj gönderdi',
      isRead: false,
      timestamp: DateTime.now().subtract(const Duration(hours: 4, minutes: 30)),
    ),
    NotificationModel(
      id: 'notif3',
      userId: 'pat4',
      type: 'chat_message',
      message: 'Dr. Ayşe Demir size mesaj gönderdi',
      isRead: false,
      timestamp: DateTime.now().subtract(const Duration(hours: 20)),
    ),
  ];
  
  // Kullanıcı login kontrolü
  static dynamic login(String email, String password) {
    // Şifre kontrolü (hepsi 123456)
    if (password != '123456') return null;
    
    // Doktor kontrolü
    for (var doctor in doctors) {
      if (doctor.email == email) {
        return doctor;
      }
    }
    
    // Hasta kontrolü
    for (var patient in patients) {
      if (patient.email == email) {
        return patient;
      }
    }
    
    return null;
  }
  
  // Doktor ID'sine göre hastaları getir
  static List<PatientModel> getPatientsByDoctorId(String doctorId) {
    return patients.where((p) => p.doctorId == doctorId).toList();
  }
  
  // Hasta ID'sine göre konsültasyonları getir
  static List<ConsultationModel> getConsultationsByPatientId(String patientId) {
    return consultations.where((c) => c.patientId == patientId).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }
  
  // Doktor ID'sine göre konsültasyonları getir
  static List<ConsultationModel> getConsultationsByDoctorId(String doctorId) {
    return consultations.where((c) => c.doctorId == doctorId).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }
  
  // İki kullanıcı arasındaki chat mesajlarını getir
  static List<ChatMessageModel> getChatMessages(String userId1, String userId2) {
    return chatMessages.where((m) => 
      (m.senderId == userId1 && m.receiverId == userId2) ||
      (m.senderId == userId2 && m.receiverId == userId1)
    ).toList()
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
  }
  
  // Kullanıcı bildirimlerini getir
  static List<NotificationModel> getNotificationsByUserId(String userId) {
    return notifications.where((n) => n.userId == userId).toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }
  
  // Okunmamış bildirim sayısı
  static int getUnreadNotificationCount(String userId) {
    return notifications.where((n) => n.userId == userId && !n.isRead).length;
  }
  
  // Cevaplanmamış konsültasyon sayısı (doktor için)
  static int getUnansweredConsultationCount(String doctorId) {
    return consultations.where((c) => c.doctorId == doctorId && !c.isAnswered).length;
  }
  
  // Konsültasyona yorum ekle
  static void addCommentToConsultation(String consultationId, String comment) {
    final index = consultations.indexWhere((c) => c.id == consultationId);
    if (index != -1) {
      consultations[index] = consultations[index].copyWithComment(comment);
    }
  }
  
  // Yeni konsültasyon ekle
  static void addConsultation(ConsultationModel consultation) {
    consultations.add(consultation);
  }
  
  // Yeni chat mesajı ekle
  static void addChatMessage(ChatMessageModel message) {
    chatMessages.add(message);
  }
  
  // Bildirimi okundu olarak işaretle
  static void markNotificationAsRead(String notificationId) {
    final index = notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      notifications[index] = notifications[index].copyAsRead();
    }
  }
}
