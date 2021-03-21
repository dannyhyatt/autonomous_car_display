import 'package:autonomous_car_display/api.dart';
import 'package:autonomous_car_display/cars_view.dart';
import 'package:autonomous_car_display/edges_painter.dart';
import 'package:autonomous_car_display/map.dart';
import 'package:flutter/material.dart';

class MapView extends StatefulWidget {

  final MapController controller;

  const MapView({Key key, this.controller}) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {

  @override
  void initState() {
    widget.controller.updateMap = updateMap;
    super.initState();
  }

  void updateMap() {
    print('updating map route');
    setState((){});
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(16)
      ),
      child: InteractiveViewer(
        maxScale: 50,
        minScale: 4,
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
                      color: !API.currentVerticies.contains(e.id) ? Colors.black : Colors.red,
                      foregroundDecoration: BoxDecoration(
                          border: Border.all(color: Colors.yellow, width: 0.25),
                          borderRadius: BorderRadius.circular(0.35)
                      ),
                      child: Center(child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
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



class MapController {
  VoidCallback updateMap;
  void dispose() {
    updateMap = null;
  }
}