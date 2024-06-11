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

//Exemple from doc START
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
//Exemple from doc END

  void onClickGeolocation() {
  Future<Position> future = _determinePosition();
  future.then((value) {
    setState(() {
        isError = false;
        isGeo = true;
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


// Future.delayed(
//   const Duration(seconds: 1),
//   () => throw 401,
// ).then((value) {
//   throw 'Unreachable';
// }).catchError((err) {
//   print('Error: $err'); // Prints 401.
// }, test: (error) {
//   return error is int && error >= 400;
// });

// Future<int> future = getFuture();



  // submitted = snapshot.onError

    // setState(() {
    //   isGeo = true;
    //   submitted = "";
    // });
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
          body: BottomTabView(location: submitted, isGeo: isGeo, isError: isError,),
        ),
      ),
    );
  }
}
