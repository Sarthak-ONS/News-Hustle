import 'package:flutter/foundation.dart';

class AppData extends ChangeNotifier {
  String somedata = "Using Provider";

  bool isDark = false;
  void changeTheme(bool value) {
    isDark = value;
    notifyListeners();
  }
}
