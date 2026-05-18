import 'package:flutter/material.dart';
import '../models/chat_message_model.dart';
import '../services/firebase_firestore_service.dart';

class ChatProvider with ChangeNotifier {
  final FirebaseFirestoreService _firestoreService = FirebaseFirestoreService();
  
  List<ChatMessageModel> _messages = [];
  bool _isLoading = false;
  
  List<ChatMessageModel> get messages => _messages;
  bool get isLoading => _isLoading;
  
  // Real-time mesajları dinle
  Stream<List<ChatMessageModel>> getChatMessagesStream(String userId1, String userId2) {
    return _firestoreService.getChatMessagesStream(userId1, userId2);
  }
  
  // Mesaj gönder
  Future<void> sendMessage(ChatMessageModel message) async {
    try {
      await _firestoreService.addChatMessage(message);
      notifyListeners();
    } catch (e) {
      print('Error sending message: $e');
      throw Exception('Failed to send message');
    }
  }
  
  // Mesajları yükle (ilk yükleme için)
  Future<void> loadMessages(String userId1, String userId2) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      _messages = await _firestoreService.getChatMessages(userId1, userId2);
    } catch (e) {
      print('Error loading messages: $e');
      _messages = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  // Mesajları okundu olarak işaretle
  Future<void> markAsRead(String messageId) async {
    try {
      // Firestore'da isRead field'ını güncelle
      // Bu özelliği ileride ekleyebiliriz
    } catch (e) {
      print('Error marking message as read: $e');
    }
  }
  
  // Okunmamış mesaj sayısı
  int getUnreadCount(String userId) {
    return _messages.where((m) => m.receiverId == userId && !m.isRead).length;
  }
  
  // Mesaj sil
  Future<void> deleteMessage(String messageId, String userId) async {
    try {
      await _firestoreService.deleteChatMessage(messageId, userId);
      _messages.removeWhere((m) => m.id == messageId);
      notifyListeners();
    } catch (e) {
      print('Error deleting message: $e');
      throw Exception('Failed to delete message');
    }
  }
  
  // Tüm sohbeti sil
  Future<void> deleteAllMessages(String userId1, String userId2, String currentUserId) async {
    try {
      await _firestoreService.deleteAllChatMessages(userId1, userId2, currentUserId);
      _messages.clear();
      notifyListeners();
    } catch (e) {
      print('Error deleting chat: $e');
      throw Exception('Failed to delete chat');
    }
  }
}
