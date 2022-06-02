
import 'package:flutter/foundation.dart';

class Cart with ChangeNotifier{
    Cart({
        this.id,
        this.model,
        this.image,
        this.price,
        this.qty,
        this.productId,
        this.username,
    });

    String? id;
    String? model;
    String? image;
    double? price;
    int? qty;
    String? productId;
    String? username;

    factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        model: json["model"],
        image: json["image"],
        price: json["price"]?.toDouble(),
        qty: json["qty"],
        productId: json["product_id"],
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "model": model,
        "image": image,
        "price": price,
        "qty": qty,
        "product_id": productId,
        "username": username,
    };
}
