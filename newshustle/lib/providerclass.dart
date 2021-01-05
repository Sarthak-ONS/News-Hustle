import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppData extends ChangeNotifier {
  String somedata = "Using Provider";

  // ignore: non_constant_identifier_names
  String default_Country = 'in';
  // ignore: non_constant_identifier_names
  String default_category = 'business';
  bool isDark = false;

  Future<void> storeinLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("Country", "$default_Country");
    prefs.setString("Category", "$default_category");
  }

  void changeDefaultCountry(var country) {
    default_Country = country;
    notifyListeners();
  }

  void changeDefaultCategory(var country) {
    default_category = country;
    notifyListeners();
  }

  void changeTheme(bool value) {
    isDark = value;
    notifyListeners();
  }
}
