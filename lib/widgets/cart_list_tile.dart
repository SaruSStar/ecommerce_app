import 'package:ecommerce_app/models/models.dart';
import 'package:ecommerce_app/modules/cart/cart_provider.dart';
import 'package:ecommerce_app/modules/product/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartListTile extends StatelessWidget {
  const CartListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final cart = Provider.of<Cart>(context);
    final id = cart.id ?? '';
    final image = cart.image ?? '';
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: productProvider.getRandomColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                  height: 130,
                  width: 130,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cart.model ?? '',
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).cardColor,
                            ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Rs ${cart.price?.toStringAsFixed(2)}',
                          style:
                              Theme.of(context).textTheme.headline5?.copyWith(
                                    color: Theme.of(context).cardColor,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 46,
              )
            ],
          ),
        ),
        Positioned(
          right: 0,
          top: 18,
          child: IconButton(
            onPressed: () {
              cartProvider.removeFromCarts(id);
            },
            icon: const Icon(
              Icons.close,
            ),
          ),
        )
      ],
    );
  }
}
