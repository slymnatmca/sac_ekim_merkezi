class NotificationModel {
  final String id;
  final String userId;
  final String type; // 'consultation_reply', 'chat_message', etc.
  final String message;
  final bool isRead;
  final DateTime timestamp;
  
  NotificationModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.message,
    this.isRead = false,
    required this.timestamp,
  });
  
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      type: json['type'] as String,
      message: json['message'] as String,
      isRead: json['isRead'] as bool? ?? false,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'type': type,
      'message': message,
      'isRead': isRead,
      'timestamp': timestamp.toIso8601String(),
    };
  }
  
  // Okundu olarak işaretle
  NotificationModel copyAsRead() {
    return NotificationModel(
      id: id,
      userId: userId,
      type: type,
      message: message,
      isRead: true,
      timestamp: timestamp,
    );
  }
}
