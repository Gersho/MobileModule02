import 'package:http/http.dart' as http;
import 'dart:convert';

class AdressLookup {
  final Destination destination;

  AdressLookup({required this.destination});

  factory AdressLookup.fromJson(Map<String, dynamic> json) {
    return AdressLookup(
        destination: Destination.fromReverseGeoCodingJson(json['address']));
  }

    static AdressLookup parseReverseGeoCoding(String responseBody) {
    final deserialized = json.decode(responseBody);
    final AdressLookup data = AdressLookup.fromJson(deserialized);
    return data;
  }




  
}

class Result {
  final List<Destination> destinations;

  Result({required this.destinations});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
        destinations: (json['results'] as List)
            .map((i) => Destination.fromGeoCodingJson(i))
            .toList());
  }

  @override
  String toString() => "Destinations: [$destinations]";
}

class Destination {
  String city;
  String country;
  String admin1;
  double latitude;
  double longitude;

  Destination(
      {required this.city,
      required this.country,
      required this.admin1,
      required this.latitude,
      required this.longitude});

  factory Destination.fromGeoCodingJson(Map<String, dynamic> json) {
    return Destination(
        city: json['name'] ?? "",
        country: json['country'] ?? "",
        admin1: json['admin1'] ?? "",
        latitude: json['latitude'] ?? 0,
        longitude: json['longitude'] ?? 0);
  }

  factory Destination.fromReverseGeoCodingJson(Map<String, dynamic> json) {
    return Destination(
        city: json['city'] ?? "",
        country: json['country'] ?? "",
        admin1: json['borough'] ?? "",
        latitude: 0,
        longitude: 0);
  }
  factory Destination.empty() {
    return Destination(
        city: "", country: "", admin1: "", latitude: 0, longitude: 0);
  }

  @override
  String toString() =>
      "<city: $city, country: $country, admin1: $admin1, latitude: $latitude, longitude: $longitude>";
}
