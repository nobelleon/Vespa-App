import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vespa_app/bloc/pages/home/home_bloc.dart';
import 'package:vespa_app/bloc/pages/home/home_state.dart';

class MapIcon extends StatefulWidget {
  const MapIcon({Key key}) : super(key: key);

  @override
  State<MapIcon> createState() => _MapIconState();
}

class _MapIconState extends State<MapIcon> {
  final CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(-6.346964, 106.729449),
    zoom: 15,
  );

  final HomeBloc _bloc = HomeBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: this._bloc,
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Color.fromARGB(255, 84, 98, 163),
        //   actions: const [
        //     Padding(
        //       padding: EdgeInsets.only(right: 137.0),
        //       child: Center(
        //         child: Text(
        //           'Map',
        //           style: TextStyle(fontSize: 18),
        //         ),
        //       ),
        //     ),
        //     Padding(
        //       padding: EdgeInsets.only(right: 11.0),
        //       child: Icon(
        //         EvaIcons.videoOutline,
        //       ),
        //     ),
        //   ],
        // ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: <Widget>[
              BlocBuilder<HomeBloc, HomeState>(
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
                    onMapCreated: (GoogleMapController controller) {
                      this._bloc.setMapController(controller);
                    },
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 5.0,
                  top: 25,
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
