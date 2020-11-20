import 'package:locally_flutter_app/models/location.dart';

class Company {
  String address;
  String category;
  String company_id;
  String logo;
  String mini_logo;
  String name;
  String slogan;
  String orderType;
  String groupName;
  int maxOrderDistance;
  Location location;
  List<String> notificationIds;
  int rating;

  Company.fromJsonMap(Map<String, dynamic> map)
      : address = map["address"],
        category = map["category"],
        company_id = map["company_id"],
        logo = map["logo"],
        mini_logo = map["mini_logo"],
        name = map["name"],
        slogan = map["slogan"],
				maxOrderDistance = map["maxOrderDistance"],
        rating = map["rating"],
				location = map['location'] != null
						? new Location.fromJson(map['location'])
						: null,
        orderType = map["orderType"],
        groupName = map["groupName"],
        notificationIds = List<String>.from(map["notificationIds"]);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = address;
    data['category'] = category;
    data['company_id'] = company_id;
    data['logo'] = logo;
    data['mini_logo'] = mini_logo;
    data['name'] = name;
    data['slogan'] = slogan;
    data['rating'] = rating;
		data['location'] = this.location.toJson();
    data['notificationIds'] = notificationIds;
		data['groupName'] = groupName;
		data['maxOrderDistance'] = maxOrderDistance;
    data['orderType'] = orderType;
    return data;
  }
}
