import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:bloc/bloc.dart';
import 'package:vespa_app/bloc/pages/home/bloc.dart';
import 'package:vespa_app/utils/extra.dart';
import 'package:vespa_app/utils/map_style.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeBloc extends Bloc<HomeEvents, HomeState> {
  Geolocator _geolocator = Geolocator();

  final Completer<GoogleMapController> completer = Completer();

  final Completer<Marker> _myPositionMarker = Completer();

  final LocationOptions _locationOptions = const LocationOptions(
      accuracy: LocationAccuracy.high, distanceFilter: 10);

  StreamSubscription<Position> _subscription;

  Polyline myRoute = Polyline(
    polylineId: PolylineId('my_route'),
    width: 5,
    color: Color.fromARGB(255, 95, 78, 243),
  );

  Polygon myTaps = Polygon(
    polygonId: PolygonId('my_taps_polygon'),
    fillColor: const Color.fromARGB(255, 95, 78, 243),
    strokeWidth: 3,
    strokeColor: const Color.fromARGB(255, 243, 245, 241),
  );

  Future<GoogleMapController> get _mapController async {
    return await completer.future;
  }

  HomeBloc() {
    this._init();
  }

  @override
  Future<void> close() async {
    _subscription.cancel();
    super.close();
  }

  _init() async {
    _loadCarPin();

    _subscription = _geolocator
        .getPositionStream(_locationOptions)
        .listen((Position position) async {
      if (position != null) {
        final newPosition = LatLng(
          position.latitude,
          position.longitude,
        );
        add(
          OnMyLocationUpdate(newPosition),
        );

        final CameraUpdate cameraUpdate = CameraUpdate.newLatLng(newPosition);
        await (await _mapController).animateCamera(cameraUpdate);
      }
    });

    if (Platform.isAndroid) {
      final bool enabled = await _geolocator.isLocationServiceEnabled();
      add(OnGpsEnabled(enabled));
    }
  }

  _loadCarPin() async {
    final Uint8List car = await loadAsset(
      'assets/images/onTop_blue_.png',
      width: 50,
    );

    final marker = Marker(
      markerId: MarkerId('my_position_marker'),
      icon: BitmapDescriptor.fromBytes(car),
      anchor: const Offset(0.5, 0.5),
    );
    this._myPositionMarker.complete(marker);
  }

  void setMapController(GoogleMapController controller) async {
    completer.complete(controller);
    (await _mapController).setMapStyle(jsonEncode(mapStyle));
  }

  @override
  HomeState get initialState => HomeState.initialState;

  @override
  Stream<HomeState> mapEventToState(HomeEvents event) async* {
    if (event is OnMyLocationUpdate) {
      yield* this._mapOnMyLocationUpdate(event);
    } else if (event is OnGpsEnabled) {
      yield this.state.copyWith(gpsEnalbled: event.enabled);
    } else if (event is OnMapTap) {
      yield* this._mapOnMapTap(event);
    }
  }

  Stream<HomeState> _mapOnMyLocationUpdate(OnMyLocationUpdate event) async* {
    List<LatLng> points = List<LatLng>.from(myRoute.points);
    points.add(event.location);

    myRoute = myRoute.copyWith(pointsParam: points);
    print("points ${myRoute.points.length}");

    Map<PolylineId, Polyline> polylines =
        Map<PolylineId, Polyline>.from(this.state.polylines);

    polylines[myRoute.polylineId] = myRoute;

    final markers = Map<MarkerId, Marker>.from(this.state.markers);

    double rotation = 0;
    LatLng lastPosition = this.state.myLocation;

    if (lastPosition != null) {
      rotation = getCoordsRotation(event.location, lastPosition);
    }

    final Marker myPositionMarker =
        (await this._myPositionMarker.future).copyWith(
      positionParam: event.location,
      rotationParam: rotation,
    );
    markers[myPositionMarker.markerId] = myPositionMarker;

    yield state.copyWith(
      loading: false,
      myLocation: event.location,
      polylines: polylines,
      markers: markers,
    );
  }

  Stream<HomeState> _mapOnMapTap(OnMapTap event) async* {
    final markerId = MarkerId(this.state.markers.length.toString());
    final info = InfoWindow(
      title: "Hello ${markerId.value}",
      snippet: "what's up gaess!",
    );

    final Uint8List imageCar = await loadAsset(
      'assets/images/onTop_blue_.png',
      width: 50,
      // height: 90,
    );

    // load image from network
    // final Uint8List imageCar = await loadImageFromNetwork(
    //   'https://uploads-ssl.webflow.com/5ee12d8d7f840543bde883de/5ef3a1148ac97166a06253c1_flutter-logo-white-inset.svg',
    //   width: 50,
    //   height: 90,
    // );

    final customIcon = BitmapDescriptor.fromBytes(imageCar);

    final marker = Marker(
      markerId: markerId,
      position: event.location,
      icon: customIcon,
      anchor: const Offset(0.5, 0.5),
      onTap: () {
        print('${markerId.value}');
      },
      draggable: true,
      onDragEnd: (newPosition) {
        print('${markerId.value} new Position $newPosition');
      },
    );

    final markers = Map<MarkerId, Marker>.from(this.state.markers);
    markers[markerId] = marker;

    yield this.state.copyWith(markers: markers);
  }
}
