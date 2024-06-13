// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';

// // class TopBar extends StatefulWidget implements PreferredSizeWidget  {
//   abstract class TopBar extends AppBar{
// // class TopBar extends StatefulWidget implements PreferredSizeWidget {
//   TopBar({super.key});
//   @override
//   State<TopBar> createState() => TopBarState();
//   // @override    late Size preferredSize;
//   // @override
//   // Size get preferredSize {
//   // return const Size.fromHeight(20.0);
//   // }
//   // final bool isGeo = false;
//   // final bool isError = false;
//   // final String submitted = "";
//   //   String getSubmitted();
//   // bool getIsGeo();
//   // bool getIsError();
//     String getSubmitted(){return submitted;}
//   bool getIsGeo(){return isGeo;}
//   bool getIsError(){return isError;}
// }

// class TopBarState extends State<TopBar>  {
//   // bool isGeo = false;
//   // bool isError = false;
//   // String submitted = "";


//   // String getSubmitted(){return submitted;}
//   // bool getIsGeo(){return isGeo;}
//   // bool getIsError(){return isError;}


//   void onSearchSubmit(String val) {
//     if (val.length > 45) {
//       val = "${val.substring(0, 42)}...";
//     }
//     setState(() {
//       isGeo = false;
//       isError = false;
//       submitted = val;
//     });
//   }

// //Exemple from doc START
//   Future<Position> _determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//     return await Geolocator.getCurrentPosition();
//   }
// //Exemple from doc END

//   void onClickGeolocation() {
//   Future<Position> future = _determinePosition();
//   future.then((value) {
//     setState(() {
//         isError = false;
//         isGeo = true;
//         //here logic [coords] -> [place name] -> [weather]
//         submitted = value.toString();
//     });
//   })
//   .catchError((error) {
//     setState(() {
//         isError = true;
//         isGeo = true;
//         submitted = error;
//     });
//       });
//   }



//     @override
//   Widget build(BuildContext context) {

// Size size = MediaQuery.of(context).size;

    // return AppBar(
    //           title: SearchBar(
    //             onSubmitted: onSearchSubmit,
    //             leading: const Icon(Icons.search),
    //             hintText: "Search",
    //           ),
    //           actions: [
    //             IconButton(
    //               icon: const Icon(Icons.near_me_rounded),
    //               tooltip: 'Geolocation',
    //               onPressed: onClickGeolocation,
    //             ),
    //           ]);

//   }
// }















// class TopBar extends AppBar with {


//   void onSearchSubmit(String val) {
//     if (val.length > 45) {
//       val = "${val.substring(0, 42)}...";
//     }
//     setState(() {
//       isGeo = false;
//       isError = false;
//       submitted = val;
//     });
//   }

// //Exemple from doc START
//   Future<Position> _determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//     return await Geolocator.getCurrentPosition();
//   }
// //Exemple from doc END

//   void onClickGeolocation() {
//   Future<Position> future = _determinePosition();
//   future.then((value) {
//     setState(() {
//         isError = false;
//         isGeo = true;
//         //here logic [coords] -> [place name] -> [weather]
//         submitted = value.toString();
//     });
//   })
//   .catchError((error) {
//     setState(() {
//         isError = true;
//         isGeo = true;
//         submitted = error;
//     });
//       });
//   }


//   TopBar():super(



//               title: SearchBar(
//                 onSubmitted: onSearchSubmit,
//                 leading: const Icon(Icons.search),
//                 hintText: "Search",
//               ),
//               actions: [
//                 IconButton(
//                   icon: const Icon(Icons.near_me_rounded),
//                   tooltip: 'Geolocation',
//                   onPressed: onClickGeolocation,
//                 ),
//               ]



//   );
// }


















// E/flutter ( 4619): [ERROR:flutter/runtime/dart_vm_initializer.cc(41)] Unhandled Exception: Exception: type '_Map<String, dynamic>' is not a subtype of type 'Result'
// E/flutter ( 4619): #0      WeatherAppState._callGeoCodingApi (package:weatherapp_proj/main.dart:88:7)
// E/flutter ( 4619): <asynchronous suspension>
// E/flutter ( 4619): #1      WeatherAppState.onSearchChange.<anonymous closure> (package:weatherapp_proj/main.dart:136:19)
// E/flutter ( 4619): <asynchronous suspension>
// E/flutter ( 4619): 
// I/flutter ( 4619): @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
// E/flutter ( 4619): [ERROR:flutter/runtime/dart_vm_initializer.cc(41)] Unhandled Exception: Exception: type '_Map<String, dynamic>' is not a subtype of type 'Result'
// E/flutter ( 4619): #0      WeatherAppState._callGeoCodingApi (package:weatherapp_proj/main.dart:88:7)
// E/flutter ( 4619): <asynchronous suspension>
// E/flutter ( 4619): #1      WeatherAppState.onSearchChange.<anonymous closure> (package:weatherapp_proj/main.dart:136:19)
// E/flutter ( 4619): <asynchronous suspension>
// E/flutter ( 4619): 
// D/EGL_emulation( 4619): app_time_stats: avg=343.02ms min=120.39ms max=491.09ms count=3
// D/EGL_emulation( 4619): app_time_stats: avg=499.31ms min=499.07ms max=499.52ms count=3
// Application finished.