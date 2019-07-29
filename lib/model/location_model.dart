class LocationModel {
  int id;
  String nombre;
  String direccion;
  double lat;
  double long;
  LocationModel({this.id, this.nombre, this.direccion, this.lat, this.long});
  @override
  String toString() {
    return 'LocationModel { nombre: $nombre, direccion: $direccion, lat: $lat, long: $long}';
  }
}
