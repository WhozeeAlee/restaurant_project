class Restaurant {
  final String name;

  Restaurant(this.name);

  Restaurant.fromJson(Map<String, dynamic> json) {
    Restaurant(json['name']);
  }
}