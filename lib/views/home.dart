import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeoweather/constants/app_constants.dart';
import 'package:zeoweather/controllers/weather_controller.dart';
import 'package:zeoweather/services/email_service.dart';
import 'package:zeoweather/services/weather_service.dart';
import 'package:zeoweather/views/components/aggregate_item.dart';
import 'package:zeoweather/views/components/history_item.dart';
import 'package:zeoweather/views/components/hourly_item.dart';
import 'package:zeoweather/views/configure.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final WeatherService weatherService = Get.put(WeatherService());
  final EmailService emailService = Get.put(EmailService());
  final WeatherController weatherController = Get.put(WeatherController());

  Map<String, dynamic>? weatherData;
  bool isLoading = true;
  Timer? timer;
  bool alertTriggered = false;
  final Duration updateInterval =const Duration(minutes: 5);
  String updateTime = DateFormat('HH:mm').format(DateTime.now());
  String selectedCity = 'Hyderabad'; 
  

  @override
  void initState() {
    super.initState();
    fetchWeather();
    startPeriodicWeatherUpdate();
  }


  @override
  void dispose() {
    timer?.cancel();  
    super.dispose();
  }

   Future<void> fetchWeather() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int thresholdValue = int.parse(prefs.getString("threshold") ?? "32");
    if (kDebugMode) {
      print("fetching for $selectedCity");
    }
    try {
      // Fetch weather data for the selected city
      final data = await weatherService.fetchCityWeather(selectedCity);
      await weatherService.getHourWeather(selectedCity);
      await weatherController.fetchHistoricalData(selectedCity);
      setState(() {
        weatherData = data;
        isLoading = false;
        if (weatherData!['temp'] >= thresholdValue && !alertTriggered) {
          triggerAlert(weatherData!['temp']);
        }
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> triggerAlert(double temperature) async {

    alertTriggered = true;
    await emailService.sendEmailAlert(weatherData!['temp'],weatherData!['main'],"Hyderabad");
  }
  

  void startPeriodicWeatherUpdate() {
    timer = Timer.periodic(updateInterval, (Timer t) {
      fetchWeather(); 
      setState(() {
        updateTime = DateFormat('HH:mm').format(DateTime.now());
      });
      print("Called Weather API/-/-/-/-/////////////////////////---------");
    });
  }

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : weatherData != null
                ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                   decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 0, 8, 59),
                        Color.fromARGB(255, 0, 14, 104),
                        Color.fromARGB(255, 255, 255, 255),
                      ],
                      stops: [0.0,0.5,1]
                    )
                  ),
                  child:SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 35.0, left: 12, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Use Row to combine city name and dropdown button
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      
                                      DropdownButton<String>(
                                        value: selectedCity,
                                        dropdownColor: const Color.fromARGB(255, 0, 14, 104),  // Color for dropdown items
                                        icon: const Icon(Icons.arrow_drop_down, color: Colors.white), // Dropdown icon
                                        style: const TextStyle(
                                          fontSize: 30,
                                          color: Colors.white,
                                          fontFamily: 'man-sb',
                                        ),
                                        items: AppConstants.cities.map((String city) {
                                          return DropdownMenuItem<String>(
                                            value: city,
                                            child: Text(city),
                                          );
                                        }).toList(),
                                        onChanged: (String? newCity) {
                                          setState(() {
                                            selectedCity = newCity!;
                                            isLoading = true;
                                          });
                                          fetchWeather(); // Fetch weather for the selected city
                                        },
                                      ),
                                      
                                    ],
                                  ),
                                  Text("Last Updated at: $updateTime", style: TextStyle(fontFamily: 'man-l',fontSize: 14, color: Colors.white),)
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(const Configure());
                                },
                                child: const Icon(Icons.settings, size: 30, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 280,
                          alignment: Alignment.center,
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('${weatherData!['temp'].toStringAsFixed(0)}', style:const  TextStyle(fontFamily: 'man-b', fontSize: 100, color: Colors.white),),
                                    const Text("°",style: TextStyle(fontFamily: 'man-l', fontSize: 15, color: Colors.white),),
                                    const Text("c",style: TextStyle(fontFamily: 'man-r', fontSize: 30, color: Colors.white),)
                                  ],
                                ),
                                Text('${weatherData!['main']}',style: const TextStyle(fontSize: 25, fontFamily: 'man-sb',color: Color.fromARGB(255, 255, 255, 255)),),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Feels Like ${weatherData!['feels_like'].toStringAsFixed(0)}',style: const TextStyle(fontSize: 18, fontFamily: 'man-sb',color: Color.fromARGB(255, 255, 255, 255)),),
                                    const Text("°",style: TextStyle(fontFamily: 'man-l', fontSize: 15, color: Colors.white),),
                                    const Text("c",style: TextStyle(fontFamily: 'man-sb', fontSize: 18, color: Colors.white),)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        
                        Container(
                          margin: const EdgeInsets.all(15),
                          width: MediaQuery.of(context).size.width,
                          height:80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color:Color.fromARGB(0, 255, 255, 255),
                          ),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: weatherService.hourlyData!.length,
                            itemBuilder: (context, index){
                              return hourlyItem(weatherService.hourlyData![index]["time"].toString(),weatherService.hourlyData![index]["temp_c"]);
                            }
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          height: 90,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color.fromARGB(62, 255, 255, 255),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              aggregateItem(weatherService.aggregate['maxtemp_c'], "Maximum"),
                              aggregateItem(weatherService.aggregate['mintemp_c'], "Minimum"),
                              aggregateItem(weatherService.aggregate['avgtemp_c'], "Average"),
                            Container(
                                width: 70,
                                height: 70,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(weatherData!['main'], style: TextStyle(fontFamily: 'man-sb', fontSize: 15, color: Colors.white),),
                                  
                                      ],
                                    ),
                                  Text("Dominat", style: const TextStyle(fontFamily: 'man-sb', fontSize: 12, color: Colors.white),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 150,
                          margin:const EdgeInsets.all(15),
                          
                          child: ListView.builder(
                            itemCount: weatherController.weatherData!.length,
                            itemBuilder: (context, index){
                            return historyItem(
                              weatherController.weatherData![index]["date"], 
                              weatherController.weatherData![index]["weather"], 
                              weatherController.weatherData![index]["temperature"], 
                            );
                          })
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          color:Colors.red,
                        )
                      ],
                    ),
                  ),
                )
                : const Center(
                    child: Text(
                      'Failed to load weather data',
                      style: TextStyle(fontSize: 18, color: Colors.red),
                    ),
                  ),

    );
  }
}


