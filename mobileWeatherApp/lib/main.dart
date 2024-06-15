import 'package:flutter/material.dart';
import 'package:weatherapp_proj/footer.dart';
import 'package:weatherapp_proj/json.dart';
import 'package:weatherapp_proj/weather.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WeatherApp(),
    );
  }
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});
  @override
  State<WeatherApp> createState() => WeatherAppState();
}

class WeatherAppState extends State<WeatherApp> {
  bool isGeo = false;
  bool isError = false;
  bool isSearching = false;
  List<Destination> destinations = [];
  // String submitted = "";
  Destination submitted = Destination.empty();
  FullWeatherData weatherData = FullWeatherData.empty();
  bool showResult = false;

  // void onSearchSubmit(String val) {
  //   if (val.length > 45) {
  //     val = "${val.substring(0, 42)}...";
  //   }
  //   setState(() {
  //     isGeo = false;
  //     isError = false;
  //     submitted = val;
  //     showResult = false;
  //   });
  // }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<List<Destination>> _callGeoCodingApi(String url) async {
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

  static List<Destination> parseAgents(String responseBody) {
    final deserialized = json.decode(responseBody);
    if (deserialized['results'] == null) {
      return [];
    }
    final Result result = Result.fromJson(deserialized);
    final List<Destination> destinations = result.destinations;
    return destinations;
  }

  static FullWeatherData parseWeather(String responseBody) {
    final deserialized = json.decode(responseBody);
    // if (deserialized['results'] == null)
    // {
    //   return [];
    // }
    // final Result result = Result.fromJson(deserialized);
    // final FullWeatherData destinations = result.destinations;

    final FullWeatherData data = FullWeatherData.fromJson(deserialized);

    return data;
  }

  Future<FullWeatherData> _callWeatherApi(String url) async {
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

  void onSearchChange(String val) {
    String apiUrl =
        "https://geocoding-api.open-meteo.com/v1/search?count=5&name=$val";

    // isSearching = false;
    isSearching = true;
    if (val.length < 3) {
      setState(() {
        isSearching = false;
      });

      // debugPrint("val < 3 -> no api call");

      return;
    }

    Future<List<Destination>> future = _callGeoCodingApi(apiUrl);
    future.then((value) {
      debugPrint("####################################");
      debugPrint(value.toString());

      //TODO HERE

      setState(() {
        isSearching = true;
        destinations = value;
        showResult = false;
        // searching = true;
      });
    });
  }

  Future<AdressLookup> _callReverseGeoCodingApi(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        AdressLookup data = parseReverseGeoCoding(response.body);
        return data;
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static AdressLookup parseReverseGeoCoding(String responseBody) {
    final deserialized = json.decode(responseBody);
    // if (deserialized['results'] == null)
    // {
    //   return [];
    // }
    // final Result result = Result.fromJson(deserialized);
    // final AdressLookup destinations = result.destinations;

    final AdressLookup data = AdressLookup.fromJson(deserialized);

    return data;
  }

  void onClickGeolocation() {
    Future<Position> geoLocalisationFuture = _determinePosition();
    geoLocalisationFuture.then((geoLocNumericResponse) {
      String weatherApiUrl =
          "https://api.open-meteo.com/v1/forecast?latitude=${geoLocNumericResponse.latitude}&longitude=${geoLocNumericResponse.longitude}&current=temperature_2m,weather_code,wind_speed_10m&hourly=temperature_2m,weather_code,wind_speed_10m&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=auto";
      Future<FullWeatherData> weatherDataFuture = _callWeatherApi(weatherApiUrl);

      weatherDataFuture.then((weatherDataResponse) {
        String reverseGeoCodingApiUrl =
            "https://nominatim.openstreetmap.org/reverse?lat=${geoLocNumericResponse.latitude}&lon=${geoLocNumericResponse.longitude}&format=json";
        Future<AdressLookup> geoLocNameFuture =
            _callReverseGeoCodingApi(reverseGeoCodingApiUrl);

        geoLocNameFuture.then((geoLocNameResponse) {
          setState(() {
            isError = false;
            isSearching = false;
            isGeo = true;
            destinations = [];
            //here logic [coords] -> [place name] -> [weather]
            // submitted = geoLocNumericResponse.toString();
            submitted = geoLocNameResponse.destination;
            weatherData = weatherDataResponse;
            showResult = true;
          });
        }).catchError((error) {
          setState(() {
            isError = true;
            isSearching = false;
            isGeo = true;
            submitted = error;
            destinations = [];
            weatherData = FullWeatherData.empty();
            showResult = false;
          });
        });

      }) 
          .catchError((error) {
        setState(() {
          isError = true;
          isSearching = false;
          isGeo = true;
          submitted = error;
          destinations = [];
          weatherData = FullWeatherData.empty();
          showResult = false;
        });
      }); //data catch error
    }).catchError((error) {
      setState(() {
        isError = true;
        isSearching = false;
        isGeo = true;
        submitted = error;
        destinations = [];
        weatherData = FullWeatherData.empty();
        showResult = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
          // appBar: TopBar(),
          appBar: AppBar(
            title: SearchBar(
              onChanged: onSearchChange,
              // onSubmitted: onSearchSubmit,
              leading: const Icon(Icons.search),
              hintText: "Search",
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.near_me_rounded),
                tooltip: 'Geolocation',
                onPressed: onClickGeolocation,
              ),
            ],
            // bottom:
          ),

          bottomNavigationBar: const BottomTabBar(),
          body: BottomTabView(
            location: submitted,
            isGeo: isGeo,
            isError: isError,
            isSearching: isSearching,
            destinations: destinations,
            weatherData: weatherData,
            showResult: showResult,
          ),
        ),
      ),
    );
  }
}
