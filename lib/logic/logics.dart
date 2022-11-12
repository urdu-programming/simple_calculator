import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:simple_calculator/widgets/screen_widget.dart';

String expression = "";
late String textBeforeCursor;
late String textAfterCursor;
late int cursorPosition;
FocusNode myFocusNode = FocusNode();

Widget buildButton(String buttonText, String buttonType) {
  if (buttonType == 'number') {
    return Expanded(
        child: TextButton(
            onPressed: () async {
              set(buttonText);
              setAnswer();
              await Future.delayed(Duration(milliseconds: 0));
              ScreenWidget.scrollController.value.jumpTo(
                  ScreenWidget.scrollController.value.position.maxScrollExtent);
              ScreenWidget.focus.value.unfocus();
              await Future.delayed(Duration(milliseconds: 0));
              ScreenWidget.focus.value.requestFocus();
            },
            child: Text(
              buttonText,
              style: const TextStyle(fontSize: 35, color: Colors.white),
            )));
  } else if (buttonType == 'point') {
    return Expanded(
        child: TextButton(
            onPressed: () async {
              textBeforeCursor = ScreenWidget.input.value.text
                  .substring(0, ScreenWidget.input.value.selection.baseOffset);
              if (!searchFunction(ScreenWidget.input.value.text, '.')) {
                if (ScreenWidget.input.value.text != "" &&
                    textBeforeCursor[textBeforeCursor.length - 1] != '÷' &&
                    textBeforeCursor[textBeforeCursor.length - 1] != '×' &&
                    textBeforeCursor[textBeforeCursor.length - 1] != '–' &&
                    textBeforeCursor[textBeforeCursor.length - 1] != '+') {
                  textBeforeCursor = ScreenWidget.input.value.text.substring(
                      0, ScreenWidget.input.value.selection.baseOffset);
                  String textAfterCursor = ScreenWidget.input.value.text
                      .substring(
                          ScreenWidget.input.value.selection.extentOffset);
                  ScreenWidget.input.value.text =
                      '$textBeforeCursor.$textAfterCursor';
                  await Future.delayed(const Duration(milliseconds: 0));
                  ScreenWidget.scrollController.value.jumpTo(ScreenWidget
                      .scrollController.value.position.maxScrollExtent);
                  ScreenWidget.focus.value.unfocus();
                  await Future.delayed(const Duration(milliseconds: 0));
                  ScreenWidget.focus.value.requestFocus();
                } else {
                  textBeforeCursor =
                      '${ScreenWidget.input.value.text.substring(0, ScreenWidget.input.value.selection.baseOffset)}0';
                  String textAfterCursor = ScreenWidget.input.value.text
                      .substring(
                          ScreenWidget.input.value.selection.extentOffset);
                  ScreenWidget.input.value.text =
                      '$textBeforeCursor.$textAfterCursor';
                  await Future.delayed(Duration(milliseconds: 0));
                  ScreenWidget.scrollController.value.jumpTo(ScreenWidget
                      .scrollController.value.position.maxScrollExtent);
                  ScreenWidget.focus.value.unfocus();
                  await Future.delayed(Duration(milliseconds: 0));
                  ScreenWidget.focus.value.requestFocus();
                }
                ScreenWidget.focus.value.requestFocus();
              }
              setAnswer();
              ScreenWidget.focus.value.requestFocus();
            },
            child: const Text(".",
                style: TextStyle(fontSize: 35, color: Colors.white))));
  } else if (buttonType == 'operation') {
    if (buttonText == '%') {
      return Expanded(
          child: TextButton(
              onPressed: () async {
                if (ScreenWidget.input.value.text != "") {
                  textBeforeCursor = ScreenWidget.input.value.text.substring(
                      0, ScreenWidget.input.value.selection.baseOffset);
                  textAfterCursor = ScreenWidget.input.value.text.substring(
                      ScreenWidget.input.value.selection.extentOffset);
                  ScreenWidget.input.value.text =
                      '$textBeforeCursor%$textAfterCursor';
                  cursorPosition = textBeforeCursor.length + 1;
                  await Future.delayed(Duration(milliseconds: 0));
                  ScreenWidget.scrollController.value.jumpTo(ScreenWidget
                      .scrollController.value.position.maxScrollExtent);
                  ScreenWidget.focus.value.unfocus();
                  await Future.delayed(Duration(milliseconds: 0));
                  ScreenWidget.focus.value.requestFocus();
                  ScreenWidget.focus.value.requestFocus();
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
              if (ScreenWidget.input.value.text != "") {
                textBeforeCursor = ScreenWidget.input.value.text.substring(
                    0, ScreenWidget.input.value.selection.baseOffset);
                if (textBeforeCursor[textBeforeCursor.length - 1] == '–' ||
                    textBeforeCursor[textBeforeCursor.length - 1] == '+') {
                  textBeforeCursor = textBeforeCursor.substring(
                      0, textBeforeCursor.length - 1);
                }
                textAfterCursor = ScreenWidget.input.value.text
                    .substring(ScreenWidget.input.value.selection.extentOffset);
                ScreenWidget.input.value.text =
                    '$textBeforeCursor–$textAfterCursor';
                cursorPosition = textBeforeCursor.length + 1;
                ScreenWidget.input.value.selection =
                    TextSelection.collapsed(offset: cursorPosition);
                ScreenWidget.focus.value.requestFocus();
              } else {
                cursorPosition = 1;
                ScreenWidget.input.value.text += "–";

                ScreenWidget.focus.value.requestFocus();

                ScreenWidget.input.value.selection =
                    TextSelection.collapsed(offset: cursorPosition);
                ScreenWidget.focus.value.requestFocus();
              }
              setAnswer();
            },
            child: const Text("–",
                style: TextStyle(
                  fontSize: 45,
                ))),
      );
    } else if (buttonText == '⌫') {
      return Expanded(
        child: TextButton(
            onPressed: () async {
              if (ScreenWidget.input.value.text.isNotEmpty) {
                String textBeforeCursor = ScreenWidget.input.value.text
                    .substring(
                        0, ScreenWidget.input.value.selection.baseOffset);
                cursorPosition = ScreenWidget.input.value.selection.baseOffset;
                ScreenWidget.input.value.selection =
                    TextSelection.collapsed(offset: cursorPosition);
                ScreenWidget.focus.value.requestFocus();

                if (ScreenWidget.input.value.text != "" &&
                    textBeforeCursor != "") {
                  cursorPosition = cursorPosition - 1;
                  String textAfterCursor = ScreenWidget.input.value.text
                      .substring(
                          ScreenWidget.input.value.selection.extentOffset);
                  ScreenWidget.input.value.text = ScreenWidget.input.value.text
                          .substring(0, cursorPosition) +
                      textAfterCursor;
                  await Future.delayed(Duration(milliseconds: 0));
                  ScreenWidget.scrollController.value.jumpTo(ScreenWidget
                      .scrollController.value.position.maxScrollExtent);
                  ScreenWidget.focus.value.unfocus();
                  await Future.delayed(Duration(milliseconds: 0));
                  setAnswer();
                  ScreenWidget.focus.value.requestFocus();
                }
              }
            },
            onLongPress: () async {
              ScreenWidget.input.value.text = '';
              await Future.delayed(Duration(milliseconds: 0));
              ScreenWidget.scrollController.value.jumpTo(
                  ScreenWidget.scrollController.value.position.maxScrollExtent);
              ScreenWidget.focus.value.unfocus();
              await Future.delayed(Duration(milliseconds: 0));
              ScreenWidget.focus.value.requestFocus();
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
                ScreenWidget.input.value.text = ScreenWidget.ans.value;
                setAnswer();
                ScreenWidget.focus.value.requestFocus();
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
                if (ScreenWidget.input.value.text.isNotEmpty) {
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
    onPressed: () async {
      ScreenWidget.input.value.text = '';
      await Future.delayed(Duration(milliseconds: 0));
      ScreenWidget.scrollController.value
          .jumpTo(ScreenWidget.scrollController.value.position.maxScrollExtent);
      ScreenWidget.focus.value.unfocus();
      await Future.delayed(Duration(milliseconds: 0));
      ScreenWidget.focus.value.requestFocus();
    },
    child: Text(
      buttonText,
      style: const TextStyle(
        fontSize: 35,
      ),
    ),
  ));
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

Future<void> set(String s) async {
  if (ScreenWidget.input.value.text == "") {
    ScreenWidget.input.value.text = s;
    ScreenWidget.focus.value.requestFocus();
  } else {
    ScreenWidget.focus.value.requestFocus();
    textBeforeCursor = ScreenWidget.input.value.text
        .substring(0, ScreenWidget.input.value.selection.baseOffset);

    String textAfterCursor = ScreenWidget.input.value.text
        .substring(ScreenWidget.input.value.selection.extentOffset);
    ScreenWidget.input.value.text = textBeforeCursor + s + textAfterCursor;
    cursorPosition = textBeforeCursor.length + 1;
    await Future.delayed(Duration(milliseconds: 0));
    ScreenWidget.scrollController.value
        .jumpTo(ScreenWidget.scrollController.value.position.maxScrollExtent);
    ScreenWidget.focus.value.unfocus();
    await Future.delayed(Duration(milliseconds: 0));
    ScreenWidget.focus.value.requestFocus();
  }
  ScreenWidget.focus.value.requestFocus();
}

Future<void> setSymbol(String s) async {
  if (ScreenWidget.input.value.text[0] == '–') {
    ScreenWidget.input.value.text = ScreenWidget.input.value.text
        .substring(1, ScreenWidget.input.value.text.length);
  } else if (ScreenWidget.input.value.text.isNotEmpty) {
    textBeforeCursor = ScreenWidget.input.value.text
        .substring(0, ScreenWidget.input.value.selection.baseOffset);
    while (textBeforeCursor[textBeforeCursor.length - 1] == '÷' ||
        textBeforeCursor[textBeforeCursor.length - 1] == '×' ||
        textBeforeCursor[textBeforeCursor.length - 1] == '–' ||
        textBeforeCursor[textBeforeCursor.length - 1] == '+') {
      textBeforeCursor =
          textBeforeCursor.substring(0, textBeforeCursor.length - 1);
    }
    textAfterCursor = ScreenWidget.input.value.text
        .substring(ScreenWidget.input.value.selection.extentOffset);
    ScreenWidget.input.value.text = textBeforeCursor + s + textAfterCursor;
    cursorPosition = textBeforeCursor.length + 1;
    await Future.delayed(Duration(milliseconds: 0));
    ScreenWidget.scrollController.value
        .jumpTo(ScreenWidget.scrollController.value.position.maxScrollExtent);
    ScreenWidget.focus.value.unfocus();
    await Future.delayed(Duration(milliseconds: 0));
    ScreenWidget.focus.value.requestFocus();
  }
  ScreenWidget.focus.value.requestFocus();
}

void setAnswer() {
  expression = ScreenWidget.input.value.text;
  expression = expression.replaceAll('×', '*');
  expression = expression.replaceAll('÷', '/');
  expression = expression.replaceAll('–', '-');
  expression = expression.replaceAll('%', '/100');
  try {
    Parser p = Parser();
    Expression exp = p.parse(expression);
    ContextModel cm = ContextModel();
    if (searchFunction(expression, '+') ||
        searchFunction(expression, '-') ||
        searchFunction(expression, '*') ||
        searchFunction(expression, '/') ||
        searchFunction(expression, '/100')) {
      ScreenWidget.ans.value = '${exp.evaluate(EvaluationType.REAL, cm)}';
    } else {
      ScreenWidget.ans.value = '';
    }
  } catch (e) {
    ScreenWidget.ans.value = '';
  }
}