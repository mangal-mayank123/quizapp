import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:quizapp/home.dart';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  ProgressDialog progressDialog;
  File smp;
  String image_path;
  Future getimage() async {
    await ImagePicker.pickImage(source: ImageSource.gallery)
        .then((value) => setState(() {
              image_path = value.path.split('/').last;
              smp = value;
            }));
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload'),
        centerTitle: true,
      ),
      body: Center(
        child: smp == null ? Text('select a image') : enableupload(),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: getimage,
        tooltip: 'add Image',
        child: new Icon(Icons.add),
      ),
    );
  }

  Widget enableupload() {
    return Container(
      child: Column(
        children: <Widget>[
          Image.file(
            smp,
            height: 300,
            width: 300,
          ),
          RaisedButton(
            elevation: 7.0,
            child: Text("Upload"),
            textColor: Colors.white,
            color: Colors.blue,
            onPressed: () {
              progressDialog.show();
              insert();
            },
          ),
        ],
      ),
    );
  }

  void insert() async {
    StorageReference ref =
        FirebaseStorage.instance.ref().child("images/" + image_path);
    StorageUploadTask uploadTask = ref.putFile(smp);
    await uploadTask.onComplete;
    progressDialog.hide();
    var dowurl = await ref.getDownloadURL();
    String url = dowurl.toString();
    Firestore.instance.collection('images').add({'url': url});
  }
}
