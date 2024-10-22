
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget hourlyItem(String time, double temp){
  DateTime parsedTime = DateTime.parse(time);

  // Extract hour and minute
  String hour = DateFormat('HH').format(parsedTime);  
  String minute = DateFormat('mm').format(parsedTime);  
  return Container(
    height: 100,
    width:70,
    margin: EdgeInsets.symmetric(horizontal: 5),
    alignment: Alignment.center,
    padding: EdgeInsets.only(top: 15),
    decoration: BoxDecoration(
      color: Color.fromARGB(62, 255, 255, 255),
      borderRadius: BorderRadius.circular(12)
    ),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(temp.toString(), style: TextStyle(fontFamily: 'man-sb', fontSize: 15, color: Colors.white),),
            const Text("°",style: TextStyle(fontFamily: 'man-l', fontSize: 8, color: Colors.white),),
            const Text("c",style: TextStyle(fontFamily: 'man-r', fontSize: 12, color: Colors.white),)
          ],
        ),
        const SizedBox(height: 5,),
        Text("$hour:$minute", style: const TextStyle(fontFamily: 'man-sb', fontSize: 12, color: Colors.white),),
      ],
    ),
  );
}
