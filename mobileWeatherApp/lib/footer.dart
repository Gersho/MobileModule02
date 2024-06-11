import 'package:flutter/material.dart';

class BottomTabBar extends StatelessWidget {
  const BottomTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF3F5AA6),
      child: const TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: Colors.blue,
        tabs: [
          Tab(text: "Currently", icon: Icon(Icons.timer_outlined)),
          Tab(text: "Today", icon: Icon(Icons.calendar_today)),
          Tab(text: "Weekly", icon: Icon(Icons.calendar_view_week)),
        ],
      ),
    );
  }
}

class BottomTabView extends StatelessWidget {
  final String location;
  final bool isGeo;
  final bool isError;

  const BottomTabView({super.key, required this.location, required this.isGeo, required this.isError});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // String displayMessage = isGeo ? "Geolocation" : location;


    String displayMessage = location;

    // if (isGeo)
    // {





    //     // displayMessage = location;
    // }
    // else
    // {
    //   displayMessage = location;
    // }







    return TabBarView(
      children: [
        TabCenteredChild(children: [
          Text("Currently", style: TextStyle(fontSize: size.height * 0.04)),
          Text(displayMessage, style: TextStyle(fontSize: size.height * 0.04))
        ]),
        TabCenteredChild(children: [
          Text("Today", style: TextStyle(fontSize: size.height * 0.04)),
          Text(displayMessage, style: TextStyle(fontSize: size.height * 0.04))
        ]),
        TabCenteredChild(children: [
          Text("Weekly", style: TextStyle(fontSize: size.height * 0.04)),
          Text(displayMessage, style: TextStyle(fontSize: size.height * 0.04))
        ]),
      ],
    );





  }
}

class TabCenteredChild extends StatelessWidget {
  final List<Widget> children;

  const TabCenteredChild({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }
}
