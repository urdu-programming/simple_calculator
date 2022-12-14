import 'package:flutter/material.dart';

import '../logic/logics.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: const Color(0xff3c4258),
        child: Row(children: [
          Expanded(
            child: Column(
              children: [
                buildButton('C', ''),
                buildButton('8', 'number'),
                buildButton('5', 'number'),
                buildButton('2', 'number'),
                buildButton('.', 'point')

              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                buildButton('÷', 'operation'),
                buildButton('9', 'number'),
                buildButton('6', 'number'),
                buildButton('3', 'number'),
                buildButton('0', 'number'),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                buildButton('×', 'operation'),
                buildButton('(', 'operation'),
                buildButton('7', 'number'),
                buildButton('4', 'number'),
                buildButton('1', 'number'),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                buildButton('⌫', 'operation'),
                buildButton(')', 'operation'),
                buildButton('–', 'operation'),
                buildButton('+', 'operation'),
                buildButton('=', 'operation'),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
