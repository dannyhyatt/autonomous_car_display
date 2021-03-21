import 'package:autonomous_car_display/api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CarsListView extends StatefulWidget {

  final CarsListViewController controller;
  CarsListView({this.controller});

  @override
  _CarsListViewState createState() => _CarsListViewState();
}

class _CarsListViewState extends State<CarsListView> {


  @override
  void initState() {
    widget.controller.updateCars = updateCars;
    super.initState();
  }

  void updateCars() {
    print('updating car list');
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ListView.builder(
        shrinkWrap: true,
        itemExtent: 42,
        itemCount: API.currentCars.length,
        itemBuilder: (ctx, index) {
          return InkWell(
            onTap: (){},
            borderRadius: BorderRadius.circular(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16,0,8,0),
                  child: Icon(Icons.directions_car_rounded, size: 30, color: Colors.white,),
                ),
                Text('Car ${API.currentCars[index].id}', style: GoogleFonts.comfortaa(color: Colors.white), textScaleFactor: 1.3,)
              ],
            ),
          );
        },
      ),
    );
  }
}

class CarsListViewController {
  VoidCallback updateCars;
  void dispose() {
    updateCars = null;
  }
}