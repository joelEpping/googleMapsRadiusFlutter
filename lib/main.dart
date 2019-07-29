import 'package:example1/map/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'map/maps.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'google maps',
      home: BlocProvider(
        builder: (context) => MapsBloc(),
        child: Maps(),
      ),
    );
  }
}
