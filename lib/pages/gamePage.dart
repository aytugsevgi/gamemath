import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:projectMath/customType/answer_type.dart';
import 'package:projectMath/model/currentTime.dart';
import 'package:projectMath/model/question.dart';
import 'package:projectMath/model/questionController.dart';
import 'package:projectMath/pages/gameoverPage.dart';
import 'package:projectMath/transitions/fade_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GamePage extends StatefulWidget {
  GAMETYPE gametype;
  GamePage({GAMETYPE gametype}){
    this.gametype = gametype;
  }
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  QuestionController questionController;
  GAMETYPE _gametype;
  QUESTIONTYPE _questiontype;
  String _strQuestion;
  List _answers;
  Timer _timer;
  CurrentTime _currentTime;
  List<Color> _colorList;
  int _start = 10;
  int _score = 0;
  int _level = 0;
  Color _questionColor;

  @override
  void initState() {
    _gametype = widget.gametype;
    questionController = new QuestionController(gametype: _gametype);
    _currentTime = new CurrentTime(_start);
    _colorList = [Colors.amberAccent, Colors.green, Colors.red, Colors.blue];
    updateGame();
    startTimer();
    super.initState();
  }

  void updateGame() {
    setState(() {
      _strQuestion = questionController.getQuestion();
      _level = questionController.getLevel();
      _answers =  questionController.getAnswers();
      _gametype = questionController.gametype ;
      _questiontype = questionController.getQuestionType();
      print("QQQ--"+_questiontype.toString());
      if (_gametype == GAMETYPE.gameColor){
        _colorList = _answers;
        _answers = ["","","",""];
        _questionColor = questionController.getTrueColor();
      }
      else{
        _colorList = [Colors.amberAccent, Colors.green, Colors.red, Colors.blue];
        _colorList = _mixedColors(_colorList);
        _questionColor=Colors.white;
      }
      

    });
  }

  void checkAnswer(ANSWERTYPE value) {
    if (questionController.checkAnswer(value)) {
      print("checkanswer if");
      levelUp();
    } else {
      loseGame();
    }
  }

  void levelUp() {
    updateGame();
    setState(() {
      _score += _level + _currentTime.getTime();
    });
    addTime();
  }

  void loseGame() async{
    final SharedPreferences prefs = await _prefs;
    List<String> scoretable;
    if (prefs.getStringList('scoretable') == null){
      scoretable = new List<String>();
      
    } else{
      scoretable = prefs.getStringList('scoretable');
    }
    scoretable.add(_score.toString());
    prefs.setStringList('scoretable', scoretable);
    _timer.cancel();
    Navigator.pushReplacement(
        context, FadeRoute(page: GameOverPage(score: this._score)));
  }

  void addTime() {
    setState(() {
      _currentTime.addTime(3);
    });
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_currentTime.getTime() < 1) {
            loseGame();
          } else {
            _currentTime.decreaseTime();
          }
        },
      ),
    );
  }

  List<Color> _mixedColors(List<Color> colorList) {
    Color temp;
    int n;
    Random random = new Random();
    for (int i = colorList.length - 1; i > 0; i--) {
      n = random.nextInt(i + 1);
      temp = colorList[i];
      colorList[i] = colorList[n];
      colorList[n] = temp;
    }
    return colorList;
  }
  Widget getQuestion(){
    if( _gametype == GAMETYPE.gameMath ){
      return Container(
              padding:EdgeInsets.all(30),       
              decoration: BoxDecoration(
                color: Colors.green[800],
                border: Border.all(color: Colors.brown,width: 2)
              ),
              child: Text(
                "$_strQuestion = ?",
                style: TextStyle(
                  color: _questionColor,
                  fontSize: 28,
                  shadows:[Shadow(color: Colors.black45,blurRadius: 1)] 
                ),
              ),
            );
    
    }
    else{
      return Container(
              padding:EdgeInsets.all(2),
              child: Column(
                children: <Widget>[
                  Text(
                    getColorQuestionText(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      shadows:[Shadow(color: Colors.black45,blurRadius: 1)] 
                    ),
                  ),
                  Text(
                    "$_strQuestion?",
                    style: TextStyle(
                      color: _questionColor,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            );
    }
  }
  String getColorQuestionText(){
    if(_questiontype == QUESTIONTYPE.questionColor){
      return "Yazının rengi hangisidir?";
    }
    else{
      return "Yazılan renk hangisidir?";
    }
  }
  @override
  Widget build(BuildContext context) {
    final Size SCREEN_SIZE = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: SCREEN_SIZE.width,
        height: SCREEN_SIZE.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "${_level}.Soru",
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
         
            Text("${_currentTime.getTime().toString()}",
              style: TextStyle(fontSize: 36, color: Colors.blueAccent),),
            
            Divider(
              height: 15,
            ),
            getQuestion(),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: SCREEN_SIZE.width * 0.4,
                      height: SCREEN_SIZE.width * 0.4,
                      child: RaisedButton(
                          onPressed: () => checkAnswer(ANSWERTYPE.a),
                          color: _colorList[0],
                          child: Text(_answers[0],
                              style: TextStyle(
                                  fontSize: 24, color: Colors.white))),
                    ),
                    Container(
                      width: SCREEN_SIZE.width * 0.4,
                      height: SCREEN_SIZE.width * 0.4,
                      child: RaisedButton(
                          onPressed: () => checkAnswer(ANSWERTYPE.b),
                          color: _colorList[1],
                          child: Text(_answers[1],
                              style: TextStyle(
                                  fontSize: 24, color: Colors.white))),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: SCREEN_SIZE.width * 0.4,
                      height: SCREEN_SIZE.width * 0.4,
                      child: RaisedButton(
                          onPressed: () => checkAnswer(ANSWERTYPE.c),
                          color: _colorList[2],
                          child: Text(_answers[2],
                              style: TextStyle(
                                  fontSize: 24, color: Colors.white))),
                    ),
                    Container(
                      width: SCREEN_SIZE.width * 0.4,
                      height: SCREEN_SIZE.width * 0.4,
                      child: RaisedButton(
                          onPressed: () => checkAnswer(ANSWERTYPE.d),
                          color: _colorList[3],
                          child: Text(_answers[3],
                              style: TextStyle(
                                  fontSize: 24, color: Colors.white))),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
