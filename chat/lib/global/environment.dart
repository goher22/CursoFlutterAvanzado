import 'dart:io';

abstract class Environments {
  static String apiURL =
      Platform.isAndroid ? '10.0.0.2:3000' : 'localhost:3000';

  static String socketUrl =
      Platform.isAndroid ? 'http://10.0.0.2:3000' : 'http://localhost:3000';
}
