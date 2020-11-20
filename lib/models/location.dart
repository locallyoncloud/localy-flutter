class Location {
  String lat;
  String long;
  String name;

  Location({this.lat, this.long, this.name});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    long = json['long'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['name'] = this.name;
    return data;
  }
}