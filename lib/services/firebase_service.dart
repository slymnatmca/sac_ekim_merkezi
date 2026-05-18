// Firebase Service Template
// Bu dosya Firebase entegrasyonu için hazır template içerir
// Şimdilik kullanılmayacak, gelecekte aktif edilecek

/*
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  // Singleton pattern
  static final FirebaseService _instance = FirebaseService._internal();
  factory FirebaseService() => _instance;
  FirebaseService._internal();
  
  // Firebase instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  
  // Initialize Firebase
  Future<void> initialize() async {
    await Firebase.initializeApp();
  }
  
  // Authentication
  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }
  
  Future<User?> registerWithEmailPassword(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      print('Register error: $e');
      return null;
    }
  }
  
  Future<void> signOut() async {
    await _auth.signOut();
  }
  
  Future<void> sendPasswordReset(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
  
  // Firestore - Users
  Future<void> createUserDocument(String uid, Map<String, dynamic> data) async {
    await _firestore.collection('users').doc(uid).set(data);
  }
  
  Future<DocumentSnapshot> getUserDocument(String uid) async {
    return await _firestore.collection('users').doc(uid).get();
  }
  
  // Firestore - Consultations
  Future<void> addConsultation(Map<String, dynamic> data) async {
    await _firestore.collection('consultations').add(data);
  }
  
  Stream<QuerySnapshot> getConsultationsStream(String userId, bool isDoctor) {
    if (isDoctor) {
      return _firestore
          .collection('consultations')
          .where('doctorId', isEqualTo: userId)
          .orderBy('date', descending: true)
          .snapshots();
    } else {
      return _firestore
          .collection('consultations')
          .where('patientId', isEqualTo: userId)
          .orderBy('date', descending: true)
          .snapshots();
    }
  }
  
  // Firestore - Chat
  Future<void> sendMessage(Map<String, dynamic> data) async {
    await _firestore.collection('messages').add(data);
  }
  
  Stream<QuerySnapshot> getChatMessagesStream(String userId1, String userId2) {
    return _firestore
        .collection('messages')
        .where('participants', arrayContains: userId1)
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
  
  // Storage - Upload Photo
  Future<String?> uploadPhoto(String path, List<int> bytes) async {
    try {
      final ref = _storage.ref().child(path);
      await ref.putData(bytes);
      return await ref.getDownloadURL();
    } catch (e) {
      print('Upload error: $e');
      return null;
    }
  }
  
  // Firestore - Notifications
  Future<void> createNotification(Map<String, dynamic> data) async {
    await _firestore.collection('notifications').add(data);
  }
  
  Stream<QuerySnapshot> getNotificationsStream(String userId) {
    return _firestore
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
*/

// Şimdilik boş class
class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();
  factory FirebaseService() => _instance;
  FirebaseService._internal();
  
  // Firebase entegrasyonu için hazır
  // Yukarıdaki yorumları kaldırıp kullanabilirsiniz
}
