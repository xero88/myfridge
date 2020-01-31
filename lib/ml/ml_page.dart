import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MlPage extends StatefulWidget {
  @override
  _MlPageState createState() => _MlPageState();
}

class _MlPageState extends State<MlPage> {
  File _imageFile;
  TextRecognizer _textRecognizer;
  String _text;

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
    });

    await _initMl();
  }

  @override
  void dispose() {
    super.dispose();
    _textRecognizer.close();
  }

  Future _initMl() async {
    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(_imageFile);

    _textRecognizer = FirebaseVision.instance.textRecognizer();

    final VisionText visionText =
        await _textRecognizer.processImage(visionImage);

    final text = visionText.text;
    setState(() {
      _text = text;
    });
    for (TextBlock block in visionText.blocks) {
      final Rect boundingBox = block.boundingBox;
      final List<Offset> cornerPoints = block.cornerPoints;
      final String text = block.text;
      final List<RecognizedLanguage> languages = block.recognizedLanguages;


      for (TextLine line in block.lines) {
        // Same getters as TextBlock
        for (TextElement element in line.elements) {
          // Same getters as TextBlock
          print(element.text);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("titre"),
        ),
        body: Column(
          children: <Widget>[
            RaisedButton(
                onPressed: () => _pickImage(ImageSource.camera),
                child: const Text("pick image")),
            Column(children: <Widget>[
              if (_text != null) ...[Text(_text)]
            ]),
          ],
        ));
  }
}
