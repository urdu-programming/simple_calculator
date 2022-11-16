import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScreenWidget extends StatelessWidget {
  const ScreenWidget({Key? key}) : super(key: key);
  static ValueNotifier<TextEditingController> input =
      ValueNotifier(TextEditingController());
  static ValueNotifier<String> ans = ValueNotifier('');
  static ValueNotifier<FocusNode> focus = ValueNotifier(FocusNode());
  static ValueNotifier<ScrollController> scrollController =
      ValueNotifier(ScrollController());

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Color(0xff303142),
        child: Column(
          children: [
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: scrollController,
                builder: (BuildContext context,
                    ScrollController scrollController, Widget) {
                  return ValueListenableBuilder(
                    valueListenable: focus,
                    builder: (BuildContext context, FocusNode myFocusNode,
                        Widget) {
                      return ValueListenableBuilder(
                        valueListenable: input,
                        builder: (BuildContext context,
                            TextEditingController number, Widget) {
                          return Container(
                            child: AutoSizeTextField(
                              controller: number,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 70),
                              minFontSize: 40,
                              stepGranularity: 10,
                              fullwidth: true,
                              keyboardType: TextInputType.none,
                              textAlign: TextAlign.right,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                              ),
                              focusNode: myFocusNode,
                              cursorColor: Color(0xffcb5cf4),
                              scrollController: scrollController,
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            Expanded(
              child: Container(
                  padding: const EdgeInsets.only(right: 10),
                  width: MediaQuery.of(context).size.width,
                  child: ValueListenableBuilder(
                      valueListenable: ans,
                      builder: (BuildContext context, String answer, Widget) {
                        return Text(
                          answer,
                          textAlign: TextAlign.right,
                          style:
                              const TextStyle(fontSize: 40, color: Colors.grey),
                        );
                      })),
            )
          ],
        ),
      ),
    );
  }
}
