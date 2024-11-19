import 'package:flutter/material.dart';
import '../models/message_model.dart';

class MessageBubble extends StatelessWidget {
  final MessageModel message;

  const MessageBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isUserMessage = message.type == MessageType.user;

    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUserMessage ? Colors.blue[100] : Colors.grey[200],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isUserMessage) 
              Icon(Icons.android, color: Colors.blue),
            SizedBox(width: 8),
            Flexible(
              child: Text(
                message.text,
                style: TextStyle(
                  color: isUserMessage ? Colors.black87 : Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}