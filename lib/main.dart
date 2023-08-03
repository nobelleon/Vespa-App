import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vespa_app/screens/beranda.dart';
import 'package:vespa_app/utils/sized_config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizedConfig().init(constraints, orientation);
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Vespa App',
          home: Beranda(),
        );
      });
    });
  }
}
