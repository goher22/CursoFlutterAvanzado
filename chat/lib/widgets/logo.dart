import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170,
        margin: const EdgeInsets.only(top: 50),
        child: const Column(
          children: [
            Image(
              image: AssetImage("assets/tag-logo.png"),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Messenger",
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
