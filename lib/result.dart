import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/home.dart';

class resultpage extends StatefulWidget {
  int marks;
  resultpage({Key key, @required this.marks}) : super(key: key);
  @override
  _resultpageState createState() => _resultpageState(marks);
}

class _resultpageState extends State<resultpage> {
  int marks;
  List<String> images = [
    "images/success.png",
    "images/good.png",
    "images/bad.png",
  ];
  String msg, image;
  _resultpageState(this.marks);
  @override
  void initState() {
    if (marks < 20) {
      image = images[2];
      msg = "You should try hard\n" + "You scored $marks";
    } else if (marks < 35) {
      image = images[1];
      msg = "You can do better \n" + "You scored $marks";
    } else {
      image = images[0];
      msg = "You are best \n" + "You scored $marks";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Result"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 7,
            child: Material(
              child: Container(
                  child: Column(
                children: <Widget>[
                  Material(
                    child: Container(
                      width: 300,
                      height: 300,
                      child: ClipRect(
                        child: Image(
                          image: AssetImage(image),
                        ),
                      ),
                    ),
                  ),
                  Center(
                      child: Text(
                    msg,
                    style: TextStyle(fontSize: 20),
                  )),
                ],
              )),
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlineButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => homepage()));
                  },
                  child: Text(
                    "Continue..",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  borderSide:
                      BorderSide(width: 5.0, color: Colors.indigoAccent),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
