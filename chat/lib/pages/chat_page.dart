import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/chat_service.dart';
import '../widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isWrite = false;
  final List<ChatMessage> _messages = [];
  @override
  Widget build(BuildContext context) {
    final chatService = Provider.of<ChatService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
              child: Text(
                chatService.userFrom.name.substring(0, 2).toUpperCase(),
                style: const TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              chatService.userFrom.name,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 12,
              ),
            )
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (_, i) => _messages[i],
            ),
          ),
          const Divider(
            height: 1,
          ),
          Container(
            color: Colors.white,
            child: _inputChat(),
          )
        ],
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                decoration: const InputDecoration.collapsed(
                  hintText: "Enviar mensaje",
                ),
                controller: _textController,
                focusNode: _focusNode,
                onChanged: (String texto) {
                  setState(() {
                    if (texto.trim().isNotEmpty) {
                      _isWrite = true;
                    } else {
                      _isWrite = false;
                    }
                  });
                },
                onSubmitted: _handleSubmit,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Platform.isIOS
                  ? CupertinoButton(
                      onPressed: _isWrite
                          ? () => _handleSubmit(_textController.text.trim())
                          : null,
                      child: const Text("Enviar"),
                    )
                  : Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: IconTheme(
                        data: IconThemeData(
                          color: Colors.blue[400],
                        ),
                        child: IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          icon: const Icon(Icons.send),
                          onPressed: _isWrite
                              ? () => _handleSubmit(_textController.text.trim())
                              : null,
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  _handleSubmit(String texto) {
    if (texto.isEmpty) return;
    _textController.clear();
    _focusNode.requestFocus();
    final newMessage = ChatMessage(
      text: texto,
      uid: '123',
      animationController: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400),
      ),
    );
    _messages.add(newMessage);
    newMessage.animationController.forward();
    setState(() {
      _isWrite = false;
    });
  }

  @override
  void dispose() {
    for (var message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}
