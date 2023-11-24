import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/services/locaton_acces.dart';

import 'model/forecast_weather_model.dart';
import 'package:http/http.dart' as http;

class Forecastitems with ChangeNotifier {
  ForecastWeatherModel? _forecastdatas;
  ForecastWeatherModel? get forecastdatas => _forecastdatas;

  LocationFetcher locationFetcher =
      LocationFetcher(); //creating an object for the class location fetcher

  bool _isloading = false;
  bool get isloading => _isloading;
  Future<void> fetchdata() async {
    await locationFetcher.determinePosition(); //custom class

    Position position = await Geolocator.getCurrentPosition(
      //fetching location
      desiredAccuracy: LocationAccuracy.medium,
    );

    final latitude = position.latitude;
    final longitude = position.longitude;

    String baseurl =
        "https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=c863d59c48b81cc4d102b10acf077e41&units=imperial";
    _isloading = true;
    var response = await http.get(Uri.parse(baseurl));
    if (response.statusCode == 200) {
      print(response.statusCode);
      _forecastdatas =
          ForecastWeatherModel.fromJson(json.decode(response.body));

      _isloading = false;

      notifyListeners();
    } else {
      if (kDebugMode) {
        print("error");
      }
    }
  }
}
