import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MapsEvent extends Equatable {
  MapsEvent([List props = const []]) : super(props);
}

class GenerateMarkerWithRadius extends MapsEvent {
  final LatLng lastPosition;
  final double radius;
  GenerateMarkerWithRadius({@required this.lastPosition, @required this.radius})
      : super([lastPosition, radius]);
  @override
  String toString() =>
      'GenerateMarkerWithRadius {lastPosition: $lastPosition radius $radius}';
}

class UpdateRangeValues extends MapsEvent {
  final double radius;
  UpdateRangeValues({@required this.radius});
  @override
  String toString() {
    return 'UpdateRangeValues: radius $radius';
  }
}

class FetchPlaceFromAddressPressed extends MapsEvent {
  final String place;

  FetchPlaceFromAddressPressed({@required this.place}) : super([place]);

  @override
  String toString() => 'FetchPlaceFromAddressPressed { place: $place }';
}

class IsRadiusFixedPressed extends MapsEvent {
  final bool isRadiusFixed;
  IsRadiusFixedPressed({@required this.isRadiusFixed});
  @override
  String toString() {
    return 'IsRadiusFixedPressed: isRadiusFixed $isRadiusFixed';
  }
}

class MapTypeButtonPressed extends MapsEvent {
  final MapType currentMapType;

  MapTypeButtonPressed({@required this.currentMapType})
      : super([currentMapType]);

  @override
  String toString() => 'MapTypeButtonPressed:  $currentMapType';
}

class GetUserLocationPressed extends MapsEvent {}

class GenerateMarkerToCompareLocation extends MapsEvent {
  final LatLng radiusLocation;
  final LatLng mapPosition;
  final double radius;
  GenerateMarkerToCompareLocation(
      {@required this.radiusLocation,
      @required this.mapPosition,
      @required this.radius})
      : super([radiusLocation, mapPosition, radius]);
  @override
  String toString() =>
      'GenerateMarkerToCompareLocation { radiusLocation: $radiusLocation,  mapPosition: $mapPosition, radius: $radius';
}
