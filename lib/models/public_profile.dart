/// uid : "1"
/// name : "Onur Disanlı"
/// email : "onurdisanli@gmail.com"
/// phone : "05323451286"
/// favorites : ["coffee"]
/// profile_picture : "..."

class PublicProfile {
  String _uid;
  String _name;
  String _email;
  String _phone;
  String _type;
  String _company_id;
  List<String> _favorites;
  String _profilePicture;

  String get uid => _uid;
  String get name => _name;
  String get email => _email;
  String get phone => _phone;
  String get type => _type;
  String get company_id => _company_id;
  List<String> get favorites => _favorites;
  String get profilePicture => _profilePicture;

  PublicProfile({
      String uid, 
      String name, 
      String email, 
      String phone,
      String type,
      String company_id,
      List<String> favorites, 
      String profilePicture}){
    _uid = uid;
    _name = name;
    _email = email;
    _phone = phone;
    _type = type;
    _company_id = company_id;
    _favorites = favorites;
    _profilePicture = profilePicture;
}

  PublicProfile.fromJson(dynamic json) {
    _uid = json["uid"];
    _name = json["name"];
    _email = json["email"];
    _phone = json["phone"];
    _type = json["type"];
    _company_id = json["company_id"];
    _favorites = json["favorites"] != null ? json["favorites"].cast<String>() : [];
    _profilePicture = json["profilePicture"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["uid"] = _uid;
    map["name"] = _name;
    map["email"] = _email;
    map["phone"] = _phone;
    map["type"] = _type;
    map["company_id"] = _company_id;
    map["favorites"] = _favorites;
    map["profilePicture"] = _profilePicture;
    return map;
  }


}