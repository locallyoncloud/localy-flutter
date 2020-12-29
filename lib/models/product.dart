/// name : "asda"
/// price : 6.3
/// images : ["das","asdas"]
/// id : "asdas"
/// description : "adasd"
/// category : "coffee"
/// rating : 5
/// productOptions : [{"name":"size","optionType":"dropDown","options":[{"optionName":"küçük","optionValue":5},{"optionName":"orta","optionValue":7},{"optionName":"büyük","optionValue":10}]}]

class Product {
  String name;
  double price;
  List<String> images;
  String id;
  String description;
  String category;
  int rating;
  List<ProductOptions> productOptions;

  Product({
      this.name, 
      this.price, 
      this.images, 
      this.id, 
      this.description, 
      this.category, 
      this.rating, 
      this.productOptions});

  Product.fromJson(dynamic json) {
    name = json["name"];
    price = double.parse(json["price"].toString());
    images = json["images"] != null ? json["images"].cast<String>() : [];
    id = json["id"];
    description = json["description"];
    category = json["category"];
    rating = json["rating"];
    if (json["productOptions"] != null) {
      productOptions = [];
      json["productOptions"].forEach((v) {
        productOptions.add(ProductOptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["price"] = price;
    map["images"] = images;
    map["id"] = id;
    map["description"] = description;
    map["category"] = category;
    map["rating"] = rating;
    if (productOptions != null) {
      map["productOptions"] = productOptions.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// name : "size"
/// optionType : "dropDown"
/// options : [{"optionName":"küçük","optionValue":5},{"optionName":"orta","optionValue":7},{"optionName":"büyük","optionValue":10}]

class ProductOptions {
  String name;
  String optionType;
  List<Options> options;

  ProductOptions({
      this.name, 
      this.optionType, 
      this.options});

  ProductOptions.fromJson(dynamic json) {
    name = json["name"];
    optionType = json["optionType"];
    if (json["options"] != null) {
      options = [];
      json["options"].forEach((v) {
        options.add(Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["optionType"] = optionType;
    if (options != null) {
      map["options"] = options.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// optionName : "küçük"
/// optionValue : 5

class Options {
  String optionName;
  double optionValue;

  Options({
      this.optionName, 
      this.optionValue});

  Options.fromJson(dynamic json) {
    optionName = json["optionName"];
    optionValue = double.parse(json["optionValue"].toString());
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["optionName"] = optionName;
    map["optionValue"] = optionValue;
    return map;
  }

}