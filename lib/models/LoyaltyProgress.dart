
class LoyaltyProgress {

  int gifts;
  int progress;
  List<Object> pushDates;

	LoyaltyProgress(this.gifts, this.progress, this.pushDates);

  LoyaltyProgress.fromJsonMap(Map<String, dynamic> map):
		gifts = map["gifts"],
		progress = map["progress"],
		pushDates = map["pushDates"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['gifts'] = gifts;
		data['progress'] = progress;
		data['pushDates'] = pushDates;
		return data;
	}
}
