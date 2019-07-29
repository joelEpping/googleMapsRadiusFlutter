import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RadiusModel {
  final Marker marker;
  final Circle circle;

  RadiusModel({@required this.marker, @required this.circle});

  @override
  String toString() {
    return 'RadiusModel: marker $marker, circle $circle';
  }
}
