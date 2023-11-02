import 'dart:async';
import 'dart:io';

import 'package:codeutsav_1/model/gloabal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:codeutsav_1/repo/post.dart';
class waiting extends StatefulWidget {
  // String imagePath;
  // waiting(this.imagePath);

  @override
  State<waiting> createState() => _waitingState();
}

class _waitingState extends State<waiting> {
  @override
  int tim=0;
  String text="";
  late Timer _timer;
  void initState() {
    super.initState();

  }
  void dispose() {
    _timer.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }
  Future<void> _simulateNetworkRequest() async {
    await Future.delayed(Duration(seconds: 5)); // Simulate a network request
  }
  Widget build(BuildContext context) {
    upload(File(global.imagePath));
    print(global.fl);
    print("baigan");
    return SingleChildScrollView(
      child: Column(
        children: [FutureBuilder<void>(
          future: _simulateNetworkRequest(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While waiting, display a loading indicator
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // Handle error case
              return Text('Error: ${snapshot.error}');
            } else {
              // When the operation is complete, display your content
              return Text(global.text,style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),);
            }
          },
        ),],
      ),
    );
  }
}

