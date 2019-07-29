import 'package:example1/map/bloc/bloc.dart';
import 'package:example1/map/bloc/maps_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'bloc/maps_bloc.dart';

class MapOption extends StatelessWidget {
  final MapType mapType;
  MapOption({@required this.mapType});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<MapsBloc>(context),
      builder: (context, state) {
        return Container(
          child: Positioned(
            top: 150,
            right: 5,
            child: Card(
              child: IconButton(
                icon: Icon(
                  Icons.map,
                  color: Colors.grey[700],
                ),
                onPressed: () {
                  BlocProvider.of<MapsBloc>(context)
                      .dispatch(MapTypeButtonPressed(currentMapType: mapType));
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
