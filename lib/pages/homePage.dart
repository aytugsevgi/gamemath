import 'package:flutter/material.dart';
import 'package:projectMath/components/buttonOne.dart';
import 'package:projectMath/components/rainbox_text.dart';
import 'package:projectMath/model/questionController.dart';
import 'package:projectMath/pages/scoretablePage.dart';
import 'package:projectMath/transitions/fade_transition.dart';
import './gamePage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _titleAnimation;
  Animation _titleTextAnimation;
  bool change = true;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    _titleAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.0,
          0.5,
          curve: Curves.bounceOut,
        ),
      ),
    );
    _titleTextAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.2, 0.5, curve: Curves.bounceOut),
      ),
    );
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size SCREEN_SIZE = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // status bar color
        elevation: 0,
        brightness: Brightness.light, // status bar brightness
      ),
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    spreadRadius: 1,
                    color: Colors.grey[700],
                    offset: Offset(3, 3),
                  ),
                  BoxShadow(
                    blurRadius: 10,
                    spreadRadius: 1,
                    color: Colors.grey[200],
                    offset: Offset(-2, -2),
                  ),
                ],
              ),
              child: Container(
                width: _titleAnimation.value * SCREEN_SIZE.width * 0.8,
                height: _titleAnimation.value * SCREEN_SIZE.width * 0.8,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.grey[100],
                    Colors.grey[200],
                    Colors.grey[500],
                  ], begin: Alignment(1, 1), end: Alignment(-1, -1)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 15,
                      spreadRadius: 1,
                      color: Colors.grey[500],
                      offset: Offset(4, 4),
                    ),
                    BoxShadow(
                      blurRadius: 15,
                      spreadRadius: 1,
                      color: Colors.grey[200],
                      offset: Offset(-3, -3),
                    ),
                  ],
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(20),
                alignment: Alignment.center,
                child: RainbowText(
                  str: "MATEMATİK",
                  fontSize: 28.0 * _titleTextAnimation.value,
                  fontWeight: FontWeight.w900,
                ),

                /*Text(
                  "GAME MATH",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0*_titleTextAnimation.value,
                    shadows: [Shadow(color: Color(0xFFc8d6e5), blurRadius: 10)],
                  ),
                ),*/
              ),
            ),
            Column(
              children: <Widget>[
                ButtonOne(
                  title: "BAŞLA",
                  onTap: () => Navigator.pushReplacement(
                    context,
                    FadeRoute(
                      page: GamePage(
                        gametype: GAMETYPE.gameMath,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ButtonOne(
                  title: "SKOR TABLOSU",
                  onTap: () => Navigator.push(
                    context,
                    FadeRoute(
                      page: ScoreTablePage()
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
