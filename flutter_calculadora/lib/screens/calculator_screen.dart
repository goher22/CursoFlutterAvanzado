import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/calculator_controller.dart';
import '../widgets/calc_button.dart';
import '../widgets/math_results.dart';

class CalculatorScreen extends StatelessWidget {
  final calculatorCtr = Get.put(CalculatorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: Container(),
            ),
            MathResult(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CalculatorButton(
                  text: 'AC',
                  bgColor: Color(0xffA5A5A5),
                  onPressed: () => calculatorCtr.resetAll(),
                ),
                CalculatorButton(
                  text: '+/-',
                  bgColor: Color(0xffA5A5A5),
                  onPressed: () => calculatorCtr.changeNegativePositive(),
                ),
                CalculatorButton(
                  text: 'del',
                  bgColor: Color(0xffA5A5A5),
                  onPressed: () => calculatorCtr.deleteLastEntry(),
                ),
                CalculatorButton(
                  text: '/',
                  bgColor: Color(0xffF0A23B),
                  onPressed: () => calculatorCtr.selectOperation('/'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CalculatorButton(
                  text: '7',
                  onPressed: () => calculatorCtr.addNumber('7'),
                ),
                CalculatorButton(
                  text: '8',
                  onPressed: () => calculatorCtr.addNumber('8'),
                ),
                CalculatorButton(
                  text: '9',
                  onPressed: () => calculatorCtr.addNumber('9'),
                ),
                CalculatorButton(
                  text: 'X',
                  bgColor: Color(0xffF0A23B),
                  onPressed: () => calculatorCtr.selectOperation('X'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CalculatorButton(
                  text: '4',
                  onPressed: () => calculatorCtr.addNumber('4'),
                ),
                CalculatorButton(
                  text: '5',
                  onPressed: () => calculatorCtr.addNumber('5'),
                ),
                CalculatorButton(
                  text: '6',
                  onPressed: () => calculatorCtr.addNumber('6'),
                ),
                CalculatorButton(
                  text: '-',
                  bgColor: Color(0xffF0A23B),
                  onPressed: () => calculatorCtr.selectOperation('-'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CalculatorButton(
                  text: '1',
                  onPressed: () => calculatorCtr.addNumber('1'),
                ),
                CalculatorButton(
                  text: '2',
                  onPressed: () => calculatorCtr.addNumber('2'),
                ),
                CalculatorButton(
                  text: '3',
                  onPressed: () => calculatorCtr.addNumber('3'),
                ),
                CalculatorButton(
                  text: '+',
                  bgColor: Color(0xffF0A23B),
                  onPressed: () => calculatorCtr.selectOperation('+'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CalculatorButton(
                  text: '0',
                  big: true,
                  onPressed: () => calculatorCtr.addNumber('0'),
                ),
                CalculatorButton(
                  text: '.',
                  onPressed: () => calculatorCtr.addDecimalPoint(),
                ),
                CalculatorButton(
                  text: '=',
                  bgColor: Color(0xffF0A23B),
                  onPressed: () => calculatorCtr.calculateResult(),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
