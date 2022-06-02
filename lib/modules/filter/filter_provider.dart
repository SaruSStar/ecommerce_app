import 'package:ecommerce_app/models/models.dart';
import 'package:ecommerce_app/modules/product/product_provider.dart';
import 'package:ecommerce_app/services/api/products.dart';

class FilterProvider extends ProductProvider {
  List<Product?> _items = [];
  List<Product?> get filterItems => _items;

  String? _filterQuery;
  String? get filterQuery => _filterQuery;

  bool fetchAndSetFilterItems({required String category}) {
    _filterQuery = category;
    _items = productsMap
        .map((product) =>
            Product.fromJson(product).copyWith(bgColor: getRandomColor))
        .toList()
        .where((element) => element.category == category)
        .toList();
    notifyListeners();
    return true;
  }
}
