import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  bool symbol = false;

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

                controller: number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
                style: TextStyle(fontSize: 70, color: Colors.white),
                focusNode: myFocusNode,
                textDirection: TextDirection.rtl,
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
                                if(number.text == ""){
                                  setText('7');
                                }
                                else {
                                  String textBeforeCursor = number.text
                                      .substring(
                                      0, number.selection.baseOffset);
                                  String textAfterCursor = number.text
                                      .substring(number.selection.extentOffset);
                                  number.text =
                                      textBeforeCursor + '7' + textAfterCursor;
                                  int cursorPosition = textBeforeCursor.length +
                                      1;
                                  number.selection = TextSelection.collapsed(
                                      offset: cursorPosition);
                                }
                                symbol = false;
                                myFocusNode.requestFocus();
                              },
                              child: Text(
                                "7",
                                style: TextStyle(
                                    fontSize: 35, color: Colors.white),
                              ))),
                      Expanded(
                          child: TextButton(
                              onPressed: () {
                                if(number.text == ""){
                                  setText('4');
                                }
                                else {
                                  String textBeforeCursor = number.text
                                      .substring(
                                      0, number.selection.baseOffset);
                                  String textAfterCursor = number.text
                                      .substring(number.selection.extentOffset);
                                  number.text =
                                      textBeforeCursor + '4' + textAfterCursor;
                                  int cursorPosition = textBeforeCursor.length +
                                      1;
                                  number.selection = TextSelection.collapsed(
                                      offset: cursorPosition);
                                }
                                symbol = false;
                                myFocusNode.requestFocus();

                              },
                              child: Text("4",
                                  style: TextStyle(
                                      fontSize: 35, color: Colors.white)))),
                      Expanded(
                          child: TextButton(
                              onPressed: () {
                                if(number.text == ""){
                                  setText('1');
                                }
                                else {
                                  String textBeforeCursor = number.text
                                      .substring(
                                      0, number.selection.baseOffset);
                                  String textAfterCursor = number.text
                                      .substring(number.selection.extentOffset);
                                  number.text =
                                      textBeforeCursor + '1' + textAfterCursor;
                                  int cursorPosition = textBeforeCursor.length +
                                      1;
                                  number.selection = TextSelection.collapsed(
                                      offset: cursorPosition);
                                }
                                symbol = false;
                                myFocusNode.requestFocus();
                                number.selection = TextSelection(
                                  baseOffset: number.text.length,
                                  extentOffset: number.text.length,
                                );
                              },
                              child: Text("1",
                                  style: TextStyle(
                                      fontSize: 35, color: Colors.white)))),
                      Expanded(
                          child: TextButton(
                              onPressed: () {
                                if (!symbol) {
                                  setText('%');
                                }
                                if(number.text == ""){
                                  setText('%');
                                }
                                else {
                                  String textBeforeCursor = number.text
                                      .substring(
                                      0, number.selection.baseOffset);
                                  String textAfterCursor = number.text
                                      .substring(number.selection.extentOffset);
                                  number.text =
                                      textBeforeCursor + '%' + textAfterCursor;
                                  int cursorPosition = textBeforeCursor.length +
                                      1;
                                  number.selection = TextSelection.collapsed(
                                      offset: cursorPosition);
                                }
                                symbol = true;
                                myFocusNode.requestFocus();
                                number.selection = TextSelection(
                                  baseOffset: number.text.length,
                                  extentOffset: number.text.length,
                                );
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
                                if (!symbol) {
                                  setText('÷');
                                }
                                symbol = true;
                                myFocusNode.requestFocus();
                                number.selection = TextSelection(
                                  baseOffset: number.text.length,
                                  extentOffset: number.text.length,
                                );
                              },
                              child: Text("÷",
                                  style: TextStyle(
                                    fontSize: 50,
                                  )))),
                      Expanded(
                          child: TextButton(
                              onPressed: () {
                                myFocusNode.requestFocus();
                                number.selection = TextSelection(
                                  baseOffset: number.text.length,
                                  extentOffset: number.text.length,
                                );
                                setText('8');
                                symbol = false;
                              },
                              child: Text("8",
                                  style: TextStyle(
                                      fontSize: 35, color: Colors.white)))),
                      Expanded(
                          child: TextButton(
                              onPressed: () {
                                setText('5');
                                symbol = false;
                                myFocusNode.requestFocus();
                                number.selection = TextSelection(
                                  baseOffset: number.text.length,
                                  extentOffset: number.text.length,
                                );
                              },
                              child: Text("5",
                                  style: TextStyle(
                                      fontSize: 35, color: Colors.white)))),
                      Expanded(
                          child: TextButton(
                              onPressed: () {
                                setText('2');
                                symbol = false;
                                myFocusNode.requestFocus();
                                number.selection = TextSelection(
                                  baseOffset: number.text.length,
                                  extentOffset: number.text.length,
                                );
                              },
                              child: Text("2",
                                  style: TextStyle(
                                      fontSize: 35, color: Colors.white)))),
                      Expanded(
                          child: TextButton(
                              onPressed: () {
                                setText('0');
                                symbol = false;
                                myFocusNode.requestFocus();
                                number.selection = TextSelection(
                                  baseOffset: number.text.length,
                                  extentOffset: number.text.length,
                                );
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
                                if (!symbol) {
                                  setText('×');
                                }
                                symbol = true;
                                myFocusNode.requestFocus();
                                number.selection = TextSelection(
                                  baseOffset: number.text.length,
                                  extentOffset: number.text.length,
                                  isDirectional: true,
                                );
                              },
                              child: Text("×",
                                  style: TextStyle(
                                    fontSize: 50,
                                  )))),
                      Expanded(
                          child: TextButton(
                              onPressed: () {
                                setText('9');
                                symbol = false;
                                myFocusNode.requestFocus();
                                number.selection = TextSelection(
                                  baseOffset: number.text.length,
                                  extentOffset: number.text.length,
                                );
                              },
                              child: Text("9",
                                  style: TextStyle(
                                      fontSize: 35, color: Colors.white)))),
                      Expanded(
                          child: TextButton(
                              onPressed: () {
                                setText('6');
                                symbol = false;
                                myFocusNode.requestFocus();
                                number.selection = TextSelection(
                                  baseOffset: number.text.length,
                                  extentOffset: number.text.length,
                                );
                              },
                              child: Text("6",
                                  style: TextStyle(
                                      fontSize: 35, color: Colors.white)))),
                      Expanded(
                          child: TextButton(
                              onPressed: () {
                                setText('3');
                                symbol = false;
                                myFocusNode.requestFocus();
                                number.selection = TextSelection(
                                  baseOffset: number.text.length,
                                  extentOffset: number.text.length,
                                );
                              },
                              child: Text("3",
                                  style: TextStyle(
                                      fontSize: 35, color: Colors.white)))),
                      Expanded(
                          child: TextButton(
                              onPressed: () {
                                if (!searchFunction(number.text, '.')) {
                                  setText('.');
                                }
                                myFocusNode.requestFocus();
                                number.selection = TextSelection(
                                  baseOffset: number.text.length,
                                  extentOffset: number.text.length,
                                );
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
                              if (number.text != "") {
                                number.text = number.text
                                    .substring(0, number.text.length - 1);
                              }
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
                              if (!symbol) {
                                setText("–");
                              }
                              myFocusNode.requestFocus();
                              number.selection = TextSelection(
                                baseOffset: number.text.length,
                                extentOffset: number.text.length,
                              );
                            },
                            child: Text("–",
                                style: TextStyle(
                                  fontSize: 35,
                                ))),
                      ),
                      Expanded(
                        child: TextButton(
                            onPressed: () {
                              if (!symbol) {
                                setText("+");
                              }
                              myFocusNode.requestFocus();
                              number.selection = TextSelection(
                                baseOffset: number.text.length,
                                extentOffset: number.text.length,
                              );
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
}
