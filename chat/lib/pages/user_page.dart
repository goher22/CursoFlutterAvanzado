import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../models/user.dart';
import '../services/socket_service.dart';

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

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          authService.user.name,
          style: const TextStyle(
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
          onPressed: () {
            socketService.disconnect();
            AuthService.deleteToken();
            Navigator.pushReplacementNamed(context, "login");
          },
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: socketService.serverStatus == ServerStatus.Online
                ? Icon(
                    Icons.check_circle,
                    color: Colors.blue[400],
                  )
                : const Icon(
                    Icons.offline_bolt,
                    color: Colors.red,
                  ),
          ),
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _loadUsers,
        header: WaterDropHeader(
          complete: Icon(
            Icons.check,
            color: Colors.blue[400],
          ),
          waterDropColor: Colors.blue[400]!,
        ),
        child: _listViewUsers(),
      ),
    );
  }

  ListView _listViewUsers() {
    return ListView.separated(
      itemCount: users.length,
      separatorBuilder: (_, i) => const Divider(),
      itemBuilder: (_, i) => _userListTitle(users[i]),
    );
  }

  ListTile _userListTitle(User user) {
    return ListTile(
      title: Text(user.name),
      leading: CircleAvatar(
        backgroundColor: Colors.blue[100],
        child: Text(
          user.name.toUpperCase().substring(0, 2),
        ),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: user.online ? Colors.green[300] : Colors.red,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }

  _loadUsers() async {
    await Future.delayed(
      const Duration(milliseconds: 1000),
    );
    _refreshController.refreshCompleted();
  }
}
