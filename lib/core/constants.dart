import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final titleText = Text(
  "Piaggio Vespa 946",
  style: TextStyle(
    fontSize: 35,
    color: Color(0xFFE1EEDF),
  ),
);

final defaultBorderRadius = 15.0;
final double bottomTextSpacing = 80;
const defaultSpacing = 12.0;
final gradientColors = [
  Color(0xFF0D458D).withOpacity(0.8),
  Color(0xFF206ED4).withOpacity(0.0),
];

const nDefaultSpacingFactor = 12;
double spacingFactor(double multiplier) {
  return multiplier * nDefaultSpacingFactor;
}

//String item = '';

List icons = [
  Icon(
    Icons.home_work_rounded,
  ),
  Icon(Icons.battery_charging_full),
  Icon(Icons.document_scanner_outlined),
  Icon(Icons.map_outlined),
  Color(0xFFF7F3F3)
];

const itemSize = 30.0;  // 12.0
