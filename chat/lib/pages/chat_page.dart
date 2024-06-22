import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue[100],
                maxRadius: 14,
                child: const Text(
                  "TE",
                  style: TextStyle(fontSize: 12),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              const Text(
                "Maria Eli",
                style: TextStyle(
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
                itemBuilder: (_, i) => Text('$i'),
              ),
            ),
            const Divider(
              height: 1,
            ),
            Container(
              color: Colors.white,
              height: 100,
            )
          ],
        ));
  }
}
