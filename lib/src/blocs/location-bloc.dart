import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
class LocationBloc {
  StreamController myLocationController = StreamController();
  StreamController<List<dynamic>> listLocationController = StreamController();
  Stream get myLocationStream => myLocationController.stream;
  Stream<List<dynamic>> get listLocationStream => listLocationController.stream;

  void getfieldlocation() async {
    Location location = new Location();
    var _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    var _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    var _locationData = await location.getLocation();
    LatLng latLng = LatLng(_locationData.latitude!, _locationData.longitude!);
    myLocationController.add(latLng);
  }

  void setListLocation(type, location) {
    late List locations = [];
    if (type == 'from') {
      locations.add(location);
      locations.add({});
    } else {
      locations.add({});
      locations.add(location);
    }
    listLocationController.sink.add(locations);
  }

  void dispose() {
    myLocationController.close();
    listLocationController.close();
  }
}