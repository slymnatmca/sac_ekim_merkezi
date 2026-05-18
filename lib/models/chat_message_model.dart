class ChatMessageModel {
  final String id;
  final String senderId;
  final String receiverId;
  final String message;
  final String? photoUrl; // Icon name veya URL
  final DateTime timestamp;
  final bool isRead;
  final List<String> deletedFor; // Hangi kullanıcılar için silindiği
  
  ChatMessageModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    this.photoUrl,
    required this.timestamp,
    this.isRead = false,
    this.deletedFor = const [],
  });
  
  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] as String,
      senderId: json['senderId'] as String,
      receiverId: json['receiverId'] as String,
      message: json['message'] as String,
      photoUrl: json['photoUrl'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isRead: json['isRead'] as bool? ?? false,
      deletedFor: (json['deletedFor'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
    );
  }
  
  factory ChatMessageModel.fromMap(Map<String, dynamic> map) {
    return ChatMessageModel(
      id: map['id'] as String,
      senderId: map['senderId'] as String,
      receiverId: map['receiverId'] as String,
      message: map['message'] as String,
      photoUrl: map['photoUrl'] as String?,
      timestamp: DateTime.parse(map['timestamp'] as String),
      isRead: map['isRead'] as bool? ?? false,
      deletedFor: (map['deletedFor'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'photoUrl': photoUrl,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
      'deletedFor': deletedFor,
    };
  }
}
