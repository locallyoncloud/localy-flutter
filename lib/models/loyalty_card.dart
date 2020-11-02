class LoyaltyCard {
  String uid;
  String backgroundColor;
  String textColor;
  String iconColor;
  String backgroundImage;
  String company_id;
  IconDataInfo iconData;
  bool isActive;
  String logo;
  String miniLogo;
  String sector;
  int target;
  int type;
  double iconSize;
  double imageOpacity;
  double percentage;

  LoyaltyCard(
      {this.uid,
      this.backgroundColor,
      this.textColor,
      this.iconColor,
      this.backgroundImage,
      this.company_id,
      this.iconData,
      this.isActive,
      this.logo,
      this.miniLogo,
      this.sector,
      this.target,
      this.type,
      this.iconSize,
      this.imageOpacity,
      this.percentage
      });

  LoyaltyCard.fromJsonMap(Map<String, dynamic> map)
      : uid = map["uid"],
        backgroundColor = map["backgroundColor"],
        iconColor = map["iconColor"],
        textColor = map["textColor"],
        backgroundImage = map["backgroundImage"],
        iconData = IconDataInfo.fromJsonMap(map["iconData"]),
        company_id = map["company_id"],
        isActive = map["isActive"],
        logo = map["logo"],
        miniLogo = map["miniLogo"],
        sector = map["sector"],
        target = map["target"],
        type = map["type"],
        iconSize = map["iconSize"],
        percentage = double.parse(map["percentage"].toString()),
        imageOpacity = map["imageOpacity"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = uid;
    data['backgroundColor'] = backgroundColor;
    data['iconColor'] = iconColor;
    data['textColor'] = textColor;
    data['backgroundImage'] = backgroundImage;
    data['iconData'] = iconData == null ? null : iconData.toJson();
    data['company_id'] = company_id;
    data['isActive'] = isActive;
    data['logo'] = logo;
    data['miniLogo'] = miniLogo;
    data['sector'] = sector;
    data['target'] = target;
    data['type'] = type;
    data['iconSize'] = iconSize;
    data['percentage'] = percentage;
    data['imageOpacity'] = imageOpacity;
    return data;
  }
}

class IconDataInfo {
  String fontFamily;
  int codePoint;

  IconDataInfo({this.fontFamily, this.codePoint});

  IconDataInfo.fromJsonMap(Map<String, dynamic> map)
      : fontFamily = map["fontFamily"],
        codePoint = map["codePoint"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fontFamily'] = fontFamily;
    data['codePoint'] = codePoint;
    return data;
  }
}
