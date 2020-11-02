
class LoyaltyProgress {

  int gifts;
  double progress;
  List<String> pushDates;
  String mail;

	LoyaltyProgress(this.gifts, this.progress, this.pushDates, this.mail);

  LoyaltyProgress.fromJsonMap(Map<String, dynamic> map):
		gifts = map["gifts"],
		mail = map["mail"],
		progress = double.parse(map["progress"].toString()),
		pushDates = List<String>.from(map["pushDates"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['gifts'] = gifts;
		data['progress'] = progress;
		data['pushDates'] = pushDates;
		data['mail'] = mail;
		return data;
	}

}
