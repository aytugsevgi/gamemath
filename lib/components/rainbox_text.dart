import 'dart:math';

import 'package:flutter/material.dart';

class RainbowText extends StatelessWidget {
  String str;
  int strLenght;
  double fontSize;
  FontWeight fontWeight;
  List<Color> colorlist = [
    Colors.green,
    Colors.red,
    Colors.orange,
    Colors.purple,
    Colors.blueGrey,
    Colors.pink,
    Colors.lime,
    Colors.indigoAccent,
    Colors.deepOrange,
    Colors.teal,
  ];
  List<Color> choosedList = new List<Color>();
  RainbowText({@required this.str,this.fontSize=30,this.fontWeight=FontWeight.normal});
  @override
  Widget build(BuildContext context) {
    strLenght = str.length;
    Random random = new Random();
    int colorIndex;
    Color color;
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: str.split("").map((item) {
        
        if (colorlist.isEmpty){
          colorIndex = random.nextInt(choosedList.length);
          color = choosedList[colorIndex];
        }
        else{
          colorIndex = random.nextInt(colorlist.length);
          color = colorlist.removeAt(colorIndex);
          choosedList.add(color);
        }
      
      return new Text(item, style: TextStyle(color:color,fontSize: this.fontSize,fontWeight: this.fontWeight,shadows:  [Shadow(color:Colors.black,blurRadius: 1)]));
    }).toList());
  }
}
