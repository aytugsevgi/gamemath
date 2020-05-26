import 'dart:math';

import 'package:projectMath/customType/answer_type.dart';
import 'package:projectMath/model/answer.dart';

class MathAnswer implements Answer {
  String _question;
  List<String> _answers;
  String _trueAnswerStr;
  ANSWERTYPE _trueAnswer;
  MathAnswer(String question) {
    this._question = question;
    this._answers = _getAnswers(_question);
  }
  List<String> getAnswers() {
    return _answers;
  }

  ANSWERTYPE getTrueAnswer() {
    return _trueAnswer;
  }

  List<String> _getAnswers(String question) {
    double result;
    int result2;
    int value1;
    int value2;
    
    String operater;
    List<String> splitQuestion = new List<String>(3);
    splitQuestion = question.split(" ");
    value1 = int.parse(splitQuestion[0]);
    value2 = int.parse(splitQuestion[2]);
    operater = splitQuestion[1];
    result = _calculate(value1, value2, operater);
    List<String> answer_list = new List<String>();
    //bölme işlemi if. çünkü bölme işlemi haricinde int sonuç istiyoruz. bölmede double gelebilir.
    if (operater == '÷') {
      double fakeResult;
      _trueAnswerStr = result.toStringAsFixed(2);
      answer_list.add(_trueAnswerStr);
      while (answer_list.length != 4) {
        var rnd = new Random();
        fakeResult = result-0.5 + rnd.nextInt(100)*0.01;
        String strfakeResult = fakeResult.toStringAsFixed(2);
        if (!answer_list.contains(strfakeResult)) {
          answer_list.add(strfakeResult);
        }
      }
    } else {
      int fakeResult;
      result2 = result.toInt();
      _trueAnswerStr = result2.toString();
      answer_list.add(_trueAnswerStr);
      while (answer_list.length != 4) {
        var rnd = new Random();
        if (operater == 'x' && (value1.toString().length + value2.toString().length) > 2){
          fakeResult = result2 + ( 10*(1+rnd.nextInt(10)) *(rnd.nextInt(2) == 1 ? 1: -1));
        }
        else{
          fakeResult = result2 + 10 - rnd.nextInt(25);
        }

        String strfakeResult = fakeResult.toString();
        if (!answer_list.contains(strfakeResult)) {
          answer_list.add(strfakeResult);
        }
      }
    }
    answer_list = _mixedAnswers(answer_list);
    int trueAnswerIndex = answer_list.indexOf(_trueAnswerStr);
    //print(trueAnswerIndex);
    switch(trueAnswerIndex){
      case 0: _trueAnswer = ANSWERTYPE.a; break;
      case 1: _trueAnswer = ANSWERTYPE.b; break;
      case 2: _trueAnswer = ANSWERTYPE.c; break;
      case 3: _trueAnswer = ANSWERTYPE.d; break;
    }
    return answer_list;
  }

  List<String> _mixedAnswers(var answersList) {
    String temp;
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

  double _calculate(int value1, int value2, String operater) {
    double result;
    switch (operater) {
      case "+":
        result = (value1 + value2).toDouble();
        break;
      case "-":
        result = (value1 - value2).toDouble();
        break;
      case "x":
        result = (value1 * value2).toDouble();
        break;
      case "÷":
        result = (value1 / value2).toDouble();
        break;
    }
    return result;
  }

  @override
  getTrueColor() {
    // TODO: implement getTrueColor
    throw null;
  }

}
