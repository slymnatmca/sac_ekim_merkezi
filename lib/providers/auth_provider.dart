import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/doctor_model.dart';
import '../models/patient_model.dart';
import '../models/user_model.dart';
import '../services/firebase_auth_service.dart';
import '../services/firebase_firestore_service.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final FirebaseFirestoreService _firestoreService = FirebaseFirestoreService();
  
  dynamic _currentUser; // DoctorModel veya PatientModel
  bool _isLoading = false;
  String? _errorMessage;
  
  dynamic get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _currentUser != null;
  bool get isDoctor => _currentUser is DoctorModel;
  bool get isPatient => _currentUser is PatientModel;
  
  // Auto-login check (Splash screen için)
  Future<bool> checkAuthentication() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      final user = _authService.currentUser;
      if (user != null) {
        _currentUser = await _firestoreService.getUser(user.uid);
      }
    } catch (e) {
      _currentUser = null;
    }
    
    _isLoading = false;
    notifyListeners();
    
    return _currentUser != null;
  }
  
  // Login
  Future<bool> login(String email, String password, bool rememberMe) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    
    try {
      _currentUser = await _authService.signInWithEmailAndPassword(email, password);
      
      if (_currentUser == null) {
        _errorMessage = 'Invalid email or password';
        _isLoading = false;
        notifyListeners();
        return false;
      }
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Login failed. Please check your credentials.';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
  
  // Logout
  Future<void> logout() async {
    await _authService.signOut();
    _currentUser = null;
    _errorMessage = null;
    notifyListeners();
  }
  
  // Register
  Future<bool> register({
    required String email,
    required String password,
    required String name,
    required bool isPatient,
    DateTime? transplantDate,
    String? doctorId,
    bool isPremium = false,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    
    try {
      final additionalData = isPatient
          ? {
              'transplantDate': transplantDate?.toIso8601String(),
              'doctorId': doctorId,
              'isPremium': isPremium,
              'phone': '',
            }
          : {
              'specialization': 'Hair Transplant Specialist',
              'licenseNumber': '',
            };

      _currentUser = await _authService.registerWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
        role: isPatient ? 'patient' : 'doctor',
        additionalData: additionalData,
      );
      
      _isLoading = false;
      notifyListeners();
      return _currentUser != null;
    } catch (e) {
      _errorMessage = 'Registration failed. Please try again.';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
  
  // Forgot Password
  Future<bool> sendPasswordResetEmail(String email) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    
    try {
      await _authService.sendPasswordResetEmail(email);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to send reset email. Please check the email address.';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
