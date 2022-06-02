import 'package:flutter/material.dart';

class Category {
  Category({
    this.id,
    this.name,
    this.colour,
    this.image,
  });

  String? id;
  String? name;
  Color? colour;
  String? image;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        colour: Color(
            int.parse(json["colour"].toLowerCase().substring(1, 7), radix: 16) +
                0xFF000000),
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "colour": colour,
        "image": image,
      };
}
