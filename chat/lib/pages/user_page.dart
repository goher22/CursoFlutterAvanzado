import 'package:flutter/material.dart';

import '../models/user.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({super.key});

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final users = [
    User(uid: '1', name: 'Eli', email: 'text1@tes.com', online: true),
    User(uid: '2', name: 'Marina', email: 'text2@tes.com', online: true),
    User(uid: '3', name: 'Juan', email: 'text3@tes.com', online: false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mi nombre",
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.exit_to_app,
            color: Colors.black87,
          ),
          onPressed: () {},
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: Icon(
              Icons.check_circle,
              color: Colors.blue[400],
            ),
            //     const Icon(
            //   Icons.offline_bolt,
            //   color: Colors.red,
            // ),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: users.length,
        separatorBuilder: (_, i) => Divider(),
        itemBuilder: (_, i) => ListTile(
          title: Text(users[i].name),
          leading: CircleAvatar(
            child: Text(
              users[i].name.toUpperCase().substring(0, 2),
            ),
          ),
          trailing: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: users[i].online ? Colors.green[300] : Colors.red,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
      ),
    );
  }
}
