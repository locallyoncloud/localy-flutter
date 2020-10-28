class LoyaltyCard {
  String uid;
  String backgroundColor;
  String textColor;
  String iconColor;
  String backgroundImage;
  String company_id;
  bool isActive;
  String logo;
  String miniLogo;
  String sector;
  int target;
  int type;

  LoyaltyCard(
      {this.uid,
      this.backgroundColor,
      this.textColor,
      this.backgroundImage,
      this.company_id,
      this.isActive,
      this.logo,
      this.miniLogo,
      this.sector,
      this.target,
      this.type});

  LoyaltyCard.fromJsonMap(Map<String, dynamic> map)
      : uid = map["uid"],
        backgroundColor = map["backgroundColor"],
        iconColor = map["iconColor"],
				textColor = map["textColor"],
        backgroundImage = map["backgroundImage"],
        company_id = map["company_id"],
        isActive = map["isActive"],
        logo = map["logo"],
        miniLogo = map["miniLogo"],
        sector = map["sector"],
        target = map["target"],
        type = map["type"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = uid;
    data['backgroundColor'] = backgroundColor;
    data['iconColor'] = iconColor;
		data['textColor'] = textColor;
    data['backgroundImage'] = backgroundImage;
    data['company_id'] = company_id;
    data['isActive'] = isActive;
    data['logo'] = logo;
    data['miniLogo'] = miniLogo;
    data['sector'] = sector;
    data['target'] = target;
    data['type'] = type;
    return data;
  }
}
