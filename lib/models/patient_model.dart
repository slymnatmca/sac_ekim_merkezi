import 'dart:convert';
import 'user_model.dart';

class PatientModel extends UserModel {
  final bool isPremium;
  final DateTime transplantDate;
  final String doctorId;
  
  PatientModel({
    required super.id,
    required super.email,
    required super.name,
    required this.isPremium,
    required this.transplantDate,
    required this.doctorId,
  }) : super(userType: 'patient');
  
  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      isPremium: json['isPremium'] as bool,
      transplantDate: DateTime.parse(json['transplantDate'] as String),
      doctorId: json['doctorId'] as String,
    );
  }
  
  factory PatientModel.fromMap(Map<String, dynamic> map) {
    return PatientModel(
      id: map['id'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      isPremium: map['isPremium'] as bool? ?? false,
      transplantDate: DateTime.parse(map['transplantDate'] as String),
      doctorId: map['doctorId'] as String,
    );
  }
  
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'userType': userType,
      'isPremium': isPremium,
      'transplantDate': transplantDate.toIso8601String(),
      'doctorId': doctorId,
    };
  }
  
  @override
  String toJsonString() {
    return jsonEncode(toJson());
  }
  
  static PatientModel fromJsonString(String jsonString) {
    return PatientModel.fromJson(jsonDecode(jsonString));
  }
  
  // Kaçıncı haftada olduğunu hesapla
  int get currentWeek {
    final now = DateTime.now();
    final difference = now.difference(transplantDate);
    return (difference.inDays / 7).floor() + 1;
  }
}
