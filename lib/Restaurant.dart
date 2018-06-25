class Restaurant {
  String name;

  Restaurant(this.name);

  Restaurant.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
  }
}