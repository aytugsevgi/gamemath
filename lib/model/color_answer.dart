import 'dart:math';

import 'package:flutter/material.dart';
import 'package:projectMath/customType/answer_type.dart';
import 'package:projectMath/model/color_question.dart';
import 'package:projectMath/model/question.dart';

import 'answer.dart';

class ColorAnswer implements Answer{
  List _answers;
  ColorQuestion colorQuestion;
  ANSWERTYPE _trueAnswer;
  String _trueAnswerStr; 
  ColorAnswer(ColorQuestion colorQuestion){
    this.colorQuestion = colorQuestion;
  }
  List<Color> getAnswers(){
    Random random = new Random();
    List<Color> colors = colorQuestion.getColors();
    List<String> colorsName = colorQuestion.getColorsName();
    _answers = new List<Color>();
    _answers.add(colorQuestion.color);
    int colorNameIndex = colorsName.indexOf(colorQuestion.getColorName());
    print("asdasda -- "+colorQuestion.getColorName());
    Color colorNameColor = colors[colorNameIndex];
    _answers.add(colorNameColor);
    colors.remove(colorQuestion.color);
    colors.remove(colorNameColor);
    print("1${_answers.toString()}",);
    while(_answers.length<4){
      _answers.add(colors.removeAt(random.nextInt(colors.length)));
      print("2${_answers.toString()}",);
    }
    _answers = _mixedAnswers(_answers);
      int trueAnswerIndex;
    if (colorQuestion.getQuestionType() == QUESTIONTYPE.questionColor){
      trueAnswerIndex = _answers.indexOf(colorQuestion.color);  
    }
    else{
      trueAnswerIndex = _answers.indexOf(colorNameColor);
    }
    switch(trueAnswerIndex){
        case 0: _trueAnswer = ANSWERTYPE.a; break;
        case 1: _trueAnswer = ANSWERTYPE.b; break;
        case 2: _trueAnswer = ANSWERTYPE.c; break;
        case 3: _trueAnswer = ANSWERTYPE.d; break;
      }
    print("index $trueAnswerIndex");
    return _answers;
  }
  List _mixedAnswers(List answersList) {
    Color temp;
    int n;
    Random random = new Random();
    for (int i = answersList.length - 1; i > 0; i--) {
      n = random.nextInt(i + 1);
      temp = answersList[i];
      answersList[i] = answersList[n];
      answersList[n] = temp;
    }
    return answersList;
  }

  @override
  ANSWERTYPE getTrueAnswer() {
    // TODO: implement getTrueAnswer
    return _trueAnswer;
  }
  Color getTrueColor(){
    return colorQuestion.color;
  }
}