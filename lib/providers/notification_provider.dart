import 'package:flutter/material.dart';
import '../models/notification_model.dart';
import '../services/mock_data_service.dart';

class NotificationProvider with ChangeNotifier {
  List<NotificationModel> _notifications = [];
  
  List<NotificationModel> get notifications => _notifications;
  
  // Bildirimleri yükle
  void loadNotifications(String userId) {
    _notifications = MockDataService.getNotificationsByUserId(userId);
    notifyListeners();
  }
  
  // Okunmamış bildirim sayısı
  int get unreadCount {
    return _notifications.where((n) => !n.isRead).length;
  }
  
  // Bildirimi okundu olarak işaretle
  void markAsRead(String notificationId) {
    MockDataService.markNotificationAsRead(notificationId);
    
    final index = _notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      _notifications[index] = _notifications[index].copyAsRead();
    }
    
    notifyListeners();
  }
  
  // Tüm bildirimleri okundu olarak işaretle
  void markAllAsRead() {
    for (var notification in _notifications) {
      if (!notification.isRead) {
        MockDataService.markNotificationAsRead(notification.id);
      }
    }
    
    _notifications = _notifications.map((n) => n.copyAsRead()).toList();
    notifyListeners();
  }
}
