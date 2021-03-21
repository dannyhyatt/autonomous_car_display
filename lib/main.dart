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
      debugShowCheckedModeBanner: false,
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
                                  backgroundColor: Colors.grey[800],
                                  insetPadding: const EdgeInsets.all(64),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('Add Car', style: GoogleFonts.comfortaa(color: Colors.white), textScaleFactor: 1.25,),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text('Starting vertex: ', style: GoogleFonts.comfortaa(color: Colors.white)),
                                            SizedBox(width: 50, child: TextField(textAlign: TextAlign.center, controller: startController, keyboardType: TextInputType.number, style: GoogleFonts.comfortaa(color: Colors.white),
                                                decoration: InputDecoration(
                                                  enabledBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.grey),
                                                  ),
                                                  focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.white),
                                                  ),
                                                  border: UnderlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.grey),
                                                  ),
                                                )
                                            ))
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text('Destination Vertex: ', style: GoogleFonts.comfortaa(color: Colors.white)),
                                            SizedBox(width: 50, child: TextField(textAlign: TextAlign.center, controller: endController, keyboardType: TextInputType.number, style: GoogleFonts.comfortaa(color: Colors.white),
                                                decoration: InputDecoration(
                                                  enabledBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.grey),
                                                  ),
                                                  focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.white),
                                                  ),
                                                  border: UnderlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.grey),
                                                  ),
                                                )
                                            ))
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
              child: MapView(controller: API.mapController),
            )
          ],
        ),
      ),
    );
  }
}

