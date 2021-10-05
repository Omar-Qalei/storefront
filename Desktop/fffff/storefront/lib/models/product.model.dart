import 'dart:convert';

ProductModel ProductModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

class ProductModel {
  List<Product>? data;

  ProductModel({
    this.data,
  });

  factory ProductModel.fromJson(List<dynamic> json) {
    return ProductModel(
      data: List<Product>.from(json.map((x) => Product.fromJson(x))),
    );
  }
}

class Product {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  Rating? rating = Rating(rate: 3, count: 2);

  Product(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.category,
      this.image,
      required this.rating});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'].toDouble();
    description = json['description'];
    category = json['category'];
    image = json['image'];
    // rating =
    //     json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
  }
}

class Rating {
  late double rate;
  late int count;

  Rating({required this.rate, required this.count});

  Rating.fromJson(Map<String, dynamic> json) {
    rate = json['rate'];
    count = json['count'];
  }
}
