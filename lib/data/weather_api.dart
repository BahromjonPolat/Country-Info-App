import 'dart:convert';

import 'package:countries/models/weather_model.dart';
import 'package:http/http.dart' as http;

Future<Weather> getWeatherData(String capital) async {
  Uri url = Uri.parse("https://goweather.herokuapp.com/weather/$capital");
  var weatherData = await http.get(url);
  Weather weather = Weather.fromJson(jsonDecode(weatherData.body));
  return weather;
}