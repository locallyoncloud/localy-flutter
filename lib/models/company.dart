
class Company {

  String address;
  String category;
  String company_id;
  String logo;
  String mini_logo;
  String name;
  String slogan;
  List<String> notificationIds;
  int rating;

	Company.fromJsonMap(Map<String, dynamic> map):
		address = map["address"],
		category = map["category"],
		company_id = map["company_id"],
		logo = map["logo"],
		mini_logo = map["mini_logo"],
		name = map["name"],
		slogan = map["slogan"],
		rating = map["rating"],
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
		data['notificationIds'] = notificationIds;
		return data;
	}
}
