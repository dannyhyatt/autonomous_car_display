import 'package:flutter/material.dart';

class DrawMapView extends StatefulWidget {
  @override
  _DrawMapViewState createState() => _DrawMapViewState();
}

class _DrawMapViewState extends State<DrawMapView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Draw Map View'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(32),
            child: GestureDetector(
              // on
            ),
          )
        ],
      ),
    );
  }
}
