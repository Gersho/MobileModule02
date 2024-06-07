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











class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});
  @override
  State<WeatherApp> createState() => WeatherAppState();
}

class WeatherAppState extends State<WeatherApp> {
  @override
  Widget build(BuildContext context) {


  String submitted = "";

    return MaterialApp(
      home: DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
          appBar: AppBar(

   

              //  title: const Text("Calculator",maxLines: 1, style: TextStyle(fontSize: 30, )),

              // actions: [],

              ),

          // appBar: HeaderBar(),
          // appBar: HeaderBar.testtest(),
          bottomNavigationBar: const bottomTabBar(),
          body: const BottomTabView(location: "", isGeo: false),
        ),
      ),
    );




  }
}



