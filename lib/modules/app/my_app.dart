import 'package:ecommerce_app/constants/app_constants.dart';
import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/modules/app/root.dart';
import 'package:ecommerce_app/modules/cart/cart_provider.dart';
import 'package:ecommerce_app/modules/cart/carts_view.dart';
import 'package:ecommerce_app/modules/favorite/favorite_provider.dart';
import 'package:ecommerce_app/modules/filter/filter_provider.dart';
import 'package:ecommerce_app/modules/filter/filter_view.dart';
import 'package:ecommerce_app/modules/product/category_provider.dart';
import 'package:ecommerce_app/modules/product/product_provider.dart';
import 'package:ecommerce_app/modules/product/views/single_page_view.dart';
import 'package:ecommerce_app/modules/user/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => FilterProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Constants.appName,
        initialRoute: Root.routeName,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.scaffoldBg,
        ),
        routes: {
          Root.routeName: (context) => const Root(),
          SinglePageView.routeName: (context) => const SinglePageView(),
          FilterView.routeName: (context) => const FilterView(),
          CartsView.routeName: (context) => const CartsView(),
        },
      ),
    );
  }
}
