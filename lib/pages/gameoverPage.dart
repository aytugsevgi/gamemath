import 'dart:math';

import 'package:flutter/material.dart';
import 'package:projectMath/components/buttonOne.dart';
import 'package:projectMath/components/rainbox_text.dart';
import 'package:projectMath/model/questionController.dart';
import 'package:projectMath/pages/gamePage.dart';
import 'package:projectMath/pages/homePage.dart';
import '../transitions/fade_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
class GameOverPage extends StatefulWidget {
  int score;
  GameOverPage({int score}){
    this.score = score;

  }

  @override
  _GameOverPageState createState() => _GameOverPageState();
}

class _GameOverPageState extends State<GameOverPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  int _bestScore;
  bool _bestScoreNow = false;

  Future<void> getBestScore() async{
    final SharedPreferences prefs = await _prefs;
    final List<String> scoreListStr = (prefs.getStringList('scoretable') ?? null);
    int bestScore = 0;
    if (scoreListStr !=null){
      List<int> scoreList = scoreListStr.map(int.parse).toList();
      // search max score
      bestScore = scoreList.reduce(max);
    }
    setState(() {
      _bestScore = bestScore;
      if(_bestScore == widget.score){
        _bestScoreNow = true;
      }
      else{
        _bestScoreNow = false;
      }
    });

    
  }
  @override
  void initState(){
    setState(() {
      _bestScore = 0;
    });
    getBestScore();
    super.initState();
  }
  Widget getBestScoreWidget(){
    if (_bestScoreNow){
      return RainbowText(str: "Best Score: ${_bestScore}");
    }
    return Text(
              "Best Score: ${_bestScore}",
              style: TextStyle(fontSize: 32,shadows: [Shadow(color:Colors.black,blurRadius: 20,offset:Offset(0,0))]),
            );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            getBestScoreWidget(),
            Text(
              "Score: ${widget.score}",
              style: TextStyle(fontSize: 32,shadows: [Shadow(color:Colors.black,blurRadius: 20,offset:Offset(0,0))]),
            ),
            Column(
              children: <Widget>[
                Text("SHARE",style:TextStyle(fontWeight: FontWeight.w700)),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                  Icon(Icons.mail,color:Colors.blue),
                  Icon(Icons.message,color:Colors.green),
                  Icon(Icons.video_library,color:Colors.red),
                ],)
                
              ],
            ),
            Column(
              children: <Widget>[
                ButtonOne(
                  onTap: (){
                    Navigator.pushReplacement(context, FadeRoute(page: GamePage(gametype: GAMETYPE.gameMath,)));
                  },
                  title: "TEKRAR OYNA",
                ),
                SizedBox(height:20),
                ButtonOne(
                  onTap: (){
                    Navigator.pushReplacement(context, FadeRoute(page: HomePage()));
                  },
                  title: "ANA MENU",
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
