import 'package:ecommerce_app/modules/app/root.dart';
import 'package:ecommerce_app/modules/cart/cart_provider.dart';
import 'package:ecommerce_app/utils/dialogs/alert_dialogs.dart';
import 'package:ecommerce_app/widgets/cart_list_tile.dart';
import 'package:ecommerce_app/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartsView extends StatefulWidget {
  static String routeName = '/carts';
  const CartsView({Key? key}) : super(key: key);

  @override
  State<CartsView> createState() => _CartsViewState();
}

class _CartsViewState extends State<CartsView> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final carts = cartProvider.items;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Text(
                'Bless',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: (carts.isEmpty)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        Column(
                          children: [
                            Icon(
                              Icons.add_shopping_cart_outlined,
                              size: 88,
                              color: Theme.of(context).primaryColor,
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Your cart is currently empty!',
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(36.0),
                          child: RoundedButton(
                            label: 'Browse Items',
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, Root.routeName, (route) => false);
                            },
                          ),
                        )
                      ],
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(36),
                      itemCount: cartProvider.cartItemCount,
                      itemBuilder: (BuildContext context, int index) {
                        final cart = carts[index];
                        return ChangeNotifierProvider.value(
                          value: cart,
                          child: const CartListTile(),
                        );
                      },
                    ),
            ),
            Visibility(
              visible: carts.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36.0),
                child: Column(children: [
                  Divider(height: 4.5,thickness: 3, color: Theme.of(context).primaryColor),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 36.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style:
                                Theme.of(context).textTheme.headline4?.copyWith(
                                      // fontWeight: FontWeight.bold,
                                    ),
                          ),
                          Text(
                            'Rs.${cartProvider.getTotalPrice.toInt()}',
                            style:
                                Theme.of(context).textTheme.headline4?.copyWith(
                                      // fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ]),
                  )
                ]),
              ),
            ),
            Visibility(
              visible: carts.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: RoundedButton(
                  label: 'Check out',
                  onTap: () {
                    Alerts.showMessage(context,
                        message: 'Feature haven\'t implemented yet');
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
