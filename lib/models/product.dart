import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  Product({
    this.id,
    this.name,
    this.category,
    this.brand,
    this.model,
    this.price,
    this.colour,
    this.weight,
    this.image,
    this.bgColor,
  });

  String? id;
  String? name;
  String? category;
  String? brand;
  String? model;
  double? price;
  String? colour;
  Color? bgColor;
  String? weight;
  String? image;

  Product copyWith({
    String? id,
    String? name,
    String? category,
    String? brand,
    String? model,
    double? price,
    String? colour,
    Color? bgColor,
    String? weight,
    String? image,
  }) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        category: category ?? this.category,
        brand: brand ?? this.brand,
        model: model ?? this.model,
        price: price ?? this.price,
        colour: colour ?? this.colour,
        bgColor: bgColor ?? this.bgColor,
        weight: weight ?? this.weight,
        image: image ?? this.image,
      );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"].toString(),
        name: json["name"],
        category: json["category"],
        brand: json["brand"],
        model: json["model"],
        price: double.tryParse('${json["price"]}'),
        colour: json["colour"],
        weight: json["weight"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
        "brand": brand,
        "model": model,
        "price": price.toString(),
        "colour": colour,
        "weight": weight,
        "image": image,
      };
}
