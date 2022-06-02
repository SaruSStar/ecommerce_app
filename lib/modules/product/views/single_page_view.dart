import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/models/models.dart';
import 'package:ecommerce_app/modules/cart/cart_provider.dart';
import 'package:ecommerce_app/modules/cart/carts_view.dart';
import 'package:ecommerce_app/modules/favorite/favorite_provider.dart';
import 'package:ecommerce_app/utils/common/share.dart';
import 'package:ecommerce_app/utils/dialogs/alert_dialogs.dart';
import 'package:ecommerce_app/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Always set Product as an argument whenever calling [SinglePageView]
/// othervise this page won't work as expect
class SinglePageView extends StatefulWidget {
  static const String routeName = '/single-page';
  const SinglePageView({Key? key}) : super(key: key);

  @override
  State<SinglePageView> createState() => _SinglePageViewState();
}

class _SinglePageViewState extends State<SinglePageView> {
  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)?.settings.arguments as Product?;
    final id = product?.id ?? '';
    final name = product?.name ?? '';
    final image = product?.image ?? '';
    final model = product?.model ?? '';
    final brand = product?.brand ?? '';
    final price = product?.price?.toString() ?? '';
    final colour = product?.colour ?? '';
    final weight = product?.weight ?? '';
    return Theme(
      data: ThemeData(
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            size: 30,
            color: Theme.of(context).cardColor,
          ),
        ),
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).splashColor,
          actions: [
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {
                ShareService.share(
                    'Awesome product $name - $model - Rs $price');
              },
            ),
            Consumer<FavoriteProvider>(
              builder: (context, favoriteProvider, child) => IconButton(
                icon: Icon(
                  favoriteProvider.isFavorite(id)
                      ? Icons.favorite
                      : Icons.favorite_border_outlined,
                ),
                onPressed: () {
                  favoriteProvider.toggleFavorite(product!);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Consumer<CartProvider>(
                builder: (context, cartProvider, child) => Stack(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: () {
                        Navigator.pushNamed(context, CartsView.routeName);
                      },
                    ),
                    Visibility(
                      visible: cartProvider.cartItemCount != 0,
                      child: Positioned(
                        right: 4,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            cartProvider.cartItemCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        body: Stack(children: [
          Container(
            color: AppColors.color1,
          ),
          Column(
            children: [
              Expanded(
                child: Image.network(
                  image,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(26),
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18.0),
                      child: Text(
                        model,
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    getRow(context, 'Brand', brand),
                    getRow(context, 'Price', price),
                    getRow(context, 'Colour', colour),
                    getRow(context, 'Weight', weight),
                    const SizedBox(height: 56),
                    RoundedButton(
                      label: 'Add to Cart',
                      onTap: () async {
                        final cartProvider =
                            Provider.of<CartProvider>(context, listen: false);
                        final errorResponse =
                            await cartProvider.addToCarts(product);
                        if (!mounted || errorResponse?.message == null) return;
                        Alerts.showMessage(context,
                            message: errorResponse!.message!);
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }

  Padding getRow(BuildContext context, String title, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline5?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).disabledColor,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              value ?? '',
              style: Theme.of(context).textTheme.headline5?.copyWith(
                    color: Theme.of(context).disabledColor,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
