class Result
{
  final List<Destination> destinations;

  Result({
    required this.destinations
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      destinations: (json['results'] as List).map((i) => Destination.fromJson(i)).toList()
    );
  }

  @override
  String toString() => "Destinations: [$destinations]";
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
      // city: json['name'] != null ? json['name'] : "",
      // country: json['country'] ? json['country'] : "",
      // admin1: json['admin1'] ? json['admin1'] : "",
      // latitude: json['latitude'] ? json['latitude'] : 0,
      // longitude: json['longitude'] ? json['longitude'] : 0

      city: json['name'] ?? "",
      country: json['country'] ?? "",
      admin1: json['admin1'] ?? "",
      latitude: json['latitude'] ?? 0,
      longitude: json['longitude'] ?? 0
    );
  }

  @override
  String toString() => "<city: $city, country: $country, admin1: $admin1, latitude: $latitude, longitude: $longitude>";
}