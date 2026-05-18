import 'dart:convert';
import 'user_model.dart';

class DoctorModel extends UserModel {
  final String specialization;
  final List<String> patientIds;
  
  DoctorModel({
    required super.id,
    required super.email,
    required super.name,
    required this.specialization,
    required this.patientIds,
  }) : super(userType: 'doctor');
  
  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      specialization: json['specialization'] as String,
      patientIds: List<String>.from(json['patientIds'] as List),
    );
  }
  
  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      id: map['id'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      specialization: map['specialization'] as String? ?? 'Hair Transplant Specialist',
      patientIds: map['patientIds'] != null ? List<String>.from(map['patientIds'] as List) : [],
    );
  }
  
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'userType': userType,
      'specialization': specialization,
      'patientIds': patientIds,
    };
  }
  
  @override
  String toJsonString() {
    return jsonEncode(toJson());
  }
  
  static DoctorModel fromJsonString(String jsonString) {
    return DoctorModel.fromJson(jsonDecode(jsonString));
  }
}
