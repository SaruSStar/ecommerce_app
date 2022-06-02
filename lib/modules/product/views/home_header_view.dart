import 'package:ecommerce_app/modules/app/root.dart';
import 'package:ecommerce_app/modules/user/user_provider.dart';
import 'package:ecommerce_app/utils/dialogs/alert_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeHeaderView extends StatelessWidget {
  const HomeHeaderView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final name = userProvider.user?.name ?? '';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'BLISS',
              style: Theme.of(context).textTheme.headline3?.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Text(
                'Hello,',
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: Theme.of(context).disabledColor,
                    ),
              ),
            ),
            Text(
              name,
              style: Theme.of(context).textTheme.headline4?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        Column(
          children: [
            const CircleAvatar(
              radius: 46,
              // backgroundImage: AssetImage(''),
            ),
            TextButton(
              onPressed: () {
                Alerts.showDialogYesNo(context,
                    title: 'Logout',
                    message: 'Are you sure you want to logout?', onYes: () {
                  Navigator.of(context).pop();
                  userProvider.logout();
                  Navigator.of(context).pushReplacementNamed(Root.routeName);
                });
              },
              child: const Text('Logout'),
            )
          ],
        ),
      ],
    );
  }
}
