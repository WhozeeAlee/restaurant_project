class Restaurant {
  final double lat, lon, rating;
  final String address, id, icon, name, maps_photo_link;
  final bool open_now;
  final int price_level;

  Restaurant({this.lat, this.lon, this.rating, this.address, this.id, 
  this.icon, this.name, this.maps_photo_link, this.open_now, this.price_level});

  Restaurant (Map<String, dynamic> json) {
    Restaurant(
      lat: json['lat'],
      lon: json['lon'],
      rating: json['rating'],
      address: json['address'],
      id: json['id'],
      icon: json['icon'],
      name: json['name'],
      maps_photo_link: json['maps_photo_link'],
      open_now: json['open_now'],
      price_level: json['price_level'],

    );
  }
}