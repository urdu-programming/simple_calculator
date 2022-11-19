
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:simple_calculator/widgets/screen_widget.dart';

String expression = "";
late String textBeforeCursor;
late String textAfterCursor;
int cursorPosition = ScreenWidget.input.value.selection.baseOffset;
FocusNode myFocusNode = FocusNode();

Widget buildButton(String buttonText, String buttonType) {
  if (buttonType == 'number') {
    return Expanded(
        child: TextButton(
            onPressed: () async {
              set(buttonText);
              setAnswer();
              await Future.delayed(const Duration(milliseconds: 0));
              ScreenWidget.scrollController.value
                  .jumpTo(ScreenWidget.scrollController.value.position.pixels);
              ScreenWidget.focus.value.unfocus();
              await Future.delayed(const Duration(milliseconds: 0));
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
              ScreenWidget.focus.value.requestFocus();

              if (checkPoint(ScreenWidget.input.value.text)) {
                ScreenWidget.focus.value.requestFocus();
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
                  cursorPosition = textBeforeCursor.length + 1;
                  ScreenWidget.input.value.selection =
                      TextSelection.collapsed(offset: cursorPosition);
                }
                await Future.delayed(const Duration(milliseconds: 0));
                ScreenWidget.scrollController.value.jumpTo(
                    ScreenWidget.scrollController.value.position.pixels);
                ScreenWidget.focus.value.unfocus();
                await Future.delayed(const Duration(milliseconds: 0));
                ScreenWidget.focus.value.requestFocus();
              }
              setAnswer();
            },
            child: const Text(".",
                style: TextStyle(fontSize: 35, color: Colors.white))));
  } else if (buttonType == 'operation') {
    if (buttonText == '–') {
      return Expanded(
        child: TextButton(
            onPressed: () async {
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
              } else {
                cursorPosition = 1;
                ScreenWidget.input.value.text += "–";

                ScreenWidget.focus.value.requestFocus();

                ScreenWidget.input.value.selection =
                    TextSelection.collapsed(offset: cursorPosition);
              }
              setAnswer();
              await Future.delayed(const Duration(milliseconds: 0));
              ScreenWidget.scrollController.value
                  .jumpTo(ScreenWidget.scrollController.value.position.pixels);
              ScreenWidget.focus.value.unfocus();
              await Future.delayed(const Duration(milliseconds: 0));
              ScreenWidget.focus.value.requestFocus();
            },
            child: const Text("–",
                style: TextStyle(fontSize: 45, color: Color(0xffcb5cf4)))),
      );
    } else if (buttonText == '⌫') {
      return Expanded(
        child: TextButton(
            onPressed: () {
              if (ScreenWidget.input.value.text.isNotEmpty) {
                String textBeforeCursor = ScreenWidget.input.value.text
                    .substring(
                        0, ScreenWidget.input.value.selection.baseOffset);
                cursorPosition = ScreenWidget.input.value.selection.baseOffset;
                ScreenWidget.input.value.selection =
                    TextSelection.collapsed(offset: cursorPosition);

                if (ScreenWidget.input.value.text != "" &&
                    textBeforeCursor != "") {
                  cursorPosition = cursorPosition - 1;
                  String textAfterCursor = ScreenWidget.input.value.text
                      .substring(
                          ScreenWidget.input.value.selection.extentOffset);
                  ScreenWidget.input.value.text = ScreenWidget.input.value.text
                          .substring(0, cursorPosition) +
                      textAfterCursor;
                  ScreenWidget.input.value.selection =
                      TextSelection.collapsed(offset: cursorPosition);
                }
              }

              setAnswer();
              ScreenWidget.focus.value.requestFocus();
            },
            onLongPress: () {
              ScreenWidget.input.value.text = "";
              ScreenWidget.ans.value = '';
            },
            child: const Text("⌫",
                style: TextStyle(fontSize: 30, color: Color(0xffcb5cf4)))),
      );
    } else if (buttonText == '=') {
      return Expanded(
        child: TextButton(
            onPressed: () async {
              if (ScreenWidget.ans.value.isNotEmpty) {
                ScreenWidget.input.value.text = ScreenWidget.ans.value;
              }
              await Future.delayed(const Duration(milliseconds: 0));
              ScreenWidget.scrollController.value.jumpTo(
                  ScreenWidget.scrollController.value.position.pixels);
              ScreenWidget.focus.value.unfocus();
              await Future.delayed(const Duration(milliseconds: 0));
              ScreenWidget.focus.value.requestFocus();
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xffcb5cf4),
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
            child: const Text(
              "=",
              style: TextStyle(
                fontSize: 35,
              ),
            ))
        );
    }
    else if(buttonText == '('){
      return Expanded(
          child: TextButton(
              onPressed: () async {
                set(buttonText);
                setAnswer();
                await Future.delayed(const Duration(milliseconds: 0));
                ScreenWidget.scrollController.value
                    .jumpTo(ScreenWidget.scrollController.value.position.pixels);
                ScreenWidget.focus.value.unfocus();
                await Future.delayed(const Duration(milliseconds: 0));
                ScreenWidget.focus.value.requestFocus();
              },
              child: Text(
                buttonText,
                style: const TextStyle(fontSize: 35, color: Colors.yellow),
              )));
    }
    else if(buttonText == ')'){
      return Expanded(
          child: TextButton(
              onPressed: () async {
                set(buttonText);
                await Future.delayed(const Duration(milliseconds: 0));
                ScreenWidget.scrollController.value
                    .jumpTo(ScreenWidget.scrollController.value.position.pixels);
                ScreenWidget.focus.value.unfocus();
                await Future.delayed(const Duration(milliseconds: 0));
                ScreenWidget.focus.value.requestFocus();
                setAnswer();
              },
              child: Text(
                buttonText,
                style: const TextStyle(fontSize: 35, color: Colors.yellow),
              )));
    }
    else {
      return Expanded(
          child: TextButton(
              onPressed: () async {
                if (ScreenWidget.input.value.text.isNotEmpty) {
                  setSymbol(buttonText);
                }
                await Future.delayed(const Duration(milliseconds: 0));
                ScreenWidget.scrollController.value.jumpTo(
                    ScreenWidget.scrollController.value.position.pixels);
                ScreenWidget.focus.value.unfocus();
                await Future.delayed(const Duration(milliseconds: 0));
                ScreenWidget.focus.value.requestFocus();
                setAnswer();
              },
              child: Text(buttonText,
                  style: const TextStyle(
                      fontSize: 50, color: Color(0xffcb5cf4)))));
    }
  }
  return Expanded(
      child: TextButton(
    onPressed: () {
      ScreenWidget.input.value.text = "";
      ScreenWidget.focus.value.requestFocus();
      ScreenWidget.ans.value = '';
    },
    child: Text(
      buttonText,
      style: const TextStyle(fontSize: 35, color: Color(0xffcb5cf4)),
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

void set(String s) {
  if (ScreenWidget.input.value.text == "") {
    ScreenWidget.input.value.text = s;
  } else {
    textBeforeCursor = ScreenWidget.input.value.text
        .substring(0, ScreenWidget.input.value.selection.baseOffset);
    String textAfterCursor = ScreenWidget.input.value.text
        .substring(ScreenWidget.input.value.selection.extentOffset);
    ScreenWidget.input.value.text = textBeforeCursor + s + textAfterCursor;
    cursorPosition = textBeforeCursor.length + 1;
    ScreenWidget.input.value.selection =
        TextSelection.collapsed(offset: cursorPosition);
  }
}

void setSymbol(String s) {
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
    ScreenWidget.input.value.selection =
        TextSelection.collapsed(offset: cursorPosition);
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

bool checkPoint(String num) {
  int initial = ScreenWidget.input.value.selection.baseOffset - 1;
  var start = 0;
  var word = '';
  if (initial >= 0) {
    if (num[initial] == '.') {
      return false;
    } else if (num.codeUnitAt(initial) >= 48 && num.codeUnitAt(initial) <= 57) {
      while (num.codeUnitAt(initial) >= 48 && num.codeUnitAt(initial) <= 57) {
        start = initial;
        initial--;
        if (initial < 0) {
          break;
        }
        if (num[initial] == '.') {
          return false;
        }
      }
      while ((num.codeUnitAt(start) >= 48 && num.codeUnitAt(start) <= 57) ||
          num[start] == '.') {
        word = '$word${num[start]}';
        start++;
        if (start > num.length - 1) {
          break;
        }
      }
    } else {
      start = initial + 1;
      try {
        while ((num.codeUnitAt(start) >= 48 && num.codeUnitAt(start) <= 57) ||
            num[start] == '.') {
          word = '$word${num[start]}';
          start++;
          if (start > num.length - 1) {
            break;
          }
        }
      } catch (e) {
        set('0');
        set('.');
        return false;
      }
    }
  } else if (ScreenWidget.input.value.text.isNotEmpty) {
    for (int i = 0; i < num.length; i++) {
      if (num[i] == '.') {
        return false;
      }
    }
    set('0');
    set('.');
    return false;
  } else {
    set('0.');
    return false;
  }
  if (!searchFunction(word, '.')) {
    return true;
  }
  return false;
}
