import 'package:autonomous_car_display/map.dart';
import 'package:flutter/material.dart';

class EdgesPainter extends CustomPainter {

  final List<Edge> _edges;
  EdgesPainter(this._edges);


  @override
  void paint(Canvas canvas, Size size) {

    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.5;
    final outerYellow = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 3;
    // final middleYellow = Paint()
    //   ..color = Colors.yellow
    //   ..strokeWidth = 1;
    // final middleBlack = Paint()
    //   ..color = Colors.black
    //   ..strokeWidth = 0.375;

    _edges.forEach((Edge e) {
      final p1 = Offset(e.x1, e.y1);
      final p2 = Offset(e.x2, e.y2);

      canvas.drawLine(p1, p2, outerYellow);
      canvas.drawLine(p1, p2, paint);
      // canvas.drawLine(p1, p2, middleYellow);
      // canvas.drawLine(p1, p2, middleBlack);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}