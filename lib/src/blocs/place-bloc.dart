import 'dart:async';

import 'package:flutter_application_1/src/repositorys/place_service.dart';

class PlaceBloc {
  final StreamController<dynamic> placeController = StreamController();

  Stream get placeStream => placeController.stream;

  void searchPlace(keyword) async {
    placeController.add(true);
    var data = await PlaceService.searchPlace(keyword);
    placeController.add(data);
  }

  void dispose() {
    placeController.close();
  }
}