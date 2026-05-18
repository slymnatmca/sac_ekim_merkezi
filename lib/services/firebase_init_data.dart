import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseInitData {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // Test kullanıcılarını ve verileri Firebase'e yükle
  static Future<void> initializeTestData() async {
    try {
      // Önce mevcut test kullanıcılarını kontrol et
      final usersSnapshot = await _firestore.collection('users').limit(1).get();
      if (usersSnapshot.docs.isNotEmpty) {
        print('Test data already exists');
        return;
      }

      print('Initializing test data...');

      // 1. Doktor oluştur
      final doctorCredential = await _auth.createUserWithEmailAndPassword(
        email: 'ahmet@clinic.com',
        password: '123456',
      );

      await _firestore.collection('users').doc(doctorCredential.user!.uid).set({
        'id': doctorCredential.user!.uid,
        'email': 'ahmet@clinic.com',
        'name': 'Dr. Ahmet Yılmaz',
        'role': 'doctor',
        'specialization': 'Hair Transplant Specialist',
        'licenseNumber': 'TR-12345',
        'createdAt': DateTime.now().toIso8601String(),
      });

      final doctorId = doctorCredential.user!.uid;

      // 2. Hasta 1 - Ali (3. hafta, basic)
      final patient1Credential = await _auth.createUserWithEmailAndPassword(
        email: 'ali@mail.com',
        password: '123456',
      );

      await _firestore.collection('users').doc(patient1Credential.user!.uid).set({
        'id': patient1Credential.user!.uid,
        'email': 'ali@mail.com',
        'name': 'Ali Demir',
        'role': 'patient',
        'doctorId': doctorId,
        'transplantDate': DateTime.now().subtract(const Duration(days: 21)).toIso8601String(),
        'isPremium': false,
        'phone': '+90 555 123 4567',
        'createdAt': DateTime.now().toIso8601String(),
      });

      // Ali için konsültasyonlar
      await _firestore.collection('consultations').add({
        'patientId': patient1Credential.user!.uid,
        'doctorId': doctorId,
        'patientNote': 'Saç dökülmesi devam ediyor, normal mi?',
        'doctorComment': 'Evet, bu dönemde saç dökülmesi normaldir. Shock loss dediğimiz bu durum geçicidir.',
        'photoUrl': null,
        'date': DateTime.now().subtract(const Duration(days: 5)).toIso8601String(),
        'isAnswered': true,
      });

      await _firestore.collection('consultations').add({
        'patientId': patient1Credential.user!.uid,
        'doctorId': doctorId,
        'patientNote': 'Kaşıntı oluyor, ne yapmalıyım?',
        'doctorComment': null,
        'photoUrl': null,
        'date': DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
        'isAnswered': false,
      });

      // 3. Hasta 2 - Fatma (11. hafta, premium)
      final patient2Credential = await _auth.createUserWithEmailAndPassword(
        email: 'fatma@mail.com',
        password: '123456',
      );

      await _firestore.collection('users').doc(patient2Credential.user!.uid).set({
        'id': patient2Credential.user!.uid,
        'email': 'fatma@mail.com',
        'name': 'Fatma Kaya',
        'role': 'patient',
        'doctorId': doctorId,
        'transplantDate': DateTime.now().subtract(const Duration(days: 77)).toIso8601String(),
        'isPremium': true,
        'phone': '+90 555 987 6543',
        'createdAt': DateTime.now().toIso8601String(),
      });

      // Fatma için konsültasyon
      await _firestore.collection('consultations').add({
        'patientId': patient2Credential.user!.uid,
        'doctorId': doctorId,
        'patientNote': 'Saçlarım çok güzel çıkıyor, teşekkürler!',
        'doctorComment': 'Harika! Bakım rehberine uyduğunuz için teşekkürler.',
        'photoUrl': null,
        'date': DateTime.now().subtract(const Duration(days: 10)).toIso8601String(),
        'isAnswered': true,
      });

      print('Test data initialized successfully!');
      print('Doctor: ahmet@clinic.com / 123456');
      print('Patient 1: ali@mail.com / 123456');
      print('Patient 2: fatma@mail.com / 123456');
      
      // Çıkış yap (test için)
      await _auth.signOut();
      
    } catch (e) {
      print('Error initializing test data: $e');
    }
  }
}
