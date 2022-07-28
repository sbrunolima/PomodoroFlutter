import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PercentageIndicator extends StatefulWidget {
  double percentage;
  final bool rest;
  final String centerName;
  int timer;

  PercentageIndicator(this.percentage, this.rest, this.centerName, this.timer);

  @override
  _PercentageIndicatorState createState() => _PercentageIndicatorState();
}

class _PercentageIndicatorState extends State<PercentageIndicator> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CircularPercentIndicator(
        circularStrokeCap: CircularStrokeCap.square,
        percent: widget.percentage,
        animation: true,
        animateFromLastPercent: true,
        radius: 120,
        lineWidth: 5,
        progressColor: widget.rest
            ? Colors.blue[400]
            : widget.percentage >= 0.9
                ? Colors.red[400]
                : Colors.amber[300],
        center: Text(
          widget.rest
              ? '0' + widget.centerName
              : widget.timer < 10
                  ? '0' + widget.centerName
                  : widget.centerName,
          style: TextStyle(
            color: Colors.white38,
            fontSize: 120,
            fontWeight: FontWeight.bold,
            fontFamily: 'GlitchInside',
          ),
        ),
      ),
    );
  }
}
