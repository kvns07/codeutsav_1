import 'dart:convert';
import 'dart:io';
import 'package:codeutsav_1/model/gloabal.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
Future<void> upload(File imageFile) async {
  // open a bytestream
  var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
  // get file length
  var length = await imageFile.length();

  // string to uri
  var uri = Uri.parse("http://172.22.128.246:5000/upload");

  // create multipart request
  var request = new http.MultipartRequest("POST", uri);

  // multipart that takes file
  var multipartFile = new http.MultipartFile('file', stream, length,
      filename: basename(imageFile.path));

  // add file to multipart
  request.fields['lat'] = '${global.lat}';
  request.fields['lon'] = '${global.lon}';
  request.files.add(multipartFile);

  // send
  var response = await request.send();
  print(response.statusCode);

  // listen for response
  response.stream.transform(utf8.decoder).listen((value) {
    Map<String, dynamic> jsonMap = json.decode(value);
    String fl=jsonMap['pothole'];
    if(fl=='true') global.fl=true;
    else global.fl=false;
    print(fl);
    print(value);
  });
}
// Future<void> sendImage() async{
//   final uri = Uri.parse('https://myendpoint.com');
//   var request = new http.MultipartRequest('POST', uri);
//   final httpImage = http.MultipartFile.fromBytes('files.myimage', bytes,
//       contentType: MediaType.parse(mimeType), filename: 'myImage.png');
//   request.files.add(httpImage);
//   final response = await request.send();
// }
Future<void> sendDataToServer2(double lat,double lon) async {
  var url = "https://vigyan-backend.onrender.com/accident/"; // Replace with your server's API URL
  final data = {'latitude':'lat','longitude':'lon','type':'type'}; // Replace with your data
  final response = await http.post(
    Uri.parse(url),
    body: jsonEncode(
        {'latitude':lon,'longitude':lat}
    ),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    print('Data sent successfully');
  } else {
    print('Failed to send data. Status code: ${response.statusCode}');
  }
}
Future<void> sendDataToServer(double lat,double lon,String type) async {
  var url = "https://vigyan-backend.onrender.com/"; // Replace with your server's API URL
  final data = {'latitude':'lat','longitude':'lon','type':'type'}; // Replace with your data

  final response = await http.post(
    Uri.parse(url),
    body: jsonEncode(
        {'latitude':lon,'longitude':lat,'type':'Pothole'}
    ),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    print('Data sent successfully');
  } else {
    print('Failed to send data. Status code: ${response.statusCode}');
  }
}
