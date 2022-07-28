import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import './percentage_indicator.dart';
import './buttons.dart';

void main() => runApp(Pomodoro());

class Pomodoro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Pomodoro",
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: PomodoroHome(),
    );
  }
}

class PomodoroHome extends StatefulWidget {
  @override
  _PomodoroHomeState createState() => _PomodoroHomeState();
}

class _PomodoroHomeState extends State<PomodoroHome> {
  double percentage = 0;
  int inMinutes = 0;
  double inSeconds = 0;
  late Timer timer;
  bool rest = false;

  _start() {
    rest = false;
    percentage = 0;
    inMinutes = 25;
    int time = inMinutes * 60;
    double secondsPercentage = (time / 100);
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (time > 0) {
          time--;
          if (time % 60 == 0) {
            inMinutes--;
          }
          if (time % secondsPercentage == 0) {
            if (percentage < 1) {
              percentage += 0.01;
            } else {
              percentage = 1;
            }
          }
        }
        if (time <= 0) {
          percentage = 1;
          inSeconds = 0;
          inMinutes = 0;
          timer.cancel();
        }
      });
    });
  }

  _rest() {
    rest = true;
    percentage = 0;
    inMinutes = 5;
    int time = inMinutes * 60;
    double secondsPercentage = (time / 100);
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (time > 0) {
          time--;
          if (time % 60 == 0) {
            inMinutes--;
          }
          if (time % secondsPercentage == 0) {
            if (percentage < 1) {
              percentage += 0.01;
            } else {
              percentage = 1;
            }
          }
        }
        if (time <= 0) {
          percentage = 1;
          inSeconds = 0;
          inMinutes = 0;
          timer.cancel();
        }
      });
    });
  }

  _stop() {
    rest = false;
    percentage = 0;
    inSeconds = 0;
    inMinutes = 0;
    setState(() {
      timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 34, 34, 34),
                Color.fromARGB(255, 34, 31, 31),
              ],
              begin: FractionalOffset(0.5, 1),
            ),
          ),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 25),
                child: Text(
                  'Pomodoro Timer',
                  style: TextStyle(
                    color: Colors.deepOrangeAccent[200],
                    fontSize: 50,
                    fontFamily: 'Obveron',
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              PercentageIndicator(percentage, rest, '$inMinutes', inMinutes),
              SizedBox(height: 10),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                    child: Column(
                      children: [
                        Text(
                          'Focus on your studies, avoid distractions!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Buttons(_start, 'Start'),
                              Buttons(_stop, 'Stop '),
                            ],
                          ),
                        ),
                        restButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget restButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: double.infinity,
        child: RaisedButton(
          onPressed: _rest,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Rest Time',
              style: TextStyle(
                color: Colors.green,
                fontSize: 26,
                fontFamily: 'Obveron',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
