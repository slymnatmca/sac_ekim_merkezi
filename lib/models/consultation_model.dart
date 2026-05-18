class ConsultationModel {
  final String id;
  final String patientId;
  final String doctorId;
  final String? photoUrl; // Icon name veya URL
  final String patientNote;
  final String? doctorComment;
  final DateTime date;
  final bool isAnswered;
  
  ConsultationModel({
    required this.id,
    required this.patientId,
    required this.doctorId,
    this.photoUrl,
    required this.patientNote,
    this.doctorComment,
    required this.date,
    required this.isAnswered,
  });
  
  factory ConsultationModel.fromJson(Map<String, dynamic> json) {
    return ConsultationModel(
      id: json['id'] as String,
      patientId: json['patientId'] as String,
      doctorId: json['doctorId'] as String,
      photoUrl: json['photoUrl'] as String?,
      patientNote: json['patientNote'] as String,
      doctorComment: json['doctorComment'] as String?,
      date: DateTime.parse(json['date'] as String),
      isAnswered: json['isAnswered'] as bool,
    );
  }
  
  factory ConsultationModel.fromMap(Map<String, dynamic> map) {
    return ConsultationModel(
      id: map['id'] as String,
      patientId: map['patientId'] as String,
      doctorId: map['doctorId'] as String,
      photoUrl: map['photoUrl'] as String?,
      patientNote: map['patientNote'] as String,
      doctorComment: map['doctorComment'] as String?,
      date: DateTime.parse(map['date'] as String),
      isAnswered: map['isAnswered'] as bool? ?? false,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'doctorId': doctorId,
      'photoUrl': photoUrl,
      'patientNote': patientNote,
      'doctorComment': doctorComment,
      'date': date.toIso8601String(),
      'isAnswered': isAnswered,
    };
  }
  
  // Yorum eklenmiş kopya oluştur
  ConsultationModel copyWithComment(String comment) {
    return ConsultationModel(
      id: id,
      patientId: patientId,
      doctorId: doctorId,
      photoUrl: photoUrl,
      patientNote: patientNote,
      doctorComment: comment,
      date: date,
      isAnswered: true,
    );
  }
}
