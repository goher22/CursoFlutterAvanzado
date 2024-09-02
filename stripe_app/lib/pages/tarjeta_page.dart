import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import '../widgets/total_pay_button.dart';

class TarjetaPage extends StatelessWidget {
  const TarjetaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pagar"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(),
          Hero(
            tag: '4242424242424242',
            child: CreditCardWidget(
              cardNumber: '4242424242424242',
              expiryDate: '01/25',
              cardHolderName: 'Fernando Herrera',
              cvvCode: '213',
              showBackView: false,
              onCreditCardWidgetChange: (p0) {},
            ),
          ),
          const Positioned(
            bottom: 0,
            child: TotalPayButton(),
          ),
        ],
      ),
    );
  }
}
