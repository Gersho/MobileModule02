import 'package:flutter/material.dart';
import 'package:weatherapp_proj/geocoding.dart';
import 'package:weatherapp_proj/weather.dart';
import 'package:weatherapp_proj/main.dart';
import 'package:provider/provider.dart';

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
  final Destination location;
  final bool isGeo;
  final bool isError;
  final bool isSearching;
  final bool showResult;
  final List<Destination> destinations;
  final FullWeatherData weatherData;

  const BottomTabView(
      {super.key,
      required this.location,
      required this.isGeo,
      required this.isError,
      required this.isSearching,
      required this.destinations,
      required this.weatherData,
      required this.showResult});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Color color = isError ? Colors.red : Colors.black;

    if (showResult) {
      return TabBarView(
        children: [
          //Currently
          TabCenteredChild(children: [
            Text('${location.city} ',
                style: TextStyle(fontSize: size.height * 0.04)),
            Text(' ${location.admin1} ${location.country}',
                style: TextStyle(fontSize: size.height * 0.02)),
            Text('${weatherData.current.temperature} °C',
                style: TextStyle(fontSize: size.height * 0.04)),
            Text(getWeatherInfoFromWeatherCode(weatherData.current.weathercode),
                style: TextStyle(fontSize: size.height * 0.04)),
            Text('${weatherData.current.windspeed} km/h winds',
                style: TextStyle(fontSize: size.height * 0.04)),
          ]),

          //Today
          ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: weatherData.hourly.time.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Column(
                    children: [
                      Text('${location.city} ',
                          style: TextStyle(fontSize: size.height * 0.04)),
                      Text(' ${location.admin1} ${location.country}',
                          style: TextStyle(fontSize: size.height * 0.02)),
                    ],
                  );
                } else {
                  return Container(
                      height: size.height * 0.05,
                      color: Color.fromARGB(255, 158, 168, 245),
                      child: SearchResultItem(
                        children: [
                          Text(
                              '${weatherData.hourly.time[index - 1]} : ${weatherData.hourly.temperature[index - 1]} : ${weatherData.hourly.windspeed[index - 1]} km/h: ${getWeatherInfoFromWeatherCode(weatherData.hourly.weathercode[index - 1])} ',
                              style: TextStyle(fontSize: size.height * 0.02)),
                        ],
                      ));
                }
              }),

          //Weekly
          ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: weatherData.daily.time.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Column(
                    children: [
                      Text('${location.city} ',
                          style: TextStyle(fontSize: size.height * 0.04)),
                      Text(' ${location.admin1} ${location.country}',
                          style: TextStyle(fontSize: size.height * 0.02)),
                    ],
                  );
                } else {
                  return Container(
                      height: size.height * 0.10,
                      color: Color.fromARGB(255, 158, 168, 245),
                      child: SearchResultItem(
                        children: [
                          Text(
                              '${weatherData.daily.time[index - 1]} : ${weatherData.daily.temperatureMin[index - 1]} / ${weatherData.daily.temperatureMax[index - 1]} : ${getWeatherInfoFromWeatherCode(weatherData.daily.weathercode[index - 1])} ',
                              style: TextStyle(fontSize: size.height * 0.02)),
                        ],
                      ));
                }
              })
        ],
      );
    } else if (!isSearching) {
      return TabBarView(
        children: [
          TabCenteredChild(children: [
            Text("Use Geolocalisation or Search",
                style: TextStyle(fontSize: size.height * 0.04)),
          ]),
          TabCenteredChild(children: [
            Text("Use Geolocalisation or Search",
                style: TextStyle(fontSize: size.height * 0.04)),
          ]),
          TabCenteredChild(children: [
            Text("Use Geolocalisation or Search",
                style: TextStyle(fontSize: size.height * 0.04)),
          ]),
        ],
      );
    } else {
      if (destinations.isEmpty) {
        return TabCenteredChild(children: [
          Text("No result found",
              style: TextStyle(
                  fontSize: size.height * 0.03, color: Colors.deepOrange)),
        ]);
      } else {
        return ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: destinations.length,
            itemBuilder: (BuildContext context, int index) {


            return GestureDetector(
                onTap: (){


                context.read<Counter>().getClick(destinations[index]);
                },
                  
                child: Container(
                    height: size.height * 0.10,
                    color: Colors.amber,
                    child: SearchResultItem(children: [
                      Text(destinations[index].city,
                          style: TextStyle(fontSize: size.height * 0.03)),
                      Text(
                          '${destinations[index].admin1}, ${destinations[index].country}',
                          style:
                              TextStyle(fontSize: size.height * 0.02, color: color))
                    ]),
                  ),
              );






              // return Container(
              //   height: size.height * 0.10,
              //   color: Colors.amber,
              //   child: SearchResultItem(children: [
              //     Text(destinations[index].city,
              //         style: TextStyle(fontSize: size.height * 0.03)),
              //     Text(
              //         '${destinations[index].admin1}, ${destinations[index].country}',
              //         style:
              //             TextStyle(fontSize: size.height * 0.02, color: color))
              //   ]),
              // );






            });
      }
    }
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

class SearchResultItem extends StatelessWidget {
  final List<Widget> children;

  const SearchResultItem({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
}
