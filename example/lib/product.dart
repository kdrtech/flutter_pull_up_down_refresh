class Product {
  String? id;
  String? name;
  String? description;
  String? features;
  String? price;
  String? keywords;
  String? url;
  String? category;
  String? subcategory;

  Product(
      {this.id,
      this.name,
      this.description,
      this.features,
      this.price,
      this.keywords,
      this.url,
      this.category,
      this.subcategory});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    features = json['features'];
    price = json['price'];
    keywords = json['keywords'];
    url = json['url'];
    category = json['category'];
    subcategory = json['subcategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['features'] = this.features;
    data['price'] = this.price;
    data['keywords'] = this.keywords;
    data['url'] = this.url;
    data['category'] = this.category;
    data['subcategory'] = this.subcategory;
    return data;
  }
}
