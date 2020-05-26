import 'dart:math';

import 'package:flutter/material.dart';
import 'package:projectMath/components/rainbox_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScoreTablePage extends StatefulWidget {
  @override
  _ScoreTablePageState createState() => _ScoreTablePageState();
}

class _ScoreTablePageState extends State<ScoreTablePage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<int> _scoretableList;

  Future<void> generateScoreList() async {
    final SharedPreferences prefs = await _prefs;
    if (prefs.getStringList('scoretable') != null) {
      setState(() {
        _scoretableList =
            prefs.getStringList('scoretable').map(int.parse).toList();
        _scoretableList.sort();
      });
    } else {
      _scoretableList = new List<int>();
    }
  }

  @override
  void initState() {
    generateScoreList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.teal,
                  iconSize: 26.0,
                ),
                RainbowText(str: "SKOR TABLOSU"),
                SizedBox(width: 26),
              ],
            ),
            Divider(height: 20, color: Colors.black),
            Expanded(
                          child: ListView.builder(
                  padding: EdgeInsets.all(20),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  
                  
                  itemCount: _scoretableList != null
                      ? (_scoretableList.length > 20
                          ? 20
                          : _scoretableList.length)
                      : 0,
                  itemBuilder: (BuildContext ctx, int index) {
                    return Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("${index + 1}.",
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.pinkAccent)),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "${_scoretableList[_scoretableList.length - index - 1]}",
                                  style: TextStyle(
                                    fontSize: 46,
                                    color: Colors.pink,
                                    shadows: [
                                      Shadow(color: Colors.black, blurRadius: 2)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(height: 2, color: Colors.teal),
                      ],
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
