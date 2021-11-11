import 'dart:convert';

import 'package:flutter_application_1/WeatherForcast/Utils/Weather_forcast_utils.dart';
import 'package:flutter_application_1/WeatherForcast/model/WeatherForcastModel.dart';
import 'package:http/http.dart';

class Network {
  var appId = Util.appID;
  Future<WeatherForcastModel> getCityWeather({required String cityName}) async {
    var finalUrl = "https://api.openweathermap.org/data/2.5/weather?q=" +
        cityName +
        "&appid=" +
        appId;
    final Response response = await get(Uri.parse(Uri.encodeFull(finalUrl)));
    if (response.statusCode == 200) {
      print("Weather today is ${response.body}");
      return WeatherForcastModel.fromJson(json.decode(response.body));
    } else
      throw Exception("It's an error :(");
  }
}
