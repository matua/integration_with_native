import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'android_platform_view_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textEditingController = TextEditingController();
  static const channel = MethodChannel('com.matuageorge/native_demo');
  final ValueNotifier<String> _platformText = ValueNotifier('');
  final ValueNotifier<String> _flutterText = ValueNotifier('');

  String? flutterText;

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("AM REBUILDING!");
    }
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextField(
                style: const TextStyle(fontSize: 50),
                decoration:
                    const InputDecoration(border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))),
                controller: textEditingController,
              ),
              TextButton(
                  onPressed: () async {
                    try {
                      channel.invokeMethod('textfieldFromFlutter', textEditingController.text).then((result) {
                        if (kDebugMode) {
                          print("RESULT: $result");
                        }
                        _platformText.value = result;
                        _flutterText.value = result;
                      });
                      FocusScope.of(context).requestFocus(FocusNode());
                    } on PlatformException catch (e) {
                      if (kDebugMode) {
                        print("Failed to call: ${e.message}");
                      }
                    }
                  },
                  child: Container(
                    height: 81,
                    width: 180,
                    decoration: BoxDecoration(color: Colors.green, border: Border.all()),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Press Me!',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )),
              ValueListenableBuilder(
                  valueListenable: _flutterText,
                  builder: (BuildContext context, String value, Widget? child) => SizedBox(
                      height: 100,
                      child: Text(
                          style: const TextStyle(fontSize: 30),
                          _flutterText.value != '' ? _flutterText.value : 'nothing'))),
              ValueListenableBuilder(
                key: UniqueKey(),
                valueListenable: _platformText,
                builder: (BuildContext context, String value, Widget? child) => SizedBox(
                  height: 50,
                  child: _platformText.value.isEmpty
                      ? const SizedBox.shrink()
                      : AndroidPlatformViewWidget(
                    creationParams: {'text': _platformText.value},
                  ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
