import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../bloc/pagar/pagar_bloc.dart';

class TotalPayButton extends StatelessWidget {
  const TotalPayButton({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Total:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "250.55 USD",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          BlocBuilder<PagarBloc, PagarState>(
            builder: (context, state) {
              return _BtnPay(
                pagarState: state,
              );
            },
          )
        ],
      ),
    );
  }
}

class _BtnPay extends StatelessWidget {
  final PagarState pagarState;

  const _BtnPay({
    required this.pagarState,
  });

  @override
  Widget build(BuildContext context) {
    return pagarState.tarjetaActiva
        ? buildButtonTarjeta(context)
        : buildAppleAndGooglePlay(context);
  }

  Widget buildButtonTarjeta(BuildContext context) {
    return MaterialButton(
      height: 45,
      minWidth: 170,
      shape: const StadiumBorder(),
      elevation: 0,
      color: Colors.black,
      child: const Row(
        children: [
          Icon(
            FontAwesomeIcons.creditCard,
            color: Colors.white,
          ),
          Text(
            " Pay",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ],
      ),
      onPressed: () {},
    );
  }

  Widget buildAppleAndGooglePlay(BuildContext context) {
    return MaterialButton(
      height: 45,
      minWidth: 150,
      shape: const StadiumBorder(),
      elevation: 0,
      color: Colors.black,
      child: Row(
        children: [
          Icon(
            Platform.isAndroid
                ? FontAwesomeIcons.google
                : FontAwesomeIcons.apple,
            color: Colors.white,
          ),
          const Text(
            " Pay",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ],
      ),
      onPressed: () {},
    );
  }
}
