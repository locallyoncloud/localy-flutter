class AppConfig {

  String registerBackgroundURL;

	AppConfig.fromJsonMap(Map<String, dynamic> map):
		registerBackgroundURL = map["registerBackgroundURL"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['registerBackgroundURL'] = registerBackgroundURL;
		return data;
	}
}
