import 'package:ecommerce_app/models/models.dart';
import 'package:ecommerce_app/utils/database/datebase_helper_favorite.dart';
import 'package:flutter/foundation.dart';

class FavoriteProvider with ChangeNotifier {
  List<Product> _items = [];
  List<Product> get items => _items;

  bool _fetchingItems = false;
  bool get fetchingItems => _fetchingItems;

  void changeFetchingItemLoading(bool value) {
    _fetchingItems = value;
    notifyListeners();
  }

  Future<bool> fetchAndSetItems() async {
    try {
      DatabaseHelperFavorite dbHelper = DatabaseHelperFavorite();
      final favItems = await dbHelper.getFavoriteItems() ?? [];
      if (favItems.isNotEmpty) {
        _items = [];
        for (var product in favItems) {
          _items.add(product);
        }
      }
      notifyListeners();
      return true;
    } catch (error) {
      return false;
    }
  }

  void toggleFavorite(Product product) {
    if (product.id != null) {
      if (isFavorite(product.id!)) {
        removeFromFavorite(product.id!).then(
          (value) => fetchAndSetItems(),
        );
      } else {
        addToFavorite(product).then(
          (value) => fetchAndSetItems(),
        );
      }
    }
  }

  bool isFavorite(String? id) {
    for (var item in items) {
      if (item.id == id) return true;
    }
    return false;
  }

  Future<bool> addToFavorite(Product product) async {
    DatabaseHelperFavorite dbHelper = DatabaseHelperFavorite();
    final res = await dbHelper.addToFavourite(product);
    return (res != 0);
  }

  Future<bool> removeFromFavorite(String id) async {
    DatabaseHelperFavorite dbHelper = DatabaseHelperFavorite();
    final res = await dbHelper.removeFromFavorite(id);
    return (res != 0);
  }
}
