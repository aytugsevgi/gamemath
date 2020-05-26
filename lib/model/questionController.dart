import 'package:flutter/material.dart';
import 'package:projectMath/customType/answer_type.dart';
import 'package:projectMath/model/color_question.dart';
import 'package:projectMath/model/math_answer.dart';
import 'package:projectMath/model/question.dart';

import 'answer.dart';
import 'color_answer.dart';
import 'math_question.dart';

enum GAMETYPE {
  gameMath,
  gameColor,
}

class QuestionController {
  GAMETYPE gametype;
  int _level = 0;
  String questionStr;
  Question _question;
  Answer _answer;
  QuestionController({@required this.gametype});

  String getQuestion() {
    _level++;
    if (_level%4==0){
      gametype = GAMETYPE.gameColor;
    }
    else{
      gametype = GAMETYPE.gameMath;
    }
    if (gametype == GAMETYPE.gameMath) {
      _question = new MathQuestion(_level);
      questionStr = _question.getQuestion();
      return questionStr;
    } else {
      _question = new ColorQuestion();
      questionStr = _question.getQuestion();
      return questionStr;
    }
  }
// colorın cevapları boş olarak dönüyor doğru zaten. soru cümlesi nasıl olacak nasıl renklendireceksin.
  List getAnswers() {
    if (gametype == GAMETYPE.gameMath) {
      _answer = MathAnswer(questionStr);
      return _answer.getAnswers();
    }
    else{
      _answer = ColorAnswer(_question);
  
      return  _answer.getAnswers();
    }
  }
  
  ANSWERTYPE getTrueAnswer() {
    return _answer.getTrueAnswer();
  }
  Color getTrueColor(){
    return _answer.getTrueColor();
  }

  bool checkAnswer(ANSWERTYPE answer) {
    return getTrueAnswer() == answer;
  }

  int getLevel() {
    return _level;
  }
  QUESTIONTYPE getQuestionType(){
    return _question.getQuestionType();
  }
}
