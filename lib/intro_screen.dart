import 'package:autonomous_car_display/api.dart';
import 'package:autonomous_car_display/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {

  TextEditingController textEditingController = TextEditingController(text: 'localhost:8000');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Config')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('domain and port: '),
                IntrinsicWidth(child: TextField(controller: textEditingController,))
              ],
            ),
            FloatingActionButton(
              child: Icon(Icons.keyboard_arrow_right_outlined),
              onPressed: () async {
                String uuid = jsonDecode((await http.post(Uri.http('${textEditingController.text}', '/register'), headers: {'Content-Type' : 'application/json'}, body: '{}')).body)['uuid'];
                debugPrint('uuid: ${uuid}');
                await API.connect(domain: textEditingController.text, uuid: uuid);
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => MyHomePage(title: 'Simulation Display')));
              },
            )
          ],
        ),
      ),
    );
  }
}
