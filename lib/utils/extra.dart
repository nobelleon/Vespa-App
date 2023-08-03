import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:http/http.dart' as http;

Future<Uint8List> loadAsset(
  String path, {
  int width = 50,
}) async {
  ByteData data = await rootBundle.load(path);
  final Uint8List imageCar = data.buffer.asUint8List();
  final ui.Codec codec = await ui.instantiateImageCodec(
    imageCar,
    targetWidth: width,
  );

  final ui.FrameInfo frame = await codec.getNextFrame();
  data = await frame.image.toByteData(format: ui.ImageByteFormat.png);
  return data.buffer.asUint8List();
}

Future<Uint8List> loadImageFromNetwork(
  String url, {
  int width = 50,
  int height = 50,
}) async {
  final http.Response response = await http.get(url);

  if (response.statusCode == 200) {
    final Uint8List imageCar = response.bodyBytes;
    final ui.Codec codec = await ui.instantiateImageCodec(
      imageCar,
      targetWidth: width,
      targetHeight: height,
    );

    final ui.FrameInfo frame = await codec.getNextFrame();
    final data = await frame.image.toByteData(format: ui.ImageByteFormat.png);
    return data.buffer.asUint8List();
  }
  throw Exception("download failed");
}

double getCoordsRotation(LatLng currentPosition, LatLng lastPosition) {
  final dx = math.cos(math.pi * lastPosition.latitude / 180) *
      (currentPosition.longitude - lastPosition.longitude);

  final dy = currentPosition.latitude - lastPosition.latitude;

  final angle = math.atan2(dy, dx);

  return 90 - angle * 180 / math.pi;
}
