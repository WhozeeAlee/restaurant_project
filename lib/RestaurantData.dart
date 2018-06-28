import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:location_test/Restaurant.dart';

class RestaurantData extends StatefulWidget {
  @override
  _RestaurantDataState createState() => new _RestaurantDataState();

  
  Map<String, double> _startLocation;
  Map<String, double> _currentLocation;

  //StreamSubscription<Map<String, double>> _locationSubscription;

  Location _location = new Location();
  double _lon, _lat;
  var url, request, response;
  String value, error;
  var restaurants = new Set();

  bool currentWidget = true;

  Image image1;

fetchRestaurants(double _lat, double _lon) async {
  url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${_lat},${_lon}&radius=500&type=restaurant&key=AIzaSyA7C9zgb1ORXIoFwMW8eDw0TIHjsKnyQ2c";
  print(url);
  final response = await http.get(url);

  print(response.body);
  Map<String, dynamic> result = json.decode(response.body.toString());
  Restaurant r = new Restaurant.fromJson(result['results'][0]);
  result['results'].forEach((rest) => restaurants.add(new Restaurant.fromJson(rest)));
  value = result['results'][0]['name'];

  if (restaurants.isNotEmpty) {
    print("ALL RECOVERED RESTAURANTS");
    restaurants.forEach((restaurant) => print(restaurant.name));
  }

  return value;
}
}

class _RestaurantDataState extends State<RestaurantData> {
  noSuchMethod(Invocation i) => super.noSuchMethod(i);


  @override
  void initState() {
    super.initState();

    initPlatformState();
    
    // _locationSubscription =
    //     _location.onLocationChanged.listen((Map<String,double> result) {
    //       setState(() {
    //         _currentLocation = result;
    //         _lon = _currentLocation["longitude"];
    //         _lat = _currentLocation["latitude"];
    //       });
    //     });
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
        _lon = location['longitude'];
        _lat = location['latitude'];
    });

  }

// fetchCity(double _lat, double _lon) async {
//   url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${_lat},${_lon}&location_type=ROOFTOP&result_type=street_address&key=AIzaSyA7C9zgb1ORXIoFwMW8eDw0TIHjsKnyQ2c";
//   print(url);
//   final response = await http.get(url);

//   print(response.body);
//   Map<String, dynamic> result = json.decode(response.body.toString());
//   value = result['results'][0]['address_components'][2]['long_name'];
//   return value;
// }

}