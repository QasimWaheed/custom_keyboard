import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'custom_keyboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final custom1Notifier = ValueNotifier<String>("");
  final FocusNode _nodeText1 = FocusNode();

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: false,
      actions: [
        KeyboardActionsItem(
          focusNode: _nodeText1,
          footerBuilder: (_) => CustomKeyboard(
            notifier: custom1Notifier,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: KeyboardActions(
        config: _buildConfig(context),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(Material(
            child: KeyboardCustomInput<String>(
              focusNode: _nodeText1,
              height: 65,
              notifier: custom1Notifier,
              builder: (context, val, hasFocus) {
                return Container(
                  alignment: Alignment.centerLeft,
                  color: hasFocus! ? Colors.grey[300] : Colors.white,
                  child: Text(
                    val,
                    // style:
                    // TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
