import 'package:flutter/material.dart';

class ScreenWidget extends StatelessWidget {
  const ScreenWidget({Key? key}) : super(key: key);
  static ValueNotifier<TextEditingController> input = ValueNotifier(TextEditingController());
  static ValueNotifier<String> ans = ValueNotifier('');
  static ValueNotifier<FocusNode> focus = ValueNotifier(FocusNode());

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.black87,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 150),
              child: ValueListenableBuilder(valueListenable: focus,
                builder: (BuildContext context, FocusNode myFocusNode, Widget) {
                  return ValueListenableBuilder(valueListenable: input, builder: (BuildContext context, TextEditingController number, Widget)
                  {
                    return TextField(
                      keyboardType: TextInputType.none,
                      textAlign: TextAlign.right,
                      controller: number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                      focusNode: myFocusNode,
                      style: const TextStyle(fontSize: 70, color: Colors.white),
                    );
                  });
                },),
            ),
            Container(
                padding: const EdgeInsets.only(right: 10),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: ValueListenableBuilder(valueListenable: ans,
                    builder: (BuildContext context, String answer, Widget) {
                      return Text(
                        answer,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                            fontSize: 40, color: Colors.grey),
                      );
                    })
            )
          ],
        ),
      ),
    );
  }
}
