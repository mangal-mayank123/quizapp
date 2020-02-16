import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:quizapp/download.dart';

class imagepage extends StatefulWidget {
  var url;
  imagepage({Key key, @required this.url}) : super(key: key);

  @override
  _imagepageState createState() => _imagepageState(url);
}

class _imagepageState extends State<imagepage> {
  ProgressDialog progressDialog;
  String url;
  _imagepageState(this.url);

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Image.network(url),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () async {
                progressDialog.show();
                var fileName, path, size, mimeType;
                try {
                  // Saved with this method.
                  var imageId = await ImageDownloader.downloadImage(url);
                  if (imageId == null) {
                    return;
                  } else {
                    progressDialog.hide();
                    Navigator.pop(context, true);
                  }
                  // Below is a method of obtaining saved image information.
                  fileName = await ImageDownloader.findName(imageId);
                  path = await ImageDownloader.findPath(imageId);
                  size = await ImageDownloader.findByteSize(imageId);
                  mimeType = await ImageDownloader.findMimeType(imageId);
                } on PlatformException catch (error) {
                  print(error);
                }
                print(path);
              },
              child: Text('Download', style: TextStyle(fontSize: 17)),
              color: Colors.green,
              textColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            ),
          ],
        ),
      ),
    );
  }
}
