import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:zeoweather/services/weather_service.dart';

class WeatherController extends GetxController{

  List<Map<String, dynamic>>? weatherData;

  // void fetchHourlyWeatherData() async {
  //   WeatherService weatherService = WeatherService();
  
  //   String latitude = '28.6139';  // Example: Delhi
  //   String longitude = '77.2090';

  //   try {
  //     weatherData = await weatherService.getHourlyWeather(latitude, longitude);
    
  //     print('Hourly Temperatures:');
  //     for (var hourData in weatherData?['hourly_temps']) {
  //       print('Hour: ${hourData['hour']} - Temperature: ${hourData['temp']}°C');
  //     }

  //     print('Average Temperature: ${weatherData?['average_temp']} °C');
  //     print('Maximum Temperature: ${weatherData?['max_temp']} °C');
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }


  


  Future<void> fetchHistoricalData(String city) async{
    WeatherService weatherService = WeatherService();
    try {
    // Fetch weather data for the past 5 days for "London"
    weatherData = await weatherService.fetchPast5DaysWeather(city);

    // Print the extracted data
    for (var dayData in weatherData!) {
      print('Date: ${dayData['date']}, Weather: ${dayData['weather']}, Temp: ${dayData['temperature']}°C');
    }
  } catch (e) {
    print('Error: $e');
  }
  }

   

}