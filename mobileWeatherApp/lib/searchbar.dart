import 'dart:ffi';

import 'package:flutter/material.dart';



class Result
{
  final List<Destination> destinations;
  // String destinations;
  // Map<String, dynamic> destinations;
  // objList: (json['objList'] as List).map((i) => MyObj.fromJson(i)).toList()

  Result({
    required this.destinations
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      // destinations: json['results']
      destinations: (json['results'] as List).map((i) => Destination.fromJson(i)).toList()
    );
  }


  @override
  String toString() => "Destinations: [$destinations]";

  // List<Destination>

}


class Destination
{
  String city;
  String country;
  String admin1;
  double latitude;
  double longitude;

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

  @override
  String toString() => "<Destination city: $city, country: $country, admin1: $admin1, latitude: $latitude, longitude: $longitude>";
}