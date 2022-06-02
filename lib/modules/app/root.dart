import 'package:ecommerce_app/modules/authentication/login_view.dart';
import 'package:ecommerce_app/modules/product/views/home_view.dart';
import 'package:ecommerce_app/utils/storage/storage.dart';
import 'package:ecommerce_app/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';

class Root extends StatefulWidget {
  static const String routeName = '/';
  const Root({Key? key}) : super(key: key);

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Storage.isUserAvailable(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Checking wether user logged in or not to show relevant page
            final isAvailable = (snapshot.data as bool?) ?? false;
            if (isAvailable) {
              return const HomeView();
            } else {
              return const LoginView();
            }
          } else {
            return const Scaffold(
              body: Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: ScreenProgressIndicator(),
                ),
              ),
            );
          }
        });
  }
}
