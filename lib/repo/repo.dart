import 'dart:convert';
import 'dart:math';
import 'package:codeutsav_1/model/gloabal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:resume/tools/mindist.dart';
import 'package:geolocator/geolocator.dart';
Future fetchData() async {
  final response = await http.get(Uri.parse('https://vigyan-backend.onrender.com/'));

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON data
    final data = json.decode(response.body);
    return data;
  } else {
    // If the server did not return a 200 OK response, throw an exception
    throw Exception('Failed to load data');
  }
}
double calculateDistance(lat1, lon1, lat2, lon2){
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 - c((lat2 - lat1) * p)/2 +
      c(lat1 * p) * c(lat2 * p) *
          (1 - c((lon2 - lon1) * p))/2;
  return 12742 * asin(sqrt(a));
}

String? fun(List<dynamic> data,double? lat1,double? long1){
  double min=1e9;
  int ind=-1;
  for(int i=0;i<data.length;i++){
    double lat=37,long=140;
    if(data?[i]['geometry']['coordinates'][1] is double){
      // lat=double.tryParse(data?[i]['geometry']['coordinates'][1])??37;
      // long=double.tryParse(data?[i]['geometry']['coordinates'][0])??140;
      lat=data?[i]['geometry']['coordinates'][1];
      long=data?[i]['geometry']['coordinates'][0];
    }

    if(Geolocator.distanceBetween(lat1!,long1!,lat,long,)<min){
      min=Geolocator.distanceBetween(lat1,long1,lat,long);
      // min-=Geolocator.distanceBetween(lat,long,lat1,long1);
      ind=i;
    }
  }
  global.dis=min;
  if(ind==-1) return "Nahi";
  else{
    // print(lat);
    // print(long);
    global.obs=data?[ind]['properties']['type'];
    if(min<100){
      global.text=global.obs??"Unknown";
    }
    else{
      global.text='Safe';
    }
    return data?[ind]['properties']['type'];

  }
}
class MyWidget {
  Future<void> getData(double lat,double lon)async {
    fetchData().then((result) {
      List<dynamic> data;
        data = result['features'];
        String? s=fun(data,lat,lon);
        print(s);
        print('suc');
      });
    }
  }




