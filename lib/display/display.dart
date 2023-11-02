// import 'dart:html';

import 'dart:io';

import 'package:codeutsav_1/display/waiting.dart';
import 'package:codeutsav_1/model/gloabal.dart';
import 'package:flutter/material.dart';
import 'package:codeutsav_1/model/appbar.dart';

class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  @override
  int _selectedIndex = 0;
  Widget build(BuildContext context) {
    global.imagePath = widget.imagePath;
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: CustomAppBar2(
        title: "Work Authenticator",
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Image.file(File(widget.imagePath)),
          ),
          // Text('wait for result'),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 250.0, // Set the width of the circular loading indicator
            height: 80.0, // Set the height of the circular loading indicator
            child: waiting(),
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'ReTake',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report_rounded),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Call',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            // Handle navigation to different tabs here
            // You can use a Navigator or show/hide different content based on the index.
          });
        },
      ),
      // body:Image.file(File(imagePath)),
    );
  }
}
