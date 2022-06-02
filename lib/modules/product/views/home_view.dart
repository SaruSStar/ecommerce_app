import 'package:ecommerce_app/modules/cart/cart_provider.dart';
import 'package:ecommerce_app/modules/favorite/favorite_provider.dart';
import 'package:ecommerce_app/modules/product/category_provider.dart';
import 'package:ecommerce_app/modules/product/product_provider.dart';
import 'package:ecommerce_app/modules/product/views/by_categories_view.dart';
import 'package:ecommerce_app/modules/product/views/home_header_view.dart';
import 'package:ecommerce_app/modules/product/views/most_popular_view.dart';
import 'package:ecommerce_app/modules/product/views/searchbar.dart';
import 'package:ecommerce_app/modules/user/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final productProvider =
          Provider.of<ProductProvider>(context, listen: false);
      productProvider.fetchAndSetItems();
      final categoryProvider =
          Provider.of<CategoryProvider>(context, listen: false);
      categoryProvider.fetchAndSetItems();
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.fetchAndSetCurrentUser();
      final favouriteProvider =
          Provider.of<FavoriteProvider>(context, listen: false);
      favouriteProvider.fetchAndSetItems();
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      cartProvider.fetchAndSetItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(children: const [
            HomeHeaderView(),
            Searchbar(),
            ByCategoriesView(),
            MostPopularView()
          ]),
        ),
      ),
    );
  }
}
