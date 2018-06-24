import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, double> _startLocation;
  Map<String, double> _currentLocation;

  StreamSubscription<Map<String, double>> _locationSubscription;

  Location _location = new Location();
  double _lon;
  double _lat;
  var url;
  var request;
  var response;
  String value;
  String error;

  bool currentWidget = true;

  Image image1;

  @override
  void initState() {
    super.initState();

    initPlatformState();

    _locationSubscription =
        _location.onLocationChanged.listen((Map<String,double> result) {
          setState(() {
            _currentLocation = result;
            _lon = _currentLocation["longitude"];
            _lat = _currentLocation["latitude"];
          });
        });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    Map<String, double> location;
    // Platform messages may fail, so we use a try/catch PlatformException.

    try {
      location = await _location.getLocation;

      error = null;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error = 'Permission denied - please ask the user to enable it from the app settings';
      }

      location = null;
    }

    setState(() {
        _startLocation = location;
    });

  }

Future<http.Response> fetchPost(double _lat, double _lon) async {
  url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${_lat},${_lon}&location_type=ROOFTOP&result_type=street_address&key=AIzaSyA7C9zgb1ORXIoFwMW8eDw0TIHjsKnyQ2c";
  print(url);
  final response = await http.get(url);

  print(response.body);
  Map<String, dynamic> result = json.decode(response.body.toString());
  value = result['results'][0]['address_components'][2]['long_name'];
  return response;
}


  @override
  Widget build(BuildContext context) {
    List<Widget> widgets;

      widgets = new List();


    widgets.add(new Center(
        child: new Text(_startLocation != null
            ? 'Start location: $_startLocation\n'
            : 'Error: $error\n')));
final request1 = fetchPost(_lat, _lon);
    widgets.add(new Center(
        child: new Text(_currentLocation != null
            ? 'City: $value\n'
            : 'Error: $error\n')));
    
    return new MaterialApp(
        home: new Scaffold(
            appBar: new AppBar(
              title: new Text('Chris is gay'),
            ),
            body: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: widgets,
            )));
  }
}