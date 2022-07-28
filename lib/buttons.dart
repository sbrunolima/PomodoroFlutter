import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  var pressed;
  final String title;

  Buttons(this.pressed, this.title);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: pressed,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.deepOrangeAccent[200],
            fontSize: 26,
            fontFamily: 'Obveron',
          ),
        ),
      ),
    );
  }
}
