import 'package:flutter/material.dart';
import 'package:projectMath/components/rainbox_text.dart';

class ButtonOne extends StatelessWidget {
  String title;
  Function onTap;
  ButtonOne({this.title="Button",this.onTap});

  @override
  Widget build(BuildContext context) {
    final Size SCREEN_SIZE = MediaQuery.of(context).size;
    return Container(
      width: SCREEN_SIZE.width*0.9,
      child: RaisedButton(
                    elevation: 6,
                    color: Colors.grey[200],
                    onPressed: this.onTap,
                    child: RainbowText(str: title,fontSize: 16,fontWeight: FontWeight.w600,)
                
                  ),
    );
  }
}
