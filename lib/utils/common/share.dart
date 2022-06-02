import 'package:share_plus/share_plus.dart';

class ShareService {
  static void share(String text) {
    Share.share(text);
  }
}
