import 'dart:convert';

import 'package:get/get.dart';
  import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:zeoweather/models/weather_model.dart';
  
class WeatherService extends GetxController{
  final String apiKey = '5b0270718fff59c21b50444266ba65f6';
  final String cityWeatherUrl = 'https://api.openweathermap.org/data/2.5/weather';
  final String hourlyWeatherUrl = 'https://api.openweathermap.org/data/2.5/onecall';
  //WeatherModel weatherModel = WeatherModel(location: location, current: current, forecast: forecast)
  List<dynamic>? hourlyData;
  var aggregate;
  List<Map<String, dynamic>>? past5DaysWeather;


  Future<Map<String, dynamic>> fetchCityWeather(String city) async {
    final response = await http.get(
      Uri.parse('$cityWeatherUrl?q=$city&appid=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {
        'main': data['weather'][0]['main'],
        'temp': data['main']['temp'] - 273.15,  // Kelvin to Celsius
        'feels_like': data['main']['feels_like'] - 273.15,
        'dt': data['dt'],
      };
    } else {
      throw Exception('Failed to load weather data');
    }
  }






Future<void> getHourWeather(String city) async {
    const String apiKey = "e2ac2871075d467f928124809242010";
    const String uri = 'http://api.weatherapi.com/v1/forecast.json';
    final response = await http.get(
      Uri.parse('$uri?key=$apiKey&q=$city&days=1'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      //weatherModel = WeatherModel.fromJson(data);
      // Extract the hourly data for today
      hourlyData = data['forecast']['forecastday'][0]['hour'];  
      aggregate = data['forecast']['forecastday'][0]['day'];
       
    } else {
      throw Exception('Failed to fetch hourly weather data');
    }
  }



Future<List<Map<String, dynamic>>> fetchPast5DaysWeather(String location) async {
    List<Map<String, dynamic>> past5DaysWeather = [];
    const String apiKey = "e2ac2871075d467f928124809242010";
    const String baseUrl = 'http://api.weatherapi.com/v1/history.json';
    // Get today's date
    DateTime today = DateTime.now();

    // Loop through the past 5 days
    for (int i = 0; i < 5; i++) {
      // Get the date for the past day
      DateTime pastDate = today.subtract(Duration(days: i));
      String formattedDate = DateFormat('yyyy-MM-dd').format(pastDate);  // Format the date as 'YYYY-MM-DD'

      // Make the API call to fetch weather data for the specific day
      String apiUrl = '$baseUrl?key=$apiKey&q=$location&dt=$formattedDate';
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Parse the response body
        Map<String, dynamic> weatherData = json.decode(response.body);

        // Extract the required information (date, weather condition, avg temperature)
        String date = weatherData['forecast']['forecastday'][0]['date'];
        String condition = weatherData['forecast']['forecastday'][0]['day']['condition']['text'];
        double avgTemp = weatherData['forecast']['forecastday'][0]['day']['avgtemp_c'];

        // Store extracted data in the list
        past5DaysWeather.add({
          'date': date,
          'weather': condition,
          'temperature': avgTemp,
        });
      } else {
        throw Exception('Failed to fetch weather data for $formattedDate');
      }
    }

    return past5DaysWeather;
  }
}