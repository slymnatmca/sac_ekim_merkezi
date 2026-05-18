import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import 'firebase_firestore_service.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestoreService _firestoreService = FirebaseFirestoreService();

  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Email/Password ile giriş
  Future<UserModel?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      if (result.user != null) {
        return await _firestoreService.getUser(result.user!.uid);
      }
      return null;
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  // Email/Password ile kayıt
  Future<UserModel?> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String role,
    Map<String, dynamic>? additionalData,
  }) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user != null) {
        final userData = {
          'id': result.user!.uid,
          'email': email,
          'name': name,
          'role': role,
          'createdAt': DateTime.now().toIso8601String(),
          ...?additionalData,
        };

        await _firestoreService.createUser(result.user!.uid, userData);
        return await _firestoreService.getUser(result.user!.uid);
      }
      return null;
    } catch (e) {
      throw Exception('Registration failed: ${e.toString()}');
    }
  }

  // Şifre sıfırlama
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception('Password reset failed: ${e.toString()}');
    }
  }

  // Çıkış
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Kullanıcı bilgilerini güncelle
  Future<void> updateUserProfile({String? displayName, String? photoURL}) async {
    try {
      await _auth.currentUser?.updateDisplayName(displayName);
      await _auth.currentUser?.updatePhotoURL(photoURL);
    } catch (e) {
      throw Exception('Profile update failed: ${e.toString()}');
    }
  }
}
