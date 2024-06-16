import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/socket_service.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Server Status: ${socketService.serverStatus}"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.message),
        onPressed: () {
          socketService.socket.emit("emitir-mensaje", {
            'nombre': 'Flutter',
            'mensaje': 'Hola desde Flutter',
          });
        },
      ),
    );
  }
}
