import 'package:ecommerce_app/models/models.dart';
import 'package:ecommerce_app/services/api/categories.dart';
import 'package:flutter/foundation.dart' hide Category;

class CategoryProvider with ChangeNotifier {
  List<Category?> _items = [];
  List<Category?> get items => _items;

  String? _errorMessage;
  String? get errorMessgage => _errorMessage;

  bool fetchAndSetItems({bool pagination = false}) {
    _items = categoriesMap.map((product) => Category.fromJson(product)).toList();
    notifyListeners();
    return true;
  }
}
