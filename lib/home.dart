import 'dart:io';
import 'package:quizapp/upload.dart';
import 'package:quizapp/download.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/quizpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: Text('Game Mode'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 100, horizontal: 60),
        child: Container(
          child: Column(children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => getjson()));
              },
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  height: 200,
                  width: 200,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: ClipOval(
                          child: Image(
                            image: AssetImage("images/py.png"),
                          ),
                        ),
                      ),
                      Center(
                        child: Text("Enter Quiz",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            ),
            RaisedButton(
                child: Text('Upload Images', style: TextStyle(fontSize: 17)),
                color: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Upload()));
                }),
            RaisedButton(
                child: Text('Download Images', style: TextStyle(fontSize: 17)),
                color: Colors.red,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => download()));
                }),
          ]),
        ),
      ),
    );
  }
}
