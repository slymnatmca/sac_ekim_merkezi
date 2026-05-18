import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../models/doctor_model.dart';
import '../models/patient_model.dart';
import '../utils/constants.dart';
import 'mock_data_service.dart';

class AuthService {
  // Singleton pattern
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();
  
  // Login
  Future<dynamic> login(String email, String password, bool rememberMe) async {
    // Mock data ile login kontrolü
    final user = MockDataService.login(email, password);
    
    if (user != null && rememberMe) {
      // Kullanıcıyı SharedPreferences'a kaydet
      await _saveUser(user);
    }
    
    return user;
  }
  
  // Register (şimdilik mock)
  Future<bool> register({
    required String email,
    required String password,
    required String name,
    required bool isPatient,
    DateTime? transplantDate,
    String? doctorId,
    bool isPremium = false,
  }) async {
    // TODO: Firebase ile gerçek kayıt işlemi yapılacak
    // Şimdilik sadece başarılı dön
    return true;
  }
  
  // Forgot Password (şimdilik mock)
  Future<bool> sendPasswordResetEmail(String email) async {
    // TODO: Firebase ile şifre sıfırlama emaili gönderilecek
    // Şimdilik sadece başarılı dön
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
  
  // Logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.keyUser);
  }
  
  // Kayıtlı kullanıcıyı kontrol et (Auto-login için)
  Future<dynamic> checkSavedUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(AppConstants.keyUser);
    
    if (userJson == null) return null;
    
    try {
      // JSON'dan user type'ı belirle
      final userMap = UserModel.fromJsonString(userJson).toJson();
      final userType = userMap['userType'];
      
      if (userType == AppConstants.userTypeDoctor) {
        return DoctorModel.fromJsonString(userJson);
      } else {
        return PatientModel.fromJsonString(userJson);
      }
    } catch (e) {
      return null;
    }
  }
  
  // Kullanıcıyı kaydet
  Future<void> _saveUser(dynamic user) async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString;
    
    if (user is DoctorModel) {
      jsonString = user.toJsonString();
    } else if (user is PatientModel) {
      jsonString = user.toJsonString();
    } else {
      return;
    }
    
    await prefs.setString(AppConstants.keyUser, jsonString);
  }
}
