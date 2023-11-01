import 'package:codeutsav_1/home.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'display/display.dart';
import 'repo/post.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      home: Home(),
    ),
  );
}
