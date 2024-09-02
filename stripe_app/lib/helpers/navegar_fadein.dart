import 'package:flutter/material.dart';

Route navegarMapaFadeIn(BuildContext context, Widget page) {
  return PageRouteBuilder(
    pageBuilder: (
      _,
      __,
      ___,
    ) =>
        page,
    transitionDuration: const Duration(
      milliseconds: 300,
    ),
    transitionsBuilder: (
      context,
      animation,
      _,
      child,
    ) {
      return FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ),
        ),
        child: child,
      );
    },
  );
}
