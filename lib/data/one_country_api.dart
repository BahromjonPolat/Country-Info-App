import 'package:countries/models/country_model.dart';
import 'package:http/http.dart' as http;

Future<List<Country>> getCountryDataFromApi(String country) async {
  Uri url = Uri.parse("https://restcountries.com/v3.1/name/$country");
  var countryList = await http.get(url);
  return countriesFromJson(countryList.body);
}


