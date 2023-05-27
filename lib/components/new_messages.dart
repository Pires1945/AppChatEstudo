import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/core/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String _message = '';
  final _messageController = TextEditingController();

  Future<void> _sendMessage() async {
    final user = AuthService().currentUser;

    if (user != null) {
      ChatService().save(_message, user);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _messageController,
            onChanged: (value) => setState(() => _message = value),
            decoration: const InputDecoration(labelText: 'Nova mensagem...'),
            onSubmitted: (value) {
              if (_message.trim().isNotEmpty) {
                _sendMessage();
              }
            },
          ),
        ),
        IconButton(
            onPressed: _message.trim().isEmpty ? null : _sendMessage,
            icon: const Icon(Icons.send))
      ],
    );
  }
}
