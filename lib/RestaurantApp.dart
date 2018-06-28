import 'package:flutter/material.dart';
import 'package:location_test/RestaurantData.dart';

class RestaurantApp extends StatefulWidget {
  @override
  _RestaurantAppState createState() => new _RestaurantAppState();
}
  var r = new RestaurantData();
class _RestaurantAppState extends State<RestaurantApp> {
  noSuchMethod(Invocation i) => super.noSuchMethod(i);
  @override
  void initState() {
    super.initState();
  }

 }


  @override
  Widget build(BuildContext context) {
    List<Widget> widgets;

    widgets = new List();
    r.fetchRestaurants(r._lat, r._lon);

    widgets.add(new Center(
        child: new Text(_startLocation != null
            ? 'Start location: $_startLocation\n'
            : 'Error: $error\n')));
    widgets.add(new Center(
        child: new Text(_currentLocation != null
            ? 'City: $value\n'
            : 'Error: $error\n')));
    
    

    return new MaterialApp(
        home: new Scaffold(
            appBar: new AppBar(
              title: new Text('lmao'),
            ),
                  drawer: new Drawer(
        child: new ListView(
          children: <Widget> [
            new DrawerHeader(child: new Text('Header'),),
            new ListTile(
              title: new Text('First Menu Item'),
              onTap: () {},
            ),
            new ListTile(
              title: new Text('Second Menu Item'),
              onTap: () {},
            ),
            new Divider(),
            new ListTile(
              title: new Text('About'),
              onTap: () {},
            ),
          ],
        )
      ),
      //@source https://stackoverflow.com/questions/43720930/flutter-side-menu
            body: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: widgets,
            )));
  }
}
