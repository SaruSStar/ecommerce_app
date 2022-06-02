import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/models/models.dart';
import 'package:ecommerce_app/services/api/products.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier {
  List<Product?> _items = [];
  List<Product?> get items => _items;

  bool fetchAndSetItems({bool pagination = false}) {
    _items = productsMap
        .map((product) =>
            Product.fromJson(product).copyWith(bgColor: getRandomColor))
        .toList();
    notifyListeners();
    return true;
  }

  Color get getRandomColor {
    final colors = [
      AppColors.color1,
      AppColors.color2,
      AppColors.color3,
      AppColors.color4,
      AppColors.color5,
      AppColors.color6,
    ];
    colors.shuffle();
    return colors.first;
  }
}
