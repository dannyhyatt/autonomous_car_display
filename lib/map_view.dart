import 'package:autonomous_car_display/api.dart';
import 'package:autonomous_car_display/cars_view.dart';
import 'package:autonomous_car_display/edges_painter.dart';
import 'package:autonomous_car_display/map.dart';
import 'package:flutter/material.dart';

class MapView extends StatefulWidget {
  
  const MapView({Key key}) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(16)
      ),
      child: InteractiveViewer(
        maxScale: 50,
        minScale: 3,
        child: AspectRatio(
          aspectRatio: 1,
          child: Center(
            child: SizedBox(
              width: 150,
              height: 150,
              child: Stack(
                children: [
                  CustomPaint(
                    painter: EdgesPainter(API.carMap.edges)
                  ),
                  ...API.carMap.verticies.map((e) => Positioned(
                    left: e.x - 1.75,
                    top: e.y - 1.75,
                    child: Container(
                      height: 3.5,
                      width: 3.5,
                      color: Colors.black,
                      foregroundDecoration: BoxDecoration(
                          border: Border.all(color: Colors.yellow, width: 0.25),
                          borderRadius: BorderRadius.circular(0.35)
                      ),
                      child: Center(child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 01, 0, 0),
                        // padding: EdgeInsets.zero,
                        child: Text('${e.id}', style: TextStyle(color: Colors.white, fontSize: 1.5)),
                      )),
                    ),
                  )),
                  CarsView(controller: API.carViewController),
                ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}