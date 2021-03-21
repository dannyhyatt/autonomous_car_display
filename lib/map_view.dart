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
    return InteractiveViewer(
      maxScale: 250,
      minScale: 0.15,
      child: Container(
        color: Colors.white,
        child: AspectRatio(
          aspectRatio: 1,
          child: SizedBox(
            width: API.carMap.width.toDouble(),
            height: API.carMap.height.toDouble(),
            child: Stack(
              children: [
                Container(
                  color: Colors.grey[300],
                ),
                CustomPaint(
                  painter: EdgesPainter(API.carMap.edges)
                ),
                ...API.carMap.verticies.map((e) => Positioned(
                  left: e.x - 2.5,
                  top: e.y - 2.5,
                  child: Container(
                    height: 5,
                    width: 5,
                    color: Colors.grey[900],
                    child: Center(child: Text('${e.id}', style: TextStyle(color: Colors.white, fontSize: 4))),
                  ),
                )),
                CarsView(controller: API.carViewController),
              ]
            ),
          ),
        ),
      ),
    );
  }
}

class MapViewController {

}