// import 'dart:html';

import 'dart:io';

import 'package:codeutsav_1/display/waiting.dart';
import 'package:codeutsav_1/model/gloabal.dart';
import 'package:flutter/material.dart';

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    global.imagePath=imagePath;
    return Scaffold(
      appBar: AppBar(title: Text('Captured Picture')),
      body:Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child:Image.file(File(imagePath)),
          ),
          Text('wait for result'),
          SizedBox(height: 30,),
          Container(
            width: 50.0, // Set the width of the circular loading indicator
            height: 50.0, // Set the height of the circular loading indicator
            child: waiting(),
          ),
          SizedBox(height: 30,),
        ],
      )
      // body:Image.file(File(imagePath)),
    );
  }
}
