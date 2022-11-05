import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Simple Calculator",
      theme: ThemeData(primarySwatch: Colors.purple),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
        ),
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
  late double number1;
  late double number2;
  var number = TextEditingController();
  late String textBeforeCursor;
  late String textAfterCursor;
  bool symbol = false;
  late int cursorPosition;

  void setText(String num) {
    setState(() {
      number.text += num;
    });
  }

  FocusNode myFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.black87,
              alignment: Alignment.center,
              child: TextField(
                keyboardType: TextInputType.none,
                textAlign: TextAlign.right,
                controller: number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
                style: TextStyle(fontSize: 70, color: Colors.white),
                focusNode: myFocusNode,
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
                      Expanded(
                          child: TextButton(
                        onPressed: () {
                          number.text = "";
                        },
                        child: Text(
                          "C",
                          style: TextStyle(
                            fontSize: 35,
                          ),
                        ),
                      )),
                      Expanded(
                          child: TextButton(
                              onPressed: () {
                                set('7');
                              },
                              child: Text(
                                "7",
                                style: TextStyle(
                                    fontSize: 35, color: Colors.white),
                              ))),
                      Expanded(
                          child: TextButton(
                              onPressed: () {
                                set('4');
                              },
                              child: Text("4",
                                  style: TextStyle(
                                      fontSize: 35, color: Colors.white)))),
                      Expanded(
                          child: TextButton(
                              onPressed: () {
                                set('1');
                              },
                              child: Text("1",
                                  style: TextStyle(
                                      fontSize: 35, color: Colors.white)))),
                      Expanded(
                          child: TextButton(
                              onPressed: () {
                                if (number.text != "") {
                                  textBeforeCursor = number.text.substring(
                                      0, number.selection.baseOffset);
                                  textAfterCursor = number.text
                                      .substring(number.selection.extentOffset);
                                  number.text =
                                      textBeforeCursor + '%' + textAfterCursor;
                                  cursorPosition = textBeforeCursor.length + 1;
                                  number.selection = TextSelection.collapsed(
                                      offset: cursorPosition);
                                  myFocusNode.requestFocus();
                                }
                                symbol = true;
                              },
                              child: Text(
                                "%",
                                style: TextStyle(
                                    fontSize: 35, color: Colors.white),
                              ))),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                          child: TextButton(
                              onPressed: () {
                                setSymbol("÷");
                              },
                              child: Text("÷",
                                  style: TextStyle(
                                    fontSize: 50,
                                  )))),
                      Expanded(
                          child: TextButton(
                              onPressed: () {
                                set("8");
                              },
                              child: Text("8",
                                  style: TextStyle(
                                      fontSize: 35, color: Colors.white)))),
                      Expanded(
                          child: TextButton(
                              onPressed: () {
                                set('5');
                              },
                              child: Text("5",
                                  style: TextStyle(
                                      fontSize: 35, color: Colors.white)))),
                      Expanded(
                          child: TextButton(
                              onPressed: () {
                                set('2');
                              },
                              child: Text("2",
                                  style: TextStyle(
                                      fontSize: 35, color: Colors.white)))),
                      Expanded(
                          child: TextButton(
                              onPressed: () {
                                set('0');
                              },
                              child: Text("0",
                                  style: TextStyle(
                                      fontSize: 35, color: Colors.white)))),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                          child: TextButton(
                              onPressed: () {
                                setSymbol('×');
                              },
                              child: Text("×",
                                  style: TextStyle(
                                    fontSize: 50,
                                  )))),
                      Expanded(
                          child: TextButton(
                              onPressed: () {
                                set('9');
                              },
                              child: Text("9",
                                  style: TextStyle(
                                      fontSize: 35, color: Colors.white)))),
                      Expanded(
                          child: TextButton(
                              onPressed: () {
                                set('6');
                              },
                              child: Text("6",
                                  style: TextStyle(
                                      fontSize: 35, color: Colors.white)))),
                      Expanded(
                          child: TextButton(
                              onPressed: () {
                                set('3');
                              },
                              child: Text("3",
                                  style: TextStyle(
                                      fontSize: 35, color: Colors.white)))),
                      Expanded(
                          child: TextButton(
                              onPressed: () {
                                textBeforeCursor = number.text.substring(0, number.selection.baseOffset);
                                if (!searchFunction(number.text, '.')) {
                                  if (number.text != "" && textBeforeCursor[textBeforeCursor.length - 1] != '÷' &&
                                  textBeforeCursor[textBeforeCursor.length - 1] != '×' &&
                                  textBeforeCursor[textBeforeCursor.length - 1] != '–' &&
                                  textBeforeCursor[textBeforeCursor.length - 1] != '+') {
                                    textBeforeCursor = number.text.substring(
                                        0, number.selection.baseOffset);
                                    String textAfterCursor = number.text
                                        .substring(
                                            number.selection.extentOffset);
                                    number.text = textBeforeCursor +
                                        '.' +
                                        textAfterCursor;
                                    cursorPosition =
                                        textBeforeCursor.length + 1;
                                    number.selection = TextSelection.collapsed(
                                        offset: cursorPosition);
                                  }
                                  else{
                                    textBeforeCursor = number.text.substring(
                                        0, number.selection.baseOffset) + '0';
                                    String textAfterCursor = number.text
                                        .substring(
                                        number.selection.extentOffset);
                                    number.text = textBeforeCursor +
                                        '.' +
                                        textAfterCursor;
                                    cursorPosition =
                                        textBeforeCursor.length + 1;
                                    number.selection = TextSelection.collapsed(
                                        offset: cursorPosition);
                                  }
                                  symbol = false;
                                  myFocusNode.requestFocus();
                                }
                                myFocusNode.requestFocus();
                              },
                              child: Text(".",
                                  style: TextStyle(
                                      fontSize: 35, color: Colors.white)))),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: TextButton(
                            onPressed: () {
                              String textBeforeCursor = number.text
                                  .substring(0, number.selection.baseOffset);
                              cursorPosition = number.selection.baseOffset;
                              number.selection = TextSelection.collapsed(
                                  offset: cursorPosition);
                              if (number.text != "" && textBeforeCursor != "") {
                                cursorPosition = cursorPosition - 1;
                                String textAfterCursor = number.text
                                    .substring(number.selection.extentOffset);
                                number.text =
                                    number.text.substring(0, cursorPosition) +
                                        textAfterCursor;

                                number.selection = TextSelection.collapsed(
                                    offset: cursorPosition);
                                myFocusNode.requestFocus();
                              }
                              myFocusNode.requestFocus();
                            },
                            onLongPress: () {
                              number.text = "";
                            },
                            child: Text("⌫",
                                style: TextStyle(
                                  fontSize: 30,
                                ))),
                      ),
                      Expanded(
                        child: TextButton(
                            onPressed: () {
                                textBeforeCursor = number.text
                                    .substring(0, number.selection.baseOffset);
                                if (textBeforeCursor[
                                            textBeforeCursor.length - 1] ==
                                        '–' ||
                                    textBeforeCursor[
                                            textBeforeCursor.length - 1] ==
                                        '+') {
                                  textBeforeCursor = textBeforeCursor.substring(
                                      0, textBeforeCursor.length - 1);
                                }
                                textAfterCursor = number.text
                                    .substring(number.selection.extentOffset);
                                number.text =
                                    textBeforeCursor + '–' + textAfterCursor;
                                cursorPosition = textBeforeCursor.length + 1;
                                number.selection = TextSelection.collapsed(
                                    offset: cursorPosition);
                              myFocusNode.requestFocus();
                            },
                            child: Text("–",
                                style: TextStyle(
                                  fontSize: 35,
                                ))),
                      ),
                      Expanded(
                        child: TextButton(
                            onPressed: () {
                              setSymbol('+');
                            },
                            child: Text("+",
                                style: TextStyle(
                                  fontSize: 35,
                                ))),
                      ),
                      // Divider(),
                      Container(
                        height: 130,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.purple,
                                shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              child: Text(
                                "=",
                                style: TextStyle(
                                  fontSize: 35,
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                )
              ]),
            ),
          )
        ],
      ),
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
    if (number.text != '') {
      textBeforeCursor = number.text.substring(0, number.selection.baseOffset);
      if (textBeforeCursor[textBeforeCursor.length - 1] == '÷' ||
          textBeforeCursor[textBeforeCursor.length - 1] == '×' ||
          textBeforeCursor[textBeforeCursor.length - 1] == '–' ||
          textBeforeCursor[textBeforeCursor.length - 1] == '+') {
        textBeforeCursor =
            textBeforeCursor.substring(0, textBeforeCursor.length - 1);
      }
      if(textBeforeCursor[textBeforeCursor.length - 1] == '÷' ||
          textBeforeCursor[textBeforeCursor.length - 1] == '×' ||
          textBeforeCursor[textBeforeCursor.length - 1] == '–' ||
          textBeforeCursor[textBeforeCursor.length - 1] == '+'){
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
}
