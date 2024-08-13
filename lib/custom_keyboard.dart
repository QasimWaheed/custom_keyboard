import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_custom.dart';

class TextKey extends StatelessWidget {
  const TextKey({
    super.key,
    required this.text,
    this.onTextInput,
    this.flex = 1,
  });
  final String text;
  final Function(String)? onTextInput;
  final int flex;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Material(
          // color: Colors.blue.shade300,
          child: InkWell(
            onTap: onTextInput != null ? () {
              onTextInput!(text);
            } : null,
            child: Center(child: Text(text, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),)),
          ),
        ),
      ),
    );
  }
}

class CustomKeyboard extends StatelessWidget with KeyboardCustomPanelMixin<String> implements PreferredSizeWidget {
  const CustomKeyboard({
    super.key,
    required this.notifier,
  });
  
  final ValueNotifier<String> notifier;

  void _textInputHandler(text) {
    updateValue("${notifier.value}$text");
  }

  void _backspace() {
    if (notifier.value.isEmpty) return;
    var length = notifier.value.length-1;
    if (length == 0) {
      updateValue("");
      return;
    }
    var value = notifier.value.substring(0, length);
    updateValue(value);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: Colors.grey[200],
      child: Column(        // <-- Column
        children: [
          Expanded(
            child: Row(
              children: [
                TextKey(
                  text: '1',
                  onTextInput: _textInputHandler,
                ),
                TextKey(
                  text: '2',
                  onTextInput: _textInputHandler,
                ),
                TextKey(
                  text: '3',
                  onTextInput: _textInputHandler,
                ),
              ],
            ),
          ),    // <-- Row
          Expanded(
            child: Row(
              children: [
                TextKey(
                  text: '4',
                  onTextInput: _textInputHandler,
                ),
                TextKey(
                  text: '5',
                  onTextInput: _textInputHandler,
                ),
                TextKey(
                  text: '6',
                  onTextInput: _textInputHandler,
                ),

              ],
            ),
          ),    // <-- Row
          Expanded(
            child: Row(
              children: [
                TextKey(
                  text: '7',
                  onTextInput: _textInputHandler,
                ),
                TextKey(
                  text: '8',
                  onTextInput: _textInputHandler,
                ),
                TextKey(
                  text: '9',
                  onTextInput: _textInputHandler,
                ),
              ],
            ),
          ),  // <-- Row
          Expanded(
            child: Row(
              children: [
                TextKey(
                  text: '.',
                  onTextInput: _textInputHandler,
                ),
                TextKey(
                  text: '0',
                  onTextInput: _textInputHandler,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Material(
                      // color: Colors.blue.shade300,
                      child: InkWell(
                        onTap: _backspace,
                        child: const Center(
                          child: Icon(Icons.backspace, size: 30,),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),  // <-- Row

        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(200);
}