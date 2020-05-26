
import 'dart:math';

import 'package:projectMath/model/question.dart';

class MathQuestion implements Question{
  int _level;
  String _question;
  String _operater;
  int _number1;
  int _number2;
  
  MathQuestion(int level){
    this._level = level;
    this._question = _generateQuestion();
   
  }

  int getLevel(){
    return _level;
  }
  String getQuestion(){
    return _question;
  }

  
  String _generateQuestion(){
    var rnd = new Random();
    int number;
    List<int> list;

    if (_level <= 5){
      number = rnd.nextInt(2);
      _operater = number==1 ? '+' : '-'; 
      list = _getRandomNumbers(2, 1, 10,_operater);

    }
    else if (_level <= 10){
      number = rnd.nextInt(2);
      list = _getRandomNumbers(2,10,100,_operater);
      _operater = number==1 ? '+' : '-'; 
    }
    else if (_level <= 15){
      int number = rnd.nextInt(2);
      _operater = 'x' ;
      list = _getRandomNumbers(2, 2, 12,_operater);

    }
    else if (_level <= 20){
      number = rnd.nextInt(2);
      _operater = '÷';
      list = _getRandomNumbers(2, 2, 30,_operater);
      
    }
    else{
      number = rnd.nextInt(2);
      _operater = number==1 ? 'x' : '÷';
      list = _getRandomNumbers(2, 2, 50,_operater);
      
      
    }
    return "${list[1]} $_operater ${list[0]}";
  }
  List<int> _getRandomNumbers(int count,int start,int end,String operater){
    var rnd = new Random();
    end -= start;
    List<int> list;
    if(operater == '÷'){
      list = new List<int>();
      list.add( start+rnd.nextInt(end) );
      list.add( 1+rnd.nextInt((list[0]/2).round()) );
    }
    else{
      list = new List.generate(count, (_) => (start + rnd.nextInt(end)));
    }
    list.sort();
    _number1 = list[0];
    _number2 = list[1];
    return list;
  }

  @override
  getQuestionType() {
    // TODO: implement getQuestionType
    return QUESTIONTYPE.questionMath;
  }

  

  

}