import 'package:flutter/material.dart';



class Result
{
  List<Destination> destinations;

  Result({
    required this.destinations
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      destinations: json['results']
    );
  }

}


class Destination
{
  String city;
  String country;
  String admin1;
  String latitude;
  String longitude;

  Destination({
      required this.city,
      required this.country,
      required this.admin1,
      required this.latitude,
      required this.longitude
  });

  factory Destination.fromJson(Map<String, dynamic> json) {
  return Destination(
    city: json['name'],
    country: json['country'],
    admin1: json['admin1'],
    latitude: json['latitude'],
    longitude: json['longitude']
  );
}
}