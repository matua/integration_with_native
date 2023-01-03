import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 100,
          left: 10,
          right: 10,
          bottom: 100,
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              TextField(
                style: const TextStyle(fontSize: 50),
                decoration:
                    const InputDecoration(border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))),
                controller: textEditingController,
              ),
              TextButton(
                  onPressed: () {},
                  child: Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(color: Colors.green, border: Border.all()),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Press Me!',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
