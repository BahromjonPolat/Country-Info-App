class Weather {
  String? _temperature;
  String? _wind;
  String? _description;
  List<Forecast>? _forecast;

  String get temperature => _temperature!;

  String get wind => _wind!;

  String get description => _description!;

  List<Forecast> get forecast => _forecast!;

  Weather.fromJson(Map<String, dynamic> json) {
    _temperature = json['temperature'];
    _wind = json['wind'];
    _description = json['description'];
    if (json['forecast'] != null) {
      _forecast = [];
      json['forecast'].forEach((v) {
        _forecast!.add(new Forecast.fromJson(v));
      });
    }
  }
}

class Forecast {
  String? _day;
  String? _temperature;
  String? _wind;

  String get day => _day!;

  String get temperature => _temperature!;

  String get wind => _wind!;

  Forecast.fromJson(Map<String, dynamic> json) {
    _day = json['day'];
    _temperature = json['temperature'];
    _wind = json['wind'];
  }
}
