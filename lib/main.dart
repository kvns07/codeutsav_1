import 'dart:async';
import 'dart:io';

import 'package:codeutsav_1/model/gloabal.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'display/display.dart';
import 'repo/post.dart';
import 'model/appbar.dart';
import 'package:geolocator/geolocator.dart';
import 'model/position.dart';
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TakePictureScreen(
        camera: firstCamera,
      ),
    ),
  );

}

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({
    Key? key,
    required this.camera,
  }) : super(key: key);

  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  int _selectedIndex = 0;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  Future<void> getPermission() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
  }
  Future<void> getPosi() async{
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position position= await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    posi.position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    global.lon=posi.position?.longitude;
    global.lat=posi.position?.latitude;
  }
  late Timer _timer;
  int tim=0;
  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
    getPermission();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      tim=tim+1;
      tim%=5;
      setState(() {
        getPosi();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    global.fl=false;
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: CustomAppBar(
        title: 'Pothole Tracker',
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 30,),
            FloatingActionButton(
              backgroundColor: Colors.lightGreenAccent,
              onPressed: () async {
                try {
                  await _initializeControllerFuture;
                  final image = await _controller.takePicture();
                  global.imagePath=image.path;
                  // upload(File(image.path));
                  // Navigate to a new screen to display the captured image

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DisplayPictureScreen(imagePath: image.path),
                    ),
                  );
                } catch (e) {
                  print("Error taking picture: $e");
                }
              },
              child: Icon(Icons.camera_outlined),
              mini: false,
            ),
          ],
        ),
        SizedBox(height: 10,)],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Take Picture',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo),
            label: 'Gallery',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
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
    );
  }

}