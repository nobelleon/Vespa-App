import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vespa_app/screens/menu.dart';
import 'package:vespa_app/screens/peta.dart';
import 'package:vespa_app/screens/vespa.dart';

class Beranda extends StatefulWidget {
  @override
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  double mapDragPercent = 0.0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: Stack(
        children: [
          Menu(
            menuSlideOutPercent: mapDragPercent,
          ),
          Peta(
            onChange: (double dragPercent) {
              setState(() {
                mapDragPercent = dragPercent;
              });
            },
          ),
          FractionalTranslation(
            translation: Offset(mapDragPercent, 0),
            child: VespaScreen(),
          ),
        ],
      ),
    );
  }
}
