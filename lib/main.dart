import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Simple Calculator",
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const Scaffold(
        body: Calculator(),
      ),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String expression = "";
  String answer = '';
  var number = TextEditingController();
  late String textBeforeCursor;
  late String textAfterCursor;
  late int cursorPosition;

  void setText(String num) {
    setState(() {
      number.text += num;
    });
  }

  FocusNode myFocusNode = FocusNode();

  Widget buildButton(String buttonText, String buttonType) {
    if (buttonType == 'number') {
      return Expanded(
          child: TextButton(
              onPressed: () {
                set(buttonText);
                setAnswer();
              },
              child: Text(
                buttonText,
                style: const TextStyle(fontSize: 35, color: Colors.white),
              )));
    } else if (buttonType == 'point') {
      return Expanded(
          child: TextButton(
              onPressed: () {
                textBeforeCursor =
                    number.text.substring(0, number.selection.baseOffset);
                if (!searchFunction(number.text, '.')) {
                  if (number.text != "" &&
                      textBeforeCursor[textBeforeCursor.length - 1] != '÷' &&
                      textBeforeCursor[textBeforeCursor.length - 1] != '×' &&
                      textBeforeCursor[textBeforeCursor.length - 1] != '–' &&
                      textBeforeCursor[textBeforeCursor.length - 1] != '+') {
                    textBeforeCursor =
                        number.text.substring(0, number.selection.baseOffset);
                    String textAfterCursor =
                        number.text.substring(number.selection.extentOffset);
                    number.text = '$textBeforeCursor.$textAfterCursor';
                    cursorPosition = textBeforeCursor.length + 1;
                    number.selection =
                        TextSelection.collapsed(offset: cursorPosition);
                  } else {
                    textBeforeCursor =
                        '${number.text.substring(0, number.selection.baseOffset)}0';
                    String textAfterCursor =
                        number.text.substring(number.selection.extentOffset);
                    number.text = '$textBeforeCursor.$textAfterCursor';
                    cursorPosition = textBeforeCursor.length + 1;
                    number.selection =
                        TextSelection.collapsed(offset: cursorPosition);
                  }
                  myFocusNode.requestFocus();
                }
                setAnswer();
                myFocusNode.requestFocus();
              },
              child: const Text(".",
                  style: TextStyle(fontSize: 35, color: Colors.white))));
    } else if (buttonType == 'operation') {
      if (buttonText == '%') {
        return Expanded(
            child: TextButton(
                onPressed: () {
                  if (number.text != "") {
                    textBeforeCursor =
                        number.text.substring(0, number.selection.baseOffset);
                    textAfterCursor =
                        number.text.substring(number.selection.extentOffset);
                    number.text = '$textBeforeCursor%$textAfterCursor';
                    cursorPosition = textBeforeCursor.length + 1;
                    number.selection =
                        TextSelection.collapsed(offset: cursorPosition);
                    myFocusNode.requestFocus();
                  }
                  setAnswer();
                },
                child: const Text(
                  "%",
                  style: TextStyle(fontSize: 35, color: Colors.white),
                )));
      } else if (buttonText == "-") {
        return Expanded(
          child: TextButton(
              onPressed: () {
                if (number.text != "") {
                  textBeforeCursor =
                      number.text.substring(0, number.selection.baseOffset);
                  if (textBeforeCursor[textBeforeCursor.length - 1] == '–' ||
                      textBeforeCursor[textBeforeCursor.length - 1] == '+') {
                    textBeforeCursor = textBeforeCursor.substring(
                        0, textBeforeCursor.length - 1);
                  }
                  textAfterCursor =
                      number.text.substring(number.selection.extentOffset);
                  number.text = '$textBeforeCursor–$textAfterCursor';
                  cursorPosition = textBeforeCursor.length + 1;
                  number.selection =
                      TextSelection.collapsed(offset: cursorPosition);
                  myFocusNode.requestFocus();
                } else {
                  cursorPosition = 1;
                  setText("–");
                  myFocusNode.requestFocus();
                  number.selection =
                      TextSelection.collapsed(offset: cursorPosition);
                  myFocusNode.requestFocus();
                }
                setAnswer();
              },
              child: const Text("–",
                  style: TextStyle(
                    fontSize: 35,
                  ))),
        );
      } else if (buttonText == '⌫') {
        return Expanded(
          child: TextButton(
              onPressed: () {
                if (number.text.isNotEmpty) {
                  String textBeforeCursor =
                      number.text.substring(0, number.selection.baseOffset);
                  cursorPosition = number.selection.baseOffset;
                  number.selection =
                      TextSelection.collapsed(offset: cursorPosition);
                  myFocusNode.requestFocus();
                  if (number.text != "" && textBeforeCursor != "") {
                    cursorPosition = cursorPosition - 1;
                    String textAfterCursor =
                        number.text.substring(number.selection.extentOffset);
                    number.text = number.text.substring(0, cursorPosition) +
                        textAfterCursor;
                    number.selection =
                        TextSelection.collapsed(offset: cursorPosition);
                    myFocusNode.requestFocus();
                  }
                }

                setAnswer();
                myFocusNode.requestFocus();
              },
              onLongPress: () {
                number.text = "";
                setState(() {answer = '';});
              },
              child: const Text("⌫",
                  style: TextStyle(
                    fontSize: 30,
                  ))),
        );
      } else if (buttonText == '=') {
        return SizedBox(
          height: 130,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
                onPressed: () {
                  setAnswer();
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.purple,
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text(
                  "=",
                  style: TextStyle(
                    fontSize: 35,
                  ),
                )),
          ),
        );
      } else {
        return Expanded(
            child: TextButton(
                onPressed: () {
                  if (number.text.isNotEmpty) {
                    setSymbol(buttonText);
                  }
                },
                child: Text(buttonText,
                    style: const TextStyle(
                      fontSize: 50,
                    ))));
      }
    }
    return Expanded(
        child: TextButton(
      onPressed: () {
        myFocusNode.requestFocus();
        number.text = "";
        setState(() {
          answer = '';
        });
      },
      child: Text(
        buttonText,
        style: const TextStyle(
          fontSize: 35,
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.black87,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 150),
                  child: TextField(
                    keyboardType: TextInputType.none,
                    textAlign: TextAlign.right,
                    controller: number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    style: const TextStyle(fontSize: 70, color: Colors.white),
                    focusNode: myFocusNode,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    answer,
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 40, color: Colors.grey),
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.black87,
            child: Row(children: [
              Expanded(
                child: Column(
                  children: [
                    buildButton('C', ''),
                    buildButton('7', 'number'),
                    buildButton('4', 'number'),
                    buildButton('1', 'number'),
                    buildButton('%', 'operation'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    buildButton('÷', 'operation'),
                    buildButton('8', 'number'),
                    buildButton('5', 'number'),
                    buildButton('2', 'number'),
                    buildButton('0', 'number'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    buildButton('×', 'operation'),
                    buildButton('9', 'number'),
                    buildButton('6', 'number'),
                    buildButton('3', 'number'),
                    buildButton('.', 'point')
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    buildButton('⌫', 'operation'),
                    buildButton('-', 'operation'),
                    buildButton('+', 'operation'),
                    buildButton('=', 'operation'),
                  ],
                ),
              )
            ]),
          ),
        )
      ],
    );
  }

  bool searchFunction(String myString, String searchValue) {
    if (myString == searchValue) {
      return true;
    }
    int count = 0;
    var searchFor = searchValue.split(" ");
    for (final searchWord in searchFor) {
      if (myString.contains(searchWord)) {
        count++;
      }
    }
    return count == searchFor.length;
  }

  void set(String s) {
    if (number.text == "") {
      setText(s);
    } else {
      textBeforeCursor = number.text.substring(0, number.selection.baseOffset);
      String textAfterCursor =
          number.text.substring(number.selection.extentOffset);
      number.text = textBeforeCursor + s + textAfterCursor;
      cursorPosition = textBeforeCursor.length + 1;
      number.selection = TextSelection.collapsed(offset: cursorPosition);
    }
    myFocusNode.requestFocus();
  }

  void setSymbol(String s) {
    if (number.text[0] == '–') {
      number.text = number.text.substring(1, number.text.length);
    } else if (number.text.isNotEmpty) {
      textBeforeCursor = number.text.substring(0, number.selection.baseOffset);
      if (textBeforeCursor[textBeforeCursor.length - 1] == '÷' ||
          textBeforeCursor[textBeforeCursor.length - 1] == '×' ||
          textBeforeCursor[textBeforeCursor.length - 1] == '–' ||
          textBeforeCursor[textBeforeCursor.length - 1] == '+') {
        textBeforeCursor =
            textBeforeCursor.substring(0, textBeforeCursor.length - 1);
      }
      if (textBeforeCursor[textBeforeCursor.length - 1] == '÷' ||
          textBeforeCursor[textBeforeCursor.length - 1] == '×' ||
          textBeforeCursor[textBeforeCursor.length - 1] == '–' ||
          textBeforeCursor[textBeforeCursor.length - 1] == '+') {
        textBeforeCursor =
            textBeforeCursor.substring(0, textBeforeCursor.length - 1);
      }
      textAfterCursor = number.text.substring(number.selection.extentOffset);
      number.text = textBeforeCursor + s + textAfterCursor;
      cursorPosition = textBeforeCursor.length + 1;
      number.selection = TextSelection.collapsed(offset: cursorPosition);
    }
    myFocusNode.requestFocus();
  }

  void setAnswer() {
    expression = number.text;
    expression = expression.replaceAll('×', '*');
    expression = expression.replaceAll('÷', '/');
    expression = expression.replaceAll('–', '-');
    expression = expression.replaceAll('%', '/100');
    try {
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      setState(() {
        if(searchFunction(expression, '+') || searchFunction(expression, '-') || searchFunction(expression, '*') || searchFunction(expression, '/') || searchFunction(expression,'/100')){
          answer = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }
      });
    } catch (e) {
      setState(() {answer = '';});
    }
  }
}
