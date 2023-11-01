import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import '../model/position.dart';
class GeoLocator extends StatelessWidget {

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
    print(position.latitude);
    print(position.latitude);
  }
  Future<void> getPosition() async{
    // print('called1');
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position position= await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    posi.position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    posi.latitude=position.latitude;
    posi.longitude=position.longitude;
    // print(position.latitude);
    // print(position.longitude);
    // Map<String,dynamic> data;
    // MyWidget().getData(position.latitude,position.longitude);
    // String? s=fun(data,posi().latitude,posi().longitude);
    // double lat=data?['geometry']['coordinates'][0];
    // double long=data?['geometry']['coordinates'][1];
    // Future<void> requestPermission() async {
    //   await Permission.location.request();
    // }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}