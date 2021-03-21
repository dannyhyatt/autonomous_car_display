import 'package:flutter/material.dart';

class CarMap {
  final double height, width;
  final List<Vertice> verticies;

  final List<Edge> edges = [];

  CarMap({this.height, this.width, this.verticies}) {
    verticies.forEach((e) {
      e.connectedVerticies.forEach((id) {
        double x1 = e.x, y1 = e.y;
        Vertice v2 = verticies.where((v) => v.id == id).toList()[0];
        edges.add(Edge(x1, y1, v2.x, v2.y));
      });
    });
    edges.forEach((element) {debugPrint(element.toString());});
  }
}

class Vertice {
  final int id;
  final double x, y;
  final List<int> connectedVerticies;

  Vertice({this.id, this.x, this.y, this.connectedVerticies = const []});

  @override
  String toString() {
    return 'vertice $id at $x, $y connected to $connectedVerticies';
  }
}

class Edge {
  final double x1, y1, x2, y2;

  Edge(this.x1, this.y1, this.x2, this.y2);

  @override
  String toString() {
    return 'path from ($x1, $y1) to ($x2, $y2)';
  }
}