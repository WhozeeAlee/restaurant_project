class Restaurant {
  double lat, lon, rating;
  String address, id, icon, name, maps_photo_link;
  bool open_now;
  int price_level;

  Restaurant.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.lat =  json['geometry']['location']['lat'];
    this.lon = json['lon'];


  }
}