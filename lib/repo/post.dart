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
  var uri = Uri.parse("http://172.22.129.175:5000/upload");

  // create multipart request
  var request = new http.MultipartRequest("POST", uri);

  // multipart that takes file
  var multipartFile = new http.MultipartFile('file', stream, length,
      filename: basename(imageFile.path));

  // add file to multipart
  request.files.add(multipartFile);

  // send
  var response = await request.send();
  print(response.statusCode);

  // listen for response
  response.stream.transform(utf8.decoder).listen((value) {
    print(value);
  });
}
Future<void> uploadFile(String imagePath) async {
  final Uri url = Uri.parse('http://172.22.129.175:5000/upload'); // Replace with your backend endpoint.
  final imageBytes = File(imagePath).readAsBytesSync();
  final mimeTypeData = lookupMimeType(imagePath);
  final multipartFile = http.MultipartFile.fromBytes(
    'file',
    imageBytes,
    contentType: MediaType.parse(mimeTypeData!),
  );

  final request = http.MultipartRequest('POST', url);
  request.fields['description'] = 'A description for the uploaded file';
  request.files.add(multipartFile);

  final streamedResponse = await request.send();
  final response = await http.Response.fromStream(streamedResponse);

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON data
    print('hehe');
    final data = json.decode(response.body);
    global.fl=true;
    global.text=data;
    return data;
  } else {
    // If the server did not return a 200 OK response, throw an exception
    global.fl=false;
    throw Exception('Failed to load data');
  }
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
