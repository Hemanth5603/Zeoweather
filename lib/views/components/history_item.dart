import 'package:flutter/material.dart';

Widget historyItem(String date, String weather, double temp) {
  return Row(
    children: [
      Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Add children for the inner Row, such as Text, Icons, etc.
              Text(date, style: TextStyle(fontFamily: 'man-sb', color: Colors.white, fontSize: 14),),
              Text(weather, style: TextStyle(fontFamily: "man-sb", fontSize: 14, color: Colors.white)),
              Text("$temp°C", style: TextStyle(fontFamily: 'man-sb',fontSize: 14, color: Colors.white),)
            ],
          ),
        ),
      ),
    ],
  );
}
