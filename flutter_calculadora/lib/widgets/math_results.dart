import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/calculator_controller.dart';
import 'line_separator.dart';
import 'main_result.dart';
import 'sub_result.dart';

class MathResult extends StatelessWidget {
  final calculatorCtr = Get.find<CalculatorController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          SubResult(text: '${calculatorCtr.firstNumber}'),
          SubResult(text: '${calculatorCtr.operation}'),
          SubResult(text: '${calculatorCtr.secondNumber}'),
          LineSeparator(),
          MainResultText(text: '${calculatorCtr.mathResult}'),
        ],
      ),
    );
  }
}
