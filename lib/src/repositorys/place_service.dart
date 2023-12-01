import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class PlaceService {
  static Future<List> searchPlace(keyword) async {
    var url = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=$keyword&key=AIzaSyADl3t1Xrjtwf58sZsq4wzqSuyWI1zySbM&language=vi&region=VN";
    var uri = Uri.parse(url);
    var res = await http.get(uri);
    if (res.statusCode == 200) {
      var data = await json.decode(res.body);
      return data['results'];
    }
    return List.empty();
  }
}