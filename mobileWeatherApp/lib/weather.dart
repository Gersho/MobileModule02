// Code 	Description
// 0 	Clear sky
// 1, 2, 3 	Mainly clear, partly cloudy, and overcast
// 45, 48 	Fog and depositing rime fog
// 51, 53, 55 	Drizzle: Light, moderate, and dense intensity
// 56, 57 	Freezing Drizzle: Light and dense intensity
// 61, 63, 65 	Rain: Slight, moderate and heavy intensity
// 66, 67 	Freezing Rain: Light and heavy intensity
// 71, 73, 75 	Snow fall: Slight, moderate, and heavy intensity
// 77 	Snow grains
// 80, 81, 82 	Rain showers: Slight, moderate, and violent
// 85, 86 	Snow showers slight and heavy
// 95 * 	Thunderstorm: Slight or moderate
// 96, 99 * 	Thunderstorm with slight and heavy hail

String getWeatherInfoFromWeatherCode(String weatherCode){

  int code = int.parse(weatherCode);

  switch(code)
  {
    case 0:
      return "Clear sky";
    case 1:
      return "Mainly clear";
    case 2: 
      return "Partly cloudy";
    case 3:
      return "Overcast";
    case 45:
      return "Fog";
    case 48:
      return "depositing rime fog";
    case 51:
      return "light drizzle";
    case 53:
      return "moderate drizzle";
    case 55:
      return "dense drizzle";
    case 56:
      return "light freezing drizzle";
    case 57:
      return "dense freezing drizzle";
    case 61:
      return "slight rain";
    case 63:
      return "moderate rain";
    case 65:
      return "heavy rain";
    case 66:
      return "light freezing rain";
    case 67:
      return "heavy freezing rain";
    case 71:
      return "slight snow";
    case 73: 
      return "moderate snow";
    case 75:
      return "heavy snow";
    case 77:
      return "snow grains";
    case 80:
      return "slight rain showers";
    case 81:
      return "moderate rain showers";
    case 82:
      return "violent rain showers";
    case 85:
      return "slight snow showers";
    case 86:
      return "heavy snow showers";
    case 95:
      return "thunderstorm";
    case 96:
      return "slight hail thunderstorm";
    case 99:
      return "heavy hail thunderstorm";
    default:
      return "meteor rain(unknown weathercode)";


  }
}


// IconData getIconFromWeatherCode(String weatherCode){

//   int code = int.parse(weatherCode);
//   switch(code)
//   {
//   }
//   return Icons.safety_check;
// }


class FullWeatherData
{
  DailyWeather daily;
  HourlyWeather hourly;
  CurrentWeather current;

  FullWeatherData({
    required this.daily,
    required this.hourly,
    required this.current,
  });

  factory FullWeatherData.fromJson(Map<String, dynamic> json) {
    return FullWeatherData(
      daily: DailyWeather.fromJson(json['daily']),
      hourly: HourlyWeather.fromJson(json['hourly']),
      current: CurrentWeather.fromJson(json['current'])
    );
  }

  factory FullWeatherData.empty(){
      return FullWeatherData(
        daily: DailyWeather.empty(),
       hourly: HourlyWeather.empty(),
        current: CurrentWeather.empty());
  }
}

class DailyWeather
{
  List<String> time;
  List<String> weathercode;
  List<String> temperatureMin;
  List<String> temperatureMax;

  DailyWeather({
    required this.time,
    required this.weathercode,
    required this.temperatureMin,
    required this.temperatureMax,
  });


  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    return DailyWeather(
      time: (json['time'] as List).map((i) => i.toString()).toList(),
      weathercode: (json['weather_code'] as List).map((i) => i.toString()).toList(),
      temperatureMin: (json['temperature_2m_min'] as List).map((i) => i.toString()).toList(),
      temperatureMax: (json['temperature_2m_max'] as List).map((i) => i.toString()).toList(),
    );
  }

  factory DailyWeather.empty(){
    return DailyWeather(
      time: [],
      weathercode: [],
      temperatureMin: [],
      temperatureMax: [],);
  }


}

class HourlyWeather
{
  List<String> time;
  List<String> temperature;
  List<String> windspeed;
  List<String> weathercode;

  HourlyWeather({
    required this.time,
    required this.temperature,
    required this.windspeed,
    required this.weathercode
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      time: (json['time'] as List).map((i) => i.toString()).toList(),
      temperature: (json['temperature_2m'] as List).map((i) => i.toString()).toList(),
      weathercode: (json['weather_code'] as List).map((i) => i.toString()).toList(),
      windspeed: (json['wind_speed_10m'] as List).map((i) => i.toString()).toList(),
    );
  }


  factory HourlyWeather.empty(){
    return HourlyWeather(
      time: [],
      temperature: [],
      windspeed: [],
      weathercode: [],);
  }

}

class CurrentWeather
{
  String temperature;
  String weathercode;
  String windspeed;

  CurrentWeather({
      required this.temperature,
      required this.weathercode,
      required this.windspeed,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      temperature: json['temperature_2m'].toString(),
      weathercode: json['weather_code'].toString(),
      windspeed: json['wind_speed_10m'].toString(),
    );
  }

  factory CurrentWeather.empty(){
    return CurrentWeather(
      temperature: "",
      weathercode: "",
      windspeed: "");
  }


  @override
  String toString() => "<Current temp: $temperature, weathercode: $weathercode, windspeed: $windspeed>";
}
