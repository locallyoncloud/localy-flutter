
class Product {

  String category;
  String description;
  String id;
  List<String> images;
  String name;
  List<double> price;
  int rating;
  List<String> size;


	Product(this.category, this.description, this.id, this.images, this.name,
      this.price, this.rating, this.size);

  Product.fromJsonMap(Map<String, dynamic> map):
		category = map["category"],
		description = map["description"],
		id = map["id"],
		images = List<String>.from(map["images"]),
		name = map["name"],
		price =  map["price"] != null ? map["price"].map((e)=>double.parse(e.toString())).toList().cast<double>() : [],
		rating = map["rating"],
		size = List<String>.from(map["size"]);

	/*Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['category'] = category;
		data['description'] = description;
		data['id'] = id;
		data['images'] = images;
		data['name'] = name;
		data['price'] = price;
		data['rating'] = rating;
		data['size'] = size;
		return data;
	}*/
}
