import 'package:autonomous_car_display/api.dart';
import 'package:autonomous_car_display/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('route', style: GoogleFonts.comfortaa(color: Colors.white)),
            Text('X', style: GoogleFonts.comfortaa(color: Colors.tealAccent))
          ]
        ),
        backgroundColor: Colors.black54,
        centerTitle: true,
        shadowColor: Colors.transparent,
      ),
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Domain/Port:    ', style: GoogleFonts.comfortaa(color: Colors.white), textScaleFactor: 1.25),
                IntrinsicWidth(child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      hintText: 'localhost:8000', hintStyle: TextStyle(color: Colors.grey)
                    ),
                    controller: textEditingController,style: GoogleFonts.comfortaa(color: Colors.white)))
              ],
            ),
            Divider(color: Colors.transparent),
            FloatingActionButton(
              heroTag: 'fab_add',
              backgroundColor: Colors.teal,
              child: Icon(Icons.keyboard_arrow_right_outlined),
              onPressed: () async {
                String uuid = jsonDecode((await http.post(Uri.http('${textEditingController.text == "" ? 'localhost:8000' : textEditingController.text}', '/register'), headers: {'Content-Type' : 'application/json'}, body: '{}')).body)['uuid'];
                debugPrint('uuid: ${uuid}');
                await API.connect(domain: textEditingController.text, uuid: uuid);
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => MyHomePage(title: 'Simulation Display')));
              },
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
