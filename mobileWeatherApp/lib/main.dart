import 'package:flutter/material.dart';
import 'package:weatherapp_proj/footer.dart';


import 'package:geolocator/geolocator.dart';

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
  String submitted = "";

  void onSearchSubmit(String val) {
    if (val.length > 50) {
      val = val.substring(0, 42) + "...";
    }
    setState(() {
      isGeo = false;
      submitted = val;
    });
  }

  void onClickGeolocation() {
    setState(() {
      isGeo = true;
      submitted = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
              title: SearchBar(
                onSubmitted: onSearchSubmit,
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
          body: BottomTabView(location: submitted, isGeo: isGeo),
        ),
      ),
    );
  }
}
