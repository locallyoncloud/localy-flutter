
class LoyaltyCard {
  String uid;
  String backgroundColor;
  String backgroundImage;
  String company_id;
  bool isActive;
  String logo;
  String sector;
  int target;
  int type;

	LoyaltyCard.fromJsonMap(Map<String, dynamic> map):
		uid = map["uid"],
		backgroundColor = map["backgroundColor"],
		backgroundImage = map["backgroundImage"],
		company_id = map["company_id"],
		isActive = map["isActive"],
		logo = map["logo"],
		sector = map["sector"],
		target = map["target"],
		type = map["type"];


  Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['uid'] = uid;
		data['backgroundColor'] = backgroundColor;
		data['backgroundImage'] = backgroundImage;
		data['company_id'] = company_id;
		data['isActive'] = isActive;
		data['logo'] = logo;
		data['sector'] = sector;
		data['target'] = target;
		data['type'] = type;
		return data;
	}
}
