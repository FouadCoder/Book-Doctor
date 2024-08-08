
import 'package:flutter/material.dart';

class MessageWiget extends StatefulWidget {
  final String message;
  final bool isUser;
    const MessageWiget({super.key, required this.message, required this.isUser});

  @override
  State<MessageWiget> createState() => _MessageWigetState();
}

class _MessageWigetState extends State<MessageWiget> {

  @override
  Widget build(BuildContext context) {
        final theme = Theme.of(context);
    final apiMessageColorChat = theme.brightness == Brightness.dark
        ? const Color(0xFF4A4A4A) // Dark Gray for API messages in dark mode
        : const Color.fromARGB(255, 16, 239, 153); // Green for API messages in light mode
    final userMessageColorChat = theme.brightness == Brightness.dark
        ? const Color(0xFF134D37) // Light Gray for user messages in dark mode
        : const Color(0xFFD3D3D3); // Light Gray for user messages in light mode
    return Row(
      mainAxisAlignment: widget.isUser? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: widget.isUser ? userMessageColorChat : apiMessageColorChat
            ),
            margin: const EdgeInsets.only(
              right: 8,
              top: 5,
              bottom: 8
            ),
            padding: const EdgeInsets.all(8),
            alignment: widget.isUser ? Alignment.centerLeft : Alignment.bottomRight,
            child: Text(widget.message , style: const TextStyle(fontSize: 17),),
          ),
        ),
      ],
    );
  }
}