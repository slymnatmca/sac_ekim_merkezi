import 'dart:convert';

// Base User Model
class UserModel {
  final String id;
  final String email;
  final String name;
  final String userType; // 'patient' veya 'doctor'
  
  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.userType,
  });
  
  // JSON'dan model oluştur
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      userType: json['userType'] as String,
    );
  }
  
  // Model'i JSON'a çevir
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'userType': userType,
    };
  }
  
  // SharedPreferences için string encode
  String toJsonString() {
    return jsonEncode(toJson());
  }
  
  // SharedPreferences'tan decode
  static UserModel fromJsonString(String jsonString) {
    return UserModel.fromJson(jsonDecode(jsonString));
  }
}
