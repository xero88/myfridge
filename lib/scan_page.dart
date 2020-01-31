import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ScanPage extends StatefulWidget {
  ScanPage({Key key}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  File _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("titre"),
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          RaisedButton(
              child: Text("pick image"),
              onPressed: () => _pickImage(ImageSource.gallery)),
          Column(children: <Widget>[
            if (_imageFile != null) ...[Image.file(_imageFile)]
          ]),
        ],
      )),
    );
  }
}
