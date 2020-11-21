import 'package:locally_flutter_app/models/address.dart';

/// uid : "1"
/// name : "Onur Disanlı"
/// email : "onurdisanli@gmail.com"
/// phone : "05323451286"
/// favorites : ["coffee"]
/// profile_picture : "..."

class PublicProfile {
  String uid;
  String name;
  String email;
  String phone;
  String type;
  String company_id;
  List<Address> address;
  List<String> notificationIds;
  List<String> favorites;
  String profilePicture;

  PublicProfile(
      {this.uid,
      this.name,
      this.email,
      this.phone,
      this.type,
      this.company_id,
      this.notificationIds,
      this.favorites,
      this.address,
      this.profilePicture});

  PublicProfile.fromJson(dynamic json) {
    uid = json["uid"];
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    type = json["type"];
    company_id = json["company_id"];
    if (json["address"] != null) {
      address = [];
      json["address"].forEach((v) {
        address.add(Address.fromJson(v));
      });
    }
    notificationIds = json["notificationIds"] != null
        ? json["notificationIds"].cast<String>()
        : [];
    favorites =
        json["favorites"] != null ? json["favorites"].cast<String>() : [];
    profilePicture = json["profilePicture"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["uid"] = uid;
    map["name"] = name;
    map["email"] = email;
    map["phone"] = phone;
    map["type"] = type;
    map["company_id"] = company_id;
    map["notificationIds"] = notificationIds;
    map["favorites"] = favorites;
    map["profilePicture"] = profilePicture;
    map["address"] = address.map((v) => v.toJson()).toList();
    return map;
  }
}
