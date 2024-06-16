  import 'package:weatherapp_proj/geocoding.dart';
  import 'package:http/http.dart' as http;
  import 'dart:convert';

import 'package:weatherapp_proj/weather.dart';
  
  Future<List<Destination>> callGeoCodingApi(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<Destination> list = parseAgents(response.body);
        return list;
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }


 List<Destination> parseAgents(String responseBody) {
    final deserialized = json.decode(responseBody);
    if (deserialized['results'] == null) {
      return [];
    }
    final Result result = Result.fromJson(deserialized);
    final List<Destination> destinations = result.destinations;
    return destinations;
  }


FullWeatherData parseWeather(String responseBody) {
    final deserialized = json.decode(responseBody);
    final FullWeatherData data = FullWeatherData.fromJson(deserialized);
    return data;
  }

  Future<FullWeatherData> callWeatherApi(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        FullWeatherData data = parseWeather(response.body);
        return data;
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<AdressLookup> callReverseGeoCodingApi(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        AdressLookup data = AdressLookup.parseReverseGeoCoding(response.body);
        return data;
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }