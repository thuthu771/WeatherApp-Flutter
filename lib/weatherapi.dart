import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/model/weathermodelss.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/services/locaton_acces.dart';

class Weatheritems with ChangeNotifier {
  Weathermodel? _weatherdatas;
  Weathermodel? get weatherdatas => _weatherdatas;

  bool _isloading = false;
  bool get isloading => _isloading;
  LocationFetcher locationFetcher = LocationFetcher();

  Future<void> fetchdata() async {
    await locationFetcher.determinePosition(); //custom class

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.medium,
    );

    print("Location fetched ${position.latitude} ___ ${position.longitude}}");

    final latitude = position.latitude;
    final longitude = position.longitude;

    String baseurl =
        "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=c863d59c48b81cc4d102b10acf077e41&units=imperial";
    _isloading = true;
    var response = await http.get(Uri.parse(baseurl));
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.body);
      }

      final data = weathermodelFromJson(response.body);
      _weatherdatas = data;
      _isloading = false;

      notifyListeners();
    } else {
      if (kDebugMode) {
        print("error");
      }
    }
  }
}
