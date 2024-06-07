import 'package:flutter/material.dart';
import 'package:weatherapp_proj/header.dart';
import 'package:weatherapp_proj/footer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WeatherApp(),
    );
  }
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
          appBar: headerBar(),
          bottomNavigationBar: const bottomTabBar(),
          body: const BottomTabView(),
        ),
      ),
    );
  }
}
