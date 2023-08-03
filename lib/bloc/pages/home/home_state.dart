import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io' show Platform;

class HomeState extends Equatable {
  final LatLng myLocation;
  final bool loading, gpsEnabled;

  final Map<MarkerId, Marker> markers;
  final Map<PolylineId, Polyline> polylines;

  HomeState({
    this.myLocation,
    this.loading,
    this.markers,
    this.gpsEnabled,
    this.polylines,
  });

  static HomeState get initialState => HomeState(
        myLocation: null,
        loading: true,
        markers: Map(),
        polylines: Map(),
        gpsEnabled: Platform.isAndroid,
      );

  HomeState copyWith({
    LatLng myLocation,
    bool loading,
    bool gpsEnalbled,
    Map<MarkerId, Marker> markers,
    Map<PolylineId, Polyline> polylines,
  }) {
    return HomeState(
      myLocation: myLocation ?? this.myLocation,
      loading: loading ?? this.loading,
      markers: markers ?? this.markers,
      gpsEnabled: gpsEnabled ?? this.gpsEnabled,
      polylines: polylines ?? this.polylines,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [
        myLocation,
        loading,
        markers,
        gpsEnabled,
        polylines,
      ];
}
