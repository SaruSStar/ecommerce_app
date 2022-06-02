import 'package:ecommerce_app/models/models.dart';
import 'package:ecommerce_app/services/auth/authentication.dart';
import 'package:ecommerce_app/utils/dialogs/alert_dialogs.dart';
import 'package:ecommerce_app/utils/storage/storage.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  User? get user => _user;

  bool _screenLoading = false;
  bool get screenLoadingState => _screenLoading;

  bool _isUserAvailable = false;
  bool get isUserAvailable => _isUserAvailable;

  void setScreenLoading(bool boolean) {
    _screenLoading = boolean;
    notifyListeners();
  }

  void checkUserAvailablity(bool boolean) {
    _isUserAvailable = boolean;
    notifyListeners();
  }

  Future<bool> registerUser(
    BuildContext context, {
    required String username,
    required String password,
    required String name,
  }) async {
    setScreenLoading(true);
    return Authentication.register(
      name: name,
      username: username,
      password: password,
    ).then((userRes) {
      if (userRes.status == 'error') {
        Alerts.showMessage(context,
            message: userRes.message ?? 'Error Occured!');
      }
      if (userRes.status == 'ok') {
        if (userRes.user != null) {
          _user = userRes.user;
          if (_user?.username != null) {
            Storage.storeUsername(_user!.username!);
          }
        }
        setScreenLoading(false);
        Alerts.showMessage(context, message: userRes.message ?? '');
        return true;
      } else {
        setScreenLoading(false);
        return false;
      }
    }).catchError((error) {
      Alerts.showMessage(context, message: error ?? 'Error Occured!');
      setScreenLoading(false);
      return false;
    });
  }

  Future<bool> loginUser(
    BuildContext context, {
    required String username,
    required String password,
  }) async {
    setScreenLoading(true);
    return Authentication.login(
      username: username,
      password: password,
    ).then((userRes) {
      if (userRes.status == 'error') {
        Alerts.showMessage(context,
            message: userRes.message ?? 'Error Occured!');
      }
      if (userRes.status == 'ok') {
        if (userRes.user != null) {
          _user = userRes.user;
          if (_user?.username != null) {
            Storage.storeUsername(_user!.username!);
          }
        }
        Alerts.showMessage(context, message: userRes.message ?? '');
        setScreenLoading(false);
        return true;
      } else {
        setScreenLoading(false);
        return false;
      }
    }).catchError((error) {
      Alerts.showMessage(context, message: error ?? 'Error Occured!');
      setScreenLoading(false);
      return false;
    });
  }

  void fetchAndSetCurrentUser() {
    Authentication.getCurrentUser().then((user) {
      if (user != null) {
        _user = user;
        notifyListeners();
      }
    });
  }

  void logout() {
    Authentication.logout();
    notifyListeners();
  }
}
