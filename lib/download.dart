import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'ImageDart.dart';

class download extends StatefulWidget {
  @override
  _downloadState createState() => _downloadState();
}

class _downloadState extends State<download> {
  ProgressDialog progressDialog;
  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    return Scaffold(
      appBar: AppBar(
        title: Text("Images"),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey,
      body: ListView(
        children: <Widget>[
          SizedBox(height: 20.0),
          StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('images').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: snapshot.data.documents.map((doc) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      imagepage(url: doc['url'])));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 3),
                          child: SizedBox(
                            width: double.infinity,
                            child: Image.network(
                              doc['url'],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                } else {
                  return Text(
                    "\n",
                    style: TextStyle(fontSize: 17),
                  );
                }
              }),
        ],
      ),
    );
  }
}
