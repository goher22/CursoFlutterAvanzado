import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  late IO.Socket _socket;
  IO.Socket get socket => _socket;

  ServerStatus _serverStatus = ServerStatus.Connecting;
  ServerStatus get serverStatus => _serverStatus;

  SocketService() {
    _initConfig();
  }

  void _initConfig() {
    _socket = IO.io(
      'http://192.168.101.11:3000',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    _socket.onConnect((_) {
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    _socket.onDisconnect((_) {
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    // socket.on("nuevo-mensaje", (payload) {
    //   print('nuevo-mensaje:');
    //   print('name: ${payload["nombre"] ?? ""}');
    //   print('mensaje: ${payload["mensaje"] ?? ""}');
    // });
  }
}
