class Address{
  String name;
  String openAddress;

  Address({this.name, this.openAddress});

  Address.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    openAddress = json['openAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['openAddress'] = this.openAddress;
    return data;
  }
}

