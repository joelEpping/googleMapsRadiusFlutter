import 'package:example1/map/fixed_gps_icon.dart';
import 'package:example1/map/location_user.dart';
import 'package:example1/map/map_option.dart';
import 'package:example1/map/range_radius.dart';
import 'package:example1/map/search_place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'bloc/maps_bloc.dart';
import 'bloc/maps_event.dart';
import 'bloc/maps_state.dart';

class Maps extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MapState();
  }
}

class _MapState extends State<Maps> {
  GoogleMapController _controller;
  final Set<Marker> _markers = {};
  final Set<Circle> _circle = {};
  double _radius = 100.0;
  double _zoom = 18.0;
  bool _showFixedGpsIcon = false;
  bool _isRadiusFixed = false;
  String error;
  static const LatLng _center = const LatLng(40.7815, -73.9667);
  MapType _currentMapType = MapType.normal;
  LatLng _lastMapPosition = _center;

  MapsBloc _mapsBloc;

  Widget _googleMapsWidget(MapsState state) {
    return GoogleMap(
      onTap: (LatLng location) {
        if (_isRadiusFixed) {
          _mapsBloc.dispatch(GenerateMarkerToCompareLocation(
              mapPosition: location,
              radiusLocation: _lastMapPosition,
              radius: _radius));
        }
      },
      onMapCreated: _onMapCreated,
      myLocationButtonEnabled: true,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: _zoom,
      ),
      circles: _circle,
      markers: _markers,
      onCameraMove: _onCameraMove,
      onCameraIdle: () {
        if (_isRadiusFixed != true)
          _mapsBloc.dispatch(
            GenerateMarkerWithRadius(
                lastPosition: _lastMapPosition, radius: _radius),
          );
      },
      mapType: _currentMapType,
    );
  }

  @override
  void initState() {
    super.initState();
    _mapsBloc = BlocProvider.of<MapsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener(
        bloc: _mapsBloc,
        listener: (BuildContext context, MapsState state) {
          if (state is LocationUserfound) {
            Scaffold.of(context)..hideCurrentSnackBar();
            _lastMapPosition =
                LatLng(state.locationModel.lat, state.locationModel.long);
            _animateCamera();
          }
          if (state is MarkerWithRadius) {
            Scaffold.of(context)..hideCurrentSnackBar();
            _showFixedGpsIcon = false;

            if (_markers.isNotEmpty) {
              _markers.clear();
            }
            if (_circle.isNotEmpty) {
              _circle.clear();
            }
            _markers.add(state.raidiusModel.marker);
            _circle.add(state.raidiusModel.circle);
          }

          if (state is RadiusFixedUpdate) {
            Scaffold.of(context)..hideCurrentSnackBar();
            _isRadiusFixed = state.radiusFixed;
          }

          if (state is MapTypeChanged) {
            Scaffold.of(context)..hideCurrentSnackBar();
            _currentMapType = state.mapType;
          }
          if (state is RadiusUpdate) {
            Scaffold.of(context)..hideCurrentSnackBar();
            _radius = state.radius;
            _zoom = state.zoom;
            _animateCamera();
          }
          if (state is MarkerWithSnackbar) {
            _markers.add(state.marker);
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(state.snackBar);
          }
          if (state is LocationFromPlaceFound) {
            Scaffold.of(context)..hideCurrentSnackBar();
            _lastMapPosition =
                LatLng(state.locationModel.lat, state.locationModel.long);
          }
          if (state is Failure) {
            print('Failure');
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Error'), Icon(Icons.error)],
                  ),
                  backgroundColor: Colors.red,
                ),
              );
          }
          if (state is Loading) {
            print('loading');
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Cargando'),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              );
          }
        },
        child: BlocBuilder(
            bloc: _mapsBloc,
            builder: (BuildContext context, MapsState state) {
              return Scaffold(
                body: Stack(
                  children: <Widget>[
                    _googleMapsWidget(state),
                    FixedLocationGps(showFixedGpsIcon: _showFixedGpsIcon),
                    MapOption(mapType: _currentMapType),
                    LocationUser(),
                    SearchPlace(onPressed: _animateCamera),
                    RangeRadius(isRadiusFixed: _isRadiusFixed),
                  ],
                ),
              );
            }),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  void _onCameraMove(CameraPosition position) {
    if (!_isRadiusFixed) _lastMapPosition = position.target;
    if (_showFixedGpsIcon != true && _isRadiusFixed != true) {
      setState(() {
        _showFixedGpsIcon = true;
        if (_markers.isNotEmpty) {
          _markers.clear();
          _circle.clear();
        }
      });
    }
  }

  void _animateCamera() {
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _lastMapPosition,
          zoom: _zoom,
        ),
      ),
    );
  }
}
