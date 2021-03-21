import 'dart:convert';

import 'package:autonomous_car_display/cars_view.dart';
import 'package:autonomous_car_display/car.dart';
import 'package:autonomous_car_display/map.dart';
import 'package:autonomous_car_display/cars_listview.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class API {

  static IOWebSocketChannel channel;
  static CarMap carMap;
  static List<Car> currentCars = [];

  static GlobalKey<ScaffoldState> mainViewScaffoldKey = GlobalKey<ScaffoldState>();
  static CarsViewController carViewController = CarsViewController();
  static CarsListViewController carsListViewController = CarsListViewController();


  static Future<bool> connect({String domain, String uuid}) async {

    channel = IOWebSocketChannel.connect(Uri.parse('ws://${domain}/ws/${uuid}'));
    channel.stream.listen((event) {
      var carMapData = jsonDecode(event);
      if(carMapData['intent'] == 'getGraph') {
        double height = carMapData['data']['dimensions'][0];
        double width = carMapData['data']['dimensions'][0];
        print('height, width : $height, $width');
        var verticesList = carMapData['data']['vertices'];
        var edges = carMapData['data']['edges'];
        List<Vertice> verticies = [];
        // print('get json ${event}');
        for(int i = 0; i < verticesList.length; i++)  {
          List<int> connectedIds = findConnecting(verticesList[i]['id'], edges);
          verticies.insert(0, Vertice(
            id: verticesList[i]['id'],
            x: verticesList[i]['cords'][0],
            y: verticesList[i]['cords'][1],
            connectedVerticies: connectedIds
          ));
        }
        print('added verticies: $verticies');
        carMap = CarMap(
          height: height,
          width: width,
          verticies: verticies
        );
        print('returning true');
        return true;
      }

      if(carMapData['intent'] == 'addCar') {
        if(carMapData['result'] == 'success') {
          mainViewScaffoldKey.currentState.showSnackBar(SnackBar(content: Text('successfully added car')));
        } else {
          mainViewScaffoldKey.currentState.showSnackBar(SnackBar(content: Text('error adding car')));
        }
      }

      if(carMapData['intent'] == 'getAllCars') {
        for(int i = 0; i < carMapData['data'].length; i++) {
          currentCars = [];
          currentCars.add(Car(
            id: carMapData['data'][i]['id'],
            x: carMapData['data'][i]['cords'][0],
            y: carMapData['data'][i]['cords'][1],
            direction: carMapData['data'][i]['direction'],
          ));
          // print('current cars: $currentCars');
        }
        carViewController.updateCarPositions();
        carsListViewController.updateCars();
      }
    });
    channel.sink.add('getGraph|<timed>|{}');
    await Future.delayed(Duration(seconds: 1));
  }

  static List<int> findConnecting(int current, var edges) {
    List<int> connectingVertices = [];
    for(int i = 0; i < edges.length; i++) {
      if(edges[i]['from'] == current) connectingVertices.insert(0, edges[i]['to']);
    }
    return connectingVertices;
  }

  Future<CarMap> getCarMap() async {
    await Future.delayed(Duration(seconds: 2));
    return CarMap(
        height: 1000,
        width: 1000,
        verticies: [
          Vertice(
              id: 1,
              x: 250,
              y: 250,
              connectedVerticies: [2]
          ),
          Vertice(
              id: 2,
              x: 100,
              y: 200,
              connectedVerticies: [6]
          ),
          Vertice(
              id: 3,
              x: 250,
              y: 200,
              connectedVerticies: [4]
          ),
          Vertice(
              id: 4,
              x: 250,
              y: 450,
              connectedVerticies: [5]
          ),
          Vertice(
              id: 5,
              x: 100,
              y: 450,
              connectedVerticies: [1, 2]
          ),
          Vertice(
            id: 6,
            x: 100,
            y: 250,
          )
        ]
    );
  }

  static Future<void> addCar(int startingVertice, int endingVertice) async {
    channel.sink.add('addCar|<time>|{"start_vertex" : $startingVertice,"end_vertex": $endingVertice}');
  }

}