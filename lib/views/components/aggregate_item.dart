import 'package:flutter/material.dart';

Widget aggregateItem(double val, String title){
  return Container(
    width: 70,
    height: 80,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(val.toString(), style: TextStyle(fontFamily: 'man-sb', fontSize: 15, color: Colors.white),),
            //const Text("°",style: TextStyle(fontFamily: 'man-l', fontSize: 8, color: Colors.white),),
            //const Text("c",style: TextStyle(fontFamily: 'man-r', fontSize: 12, color: Colors.white),)
          ],
        ),
        Text(title, style: const TextStyle(fontFamily: 'man-sb', fontSize: 12, color: Colors.white),),
      ],
    ),
  );
}
