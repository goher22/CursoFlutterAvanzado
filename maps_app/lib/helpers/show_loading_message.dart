import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showLoadingMessage(BuildContext context) {
  if (Platform.isAndroid) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        title: Text("Espere por favor"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Calculado Ruta"),
            SizedBox(
              height: 15,
            ),
            CircularProgressIndicator(
              strokeWidth: 3,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
    return;
  } else {
    showCupertinoDialog(
      context: context,
      builder: (context) => const CupertinoAlertDialog(
        title: Text("Espere por favor"),
        content: CupertinoActivityIndicator(),
      ),
    );
  }
}
