import 'package:flutter/material.dart';

PreferredSizeWidget headerBar(){
    return AppBar(
          title: const Text("Calculator",
              maxLines: 1,
              style: TextStyle(
                fontSize: 30,
             )));
}





// class headerBar extends StatelessWidget
// {
//   const headerBar({super.key});

//     @override
//     Widget build(BuildContext context) {
//     return AppBar(
//           title: const Text("Calculator",
//               maxLines: 1,
//               style: TextStyle(
//                 fontSize: 30,
//              )));
//     }
    
    
// }