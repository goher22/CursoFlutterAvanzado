import 'package:flutter/material.dart';

mostrarLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => const AlertDialog(
      title: Text("Espere..."),
      content: LinearProgressIndicator(),
    ),
  );
}

mostrarAlerta(BuildContext context, String title, String msg) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: [
        MaterialButton(
          child: const Text("Ok"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ),
  );
}
