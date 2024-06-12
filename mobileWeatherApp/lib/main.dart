import 'dart:io';

import 'package:flutter/material.dart';
import 'package:weatherapp_proj/footer.dart';
import 'package:weatherapp_proj/searchbar.dart';
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
        debugPrint("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
        debugPrint(response.body);
        // List<Destination> list = parseAgents(response.body);
        List<Destination> list = parseAgents(response.body);
        debugPrint("*********************************");
        return list;
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }



  static List<Destination> parseAgents(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Destination>((json) => Destination.fromJson(json)).toList();
  }



  // static List<Destination> parseAgents(String responseBody) {
  //   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  //   return parsed.map<Destination>((json) => Destination.fromJson(json)).toList();
  // }


  void onSearchChange(String val)
  {
      String apiUrl = "https://geocoding-api.open-meteo.com/v1/search?count=5&name=$val";
      if(val.length < 3)
      {
        debugPrint("val < 3 -> no api call");
        return;
      }

      Future<List<Destination>> future = _callGeoCodingApi(apiUrl);
      future.then((value){

        debugPrint("####################################");
        debugPrint(value.toString());


          setState(() { });

      });
      // List


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




// /flutter ( 7452): Receiver: _Map len:2
// E/flutter ( 7452): Tried calling: cast<Map<String, dynamic>>()
// E/flutter ( 7452): Found: cast<Y0, Y1>() => Map<Y0, Y1>
// E/flutter ( 7452): #0      WeatherAppState._callGeoCodingApi (package:weatherapp_proj/main.dart:82:7)
// E/flutter ( 7452): <asynchronous suspension>
// E/flutter ( 7452): #1      WeatherAppState.onSearchChange.<anonymous closure> (package:weatherapp_proj/main.dart:105:19)
// E/flutter ( 7452): <asynchronous suspension>
// E/flutter ( 7452): 