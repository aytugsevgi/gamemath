import 'dart:math';

import 'package:flutter/material.dart';
import 'package:projectMath/model/question.dart';

class ColorQuestion implements Question{
  String _question;
  QUESTIONTYPE _questionType;
  Color color;
  String _colorName;
  ColorQuestion();
  List<Color> _colors = [Colors.green,Colors.blue,Colors.brown,Colors.red,Colors.orange,Colors.black,Colors.purple,Colors.yellow];
  List<String> _colorsName = ["Yeşil","Mavi","Kahverengi","Kırmızı","Turuncu","Siyah","Mor","Sarı"];
  String getQuestion(){
    Random random = new Random();
    bool temp = random.nextInt(2) == 1 ? true : false;
    _questionType = temp ? QUESTIONTYPE.questionColor : QUESTIONTYPE.questionWord;
    int value1; int value2;
    value1 = random.nextInt(_colors.length);
    value2 = random.nextInt(_colors.length);
    while(value1==value2){
      value2 = random.nextInt(_colors.length);
    }
    color = _colors[value1];
    _colorName = _colorsName[value2];
    _question = _colorName;
    return _question;
    
   
  }
  String getColorName(){
    return _colorName;
  }
  QUESTIONTYPE getQuestionType(){
    return _questionType;
  }
  List<Color> getColors(){
    return _colors;
  }
  List<String> getColorsName(){
    return _colorsName;
  }

}