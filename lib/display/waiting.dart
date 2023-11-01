import 'package:codeutsav_1/model/gloabal.dart';
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
  bool fl=true;
  void initState() {
    super.initState();
    uploadFile(global.imagePath??'assets/safe.jpg');
    setState(() {
      fl=global.fl;
    });
  }
  Widget build(BuildContext context) {
    if(fl) return CircularProgressIndicator(
      strokeWidth: 4.0, // Set the thickness of the circle
      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // Set the color
    );
    else return Text(global.text);
  }
}


class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(); // This creates a round loading animation.
  }
}
