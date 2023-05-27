import 'package:chat/core/models/chat_notification.dart';
import 'package:flutter/material.dart';

class ChatNotificationService with ChangeNotifier {
  List<ChatNotification> _itens = [];
  List<ChatNotification> get itens => [..._itens];

  int get itemsCount => _itens.length;

  void add(ChatNotification notification) {
    _itens.add(notification);
    notifyListeners();
  }

  void remove(int index) {
    _itens.removeAt(index);
    notifyListeners();
  }
}
