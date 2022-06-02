import 'package:ecommerce_app/models/error_response.dart';
import 'package:ecommerce_app/models/models.dart';
import 'package:ecommerce_app/utils/database/datebase_helper_cart.dart';
import 'package:ecommerce_app/utils/storage/storage.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class CartProvider with ChangeNotifier {
  List<Cart> _items = [];
  List<Cart> get items => _items;

  int get cartItemCount => _items.length;

  double get getTotalPrice =>
      _items.fold(0, (sum, cart) => sum + (cart.price ?? 0) * (cart.qty ?? 1));

  Future<bool> fetchAndSetItems() async {
    try {
      DatabaseHelperCart dbHelper = DatabaseHelperCart();
      final cartItems = await dbHelper.getCartItems() ?? [];
      // if (cartItems.isNotEmpty) {
      _items = [];
      for (var crt in cartItems) {
        _items.add(crt);
      }
      // }
      notifyListeners();
      return true;
    } catch (error) {
      return false;
    }
  }

  bool isAlreadyExist(Product product) {
    for (Cart? item in _items) {
      final isExist = item?.productId == product.id;
      if (isExist) {
        return true;
      }
    }
    return false;
  }

  Future<ErrorResponse?>? addToCarts(Product? product) async {
    if (product == null) {
      return ErrorResponse(error: true, message: 'Product is empty');
    } else if (isAlreadyExist(product)) {
      return ErrorResponse(
          error: true, message: 'This product is already added to the cart');
    }
    Uuid uuid = const Uuid();
    final id = uuid.v1();
    final username = await Storage.getUsername();
    Cart cart = Cart(
      id: id,
      image: product.image,
      model: product.model,
      price: product.price,
      productId: product.id,
      qty: 1,
      username: username,
    );
    DatabaseHelperCart dbHelper = DatabaseHelperCart();
    final res = await dbHelper.addToCart(cart);
    fetchAndSetItems();
    if (res != 0) {
      ErrorResponse(error: false, message: 'Product added to the cart');
    } else {
      ErrorResponse(error: false, message: 'Something went wrong');
    }
    return null;
  }

  Future<void> removeFromCarts(String id) async {
    DatabaseHelperCart dbHelper = DatabaseHelperCart();
    dbHelper.removeFromCarts(id).then((value) {
      fetchAndSetItems();
    });
  }
}
