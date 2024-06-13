
import 'package:flutter/material.dart';
import 'package:weatherapp_proj/footer.dart';
import 'package:weatherapp_proj/json.dart';
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
  String submitted = "";

  void onSearchSubmit(String val) {
    if (val.length > 45) {
      val = "${val.substring(0, 42)}...";
    }
    setState(() {
      isGeo = false;
      isError = false;
      submitted = val;
    });
  }

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
      if (deserialized['results'] == null)
      {
        return [];
      }
      final Result result = Result.fromJson(deserialized);
      final List<Destination> destinations = result.destinations;
      return destinations;
  }

  void onSearchChange(String val)
  {
      String apiUrl = "https://geocoding-api.open-meteo.com/v1/search?count=5&name=$val";
      
      isSearching = false;
      if(val.length < 3)
      {
        setState(() {
          
        isSearching = false;
        });

        debugPrint("val < 3 -> no api call");

        return;
      }
      
      Future<List<Destination>> future = _callGeoCodingApi(apiUrl);
      future.then((value){

        debugPrint("####################################");
        debugPrint(value.toString());

        //TODO HERE


          setState(() {
            isSearching = true;
            destinations = value;
            // searching = true;
           });

      });
  }


  void onClickGeolocation() {
  Future<Position> future = _determinePosition();
  future.then((value) {
    setState(() {
        isError = false;
        isGeo = true;
        //here logic [coords] -> [place name] -> [weather]
        submitted = value.toString();
    });
  })
  .catchError((error) {
    setState(() {
        isError = true;
        isGeo = true;
        submitted = error;
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
              ]),


          bottomNavigationBar: const BottomTabBar(),
          // body: BottomTabView(location: submitted, isGeo: isGeo, isError: isError,),
          body: BottomTabView(location: submitted, isGeo: isGeo, isError: isError,),
        ),
      ),
    );
  }
}

