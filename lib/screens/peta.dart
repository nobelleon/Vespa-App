import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vespa_app/core/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vespa_app/bloc/pages/home/bloc.dart';

class Peta extends StatefulWidget {
  final ValueChanged<double> onChange;

  const Peta({Key key, this.onChange}) : super(key: key);

  @override
  _PetaState createState() => _PetaState();
}

class _PetaState extends State<Peta> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  double get maxHeight => MediaQuery.of(context).size.height;
  double minHeight;

  final CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(-6.346964, 106.729449),
    zoom: 15,
  );

  final HomeBloc _bloc = HomeBloc();

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200))
      ..addListener(() {
        setState(() {
          widget.onChange(_controller.value);
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _bloc.close();
    super.dispose();
  }

  void _onDragUpdated(DragUpdateDetails details_) {
    _controller.value -= details_.primaryDelta / maxHeight;
  }

  void _onDragEnd(DragEndDetails _details) {
    if (_controller.isAnimating ||
        _controller.status == AnimationStatus.completed) return;

    final double flingVelocity =
        _details.velocity.pixelsPerSecond.dy / maxHeight;

    if (flingVelocity < 0.0) {
      _controller.fling(
        velocity: max(2.0, -flingVelocity),
      );
    } else if (flingVelocity > 0.0) {
      _controller.fling(velocity: min(-2.0, -flingVelocity));
    } else {
      _controller.fling(velocity: _controller.value < 0.5 ? -2.0 : 2.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    minHeight = maxHeight * .45;

    return Positioned(
      height: lerpDouble(minHeight, maxHeight, _controller.value),
      left: 0,
      right: 0,
      bottom: 0,
      child: GestureDetector(
        onVerticalDragUpdate: _onDragUpdated,
        onVerticalDragEnd: _onDragEnd,
        behavior: HitTestBehavior.translucent,
        child: BlocProvider.value(
          value: this._bloc,
          child: ClipRRect(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(defaultBorderRadius * 2),
              right: Radius.circular(defaultBorderRadius * 2),
            ),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (_, state) {
                  return GoogleMap(
                    initialCameraPosition: _initialPosition,
                    zoomControlsEnabled: true,
                    compassEnabled: true,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    markers: state.markers.values
                        .toSet(), // aktifin image Vespa di titik lokasi
                    polylines:
                        state.polylines.values.toSet(), // aktifin polylines
                    // onTap: (LatLng position) {
                    //   print('$position');
                    //   this._bloc.add(OnMapTap(position));
                    // },
                    onMapCreated: (GoogleMapController controller) {
                      this._bloc.setMapController(controller);
                    },
                  );
                },
              ),
            ),
            // Image.asset(
            //   "assets/images/peta.png",
            //   fit: BoxFit.cover,
            // ),
          ),
        ),
      ),
    );
  }
}
