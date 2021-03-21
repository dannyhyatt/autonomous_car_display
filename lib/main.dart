import 'package:autonomous_car_display/api.dart';
import 'package:autonomous_car_display/cars_listview.dart';
import 'package:autonomous_car_display/intro_screen.dart';
import 'package:autonomous_car_display/map.dart';
import 'package:autonomous_car_display/map_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simulation Display',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: IntroScreen(),
      // home: ,
    );
  }
}

class MyHomePage extends StatefulWidget {


  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: API.mainViewScaffoldKey,
      appBar: AppBar(
        title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('route', style: GoogleFonts.comfortaa(color: Colors.white)),
              Text('X', style: GoogleFonts.comfortaa(color: Colors.tealAccent)),
              Text(' Simulation', style: GoogleFonts.comfortaa(color: Colors.white)),
            ]
        ),
        backgroundColor: Colors.black54,
        centerTitle: true,
        shadowColor: Colors.transparent,
      ),
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Text('Cars:', style: GoogleFonts.comfortaa(color: Colors.white), textScaleFactor: 1.5,),
                  )
                ),
                CarsListView(controller: API.carsListViewController),
                SizedBox(
                  height: 80,
                  width: 140,
                  child: Center(
                    child: FloatingActionButton(
                      heroTag: 'fab_add',
                      onPressed: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            opaque: false,
                            barrierDismissible: true,
                            pageBuilder: (BuildContext ctx, _, __) {
                              TextEditingController startController = TextEditingController();
                              TextEditingController endController = TextEditingController();
                              return IntrinsicHeight(
                                child: Dialog(
                                  insetPadding: const EdgeInsets.all(64),
                                  shape: RoundedRectangleBorder(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('Add Car'),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text('starting vertice: '),
                                            SizedBox(width: 50, child: TextField(controller: startController, keyboardType: TextInputType.number))
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text('ending vertice: '),
                                            SizedBox(width: 50, child: TextField(controller: endController, keyboardType: TextInputType.number))
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: FloatingActionButton(
                                            heroTag: 'fab_add',
                                            child: Icon(Icons.add),
                                            onPressed: () {
                                              API.addCar(int.parse(startController.text), int.parse(endController.text));
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                        ));
                      },
                      tooltip: 'Add Car',
                      child: Icon(Icons.add),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: MapView(),
            )
          ],
        ),
      ),
    );
  }
}

