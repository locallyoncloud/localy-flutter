
class Address {

  String city;
  String street;
  String zip;
  List<String> flags;

	Address.fromJsonMap(Map<String, dynamic> map): 
		city = map["city"],
		street = map["street"],
		zip = map["zip"],
		flags = List<String>.from(map["flags"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['city'] = city;
		data['street'] = street;
		data['zip'] = zip;
		data['flags'] = flags;
		return data;
	}
}
