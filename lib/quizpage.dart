import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/result.dart';

class getjson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString("assets/python.json"),
      builder: (context, snapshot) {
        List mydata = jsonDecode(snapshot.data.toString());
        if (mydata == null) {
          return Scaffold(
            backgroundColor: Colors.deepPurple,
            body: Center(
              child: Text("LOADING..."),
            ),
          );
        } else {
          return quizpage(mydata: mydata);
        }
      },
    );
  }
}

class quizpage extends StatefulWidget {
  var mydata;
  quizpage({Key key, @required this.mydata}) : super(key: key);
  @override
  _quizpageState createState() => _quizpageState(mydata);
}

class _quizpageState extends State<quizpage> {
  var mydata;
  int marks = 0;
  int i = 1;
  Map<String, Color> btncolor = {
    'a': Colors.indigoAccent,
    'b': Colors.indigoAccent,
    'c': Colors.indigoAccent,
    'd': Colors.indigoAccent
  };
  int timer = 30;
  String showt = '30';
  bool canceltimer = false;
  @override
  void initState() {
    starttimer();
    super.initState();
  }

  void starttimer() async {
    const seco = Duration(seconds: 1);
    Timer.periodic(seco, (Timer t) {
      setState(() {
        if (timer < 1) {
          t.cancel();
          nextquestion();
        } else if (canceltimer == true) {
          t.cancel();
        } else {
          timer = timer - 1;
        }
        showt = timer.toString();
      });
    });
  }

  Color colortoshow = Colors.indigoAccent;
  Color right = Colors.green;
  Color wrong = Colors.red;
  void nextquestion() {
    timer = 30;
    canceltimer = false;
    setState(() {
      if (i < 10) {
        i++;
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => resultpage(marks: marks)));
      }
      btncolor['a'] = Colors.indigoAccent;
      btncolor['b'] = Colors.indigoAccent;
      btncolor['c'] = Colors.indigoAccent;
      btncolor['d'] = Colors.indigoAccent;
    });
    starttimer();
  }

  void checkans(String k) {
    if (mydata[2][i.toString()] == mydata[1][i.toString()][k]) {
      marks += 5;
      colortoshow = right;
    } else {
      colortoshow = wrong;
    }
    setState(() {
      canceltimer = true;
      btncolor[k] = colortoshow;
    });
    Timer(Duration(seconds: 1), nextquestion);
  }

  _quizpageState(this.mydata);

  Widget choicebutton(String a) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: MaterialButton(
        onPressed: () => checkans(a),
        child: Text(
          mydata[1][i.toString()][a],
          style: TextStyle(color: Colors.white, fontSize: 16),
          maxLines: 1,
        ),
        color: btncolor[a],
        minWidth: 300.0,
        height: 45.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        splashColor: Colors.indigo[700],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.tealAccent,
          body: Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Game Mode",
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.red),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    showt,
                    style:
                        TextStyle(fontSize: 35.0, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    mydata[0][i.toString()],
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      choicebutton('a'),
                      choicebutton('b'),
                      choicebutton('c'),
                      choicebutton('d'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        onWillPop: () {
          return showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("QuizApp"),
                    content: Text("You can't go back"),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Ok"),
                      ),
                    ],
                  ));
        });
  }
}
