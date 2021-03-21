import 'dart:async';

import 'package:autonomous_car_display/api.dart';
import 'package:flutter/material.dart';

class CarsView extends StatefulWidget {
  // todo add onnewdata (new car positions) handler

  final CarsViewController controller;
  CarsView({this.controller});

  @override
  _CarsViewState createState() => _CarsViewState();
}

class _CarsViewState extends State<CarsView> {

  @override
  void initState() {
    widget.controller.updateCarPositions = refreshCars;
    Timer.periodic(Duration(milliseconds: 500), (timer) { API.channel.sink.add('getAllCars|<time>|{}'); });
    super.initState();
  }

  void refreshCars() {
    print('refreshing cars???');
    API.currentCars.forEach((element) {print('car at ${element}');});
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // todo make sure to get the height and width dynamically from the server
      height: API.carMap.height,
      width: API.carMap.width,
      child: Stack(
        children: [
          ...API.currentCars.map((car) => AnimatedPositioned(
            top: car.y,
            left: car.x,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: RotatedBox(
                  quarterTurns: 1,
                  child: Icon(Icons.directions_car_rounded, color: Colors.white, size: 4,)
              ),
            ), duration: const Duration(milliseconds: 250))
          )
        ],
      ),
    );
  }
}

class CarsViewController {
  VoidCallback updateCarPositions;
  void dispose() {
    updateCarPositions = null;
  }
}