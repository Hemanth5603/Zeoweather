import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeoweather/controllers/configuration_controller.dart';

class Configure extends StatefulWidget {
  const Configure({super.key});

  @override
  State<Configure> createState() => _ConfigureState();
}

class _ConfigureState extends State<Configure> {
  ConfigurationController configurationController = Get.put(ConfigurationController());

  int thresholdVal = 0;


  void saveConfiguration() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("threshold", configurationController.thresholdController.value.text);
    prefs.setString("email",configurationController.emailController.value.text);
    
    String val = prefs.getString("threshold")!;
    print("Saved congfig $val");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Configure Temperature \nThreshold", style: TextStyle(fontFamily: 'man-sb', fontSize: 25),),
              SizedBox(height: 20,),
              SizedBox(height: 20,),
              Text("Enter Threshold Value", style: TextStyle(fontFamily:'man-r',fontSize: 16),),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller:configurationController.thresholdController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Enter Value',
                    labelStyle: const TextStyle(
                      fontFamily: 'man-l', fontSize: 14),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                  )
                        
                ),
              ),
              const SizedBox(height: 30,),
              const Text("Email Address", style: TextStyle(fontFamily:'man-r',fontSize: 16),),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller:configurationController.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Enter Email to notify',
                    labelStyle: TextStyle(
                      fontFamily: 'man-l', fontSize: 14),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                  )
                ),
              ),
              SizedBox(height: 30,),
              GestureDetector(
                onTap: (){
                  saveConfiguration();
                },
                child: Container(
                  margin: EdgeInsets.all(0),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(255, 0, 0, 0)
                  ),
                  child: Center(
                    child: Text("Save", style: TextStyle(fontSize:16, color: Colors.white, fontFamily: 'man-sb'),),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}