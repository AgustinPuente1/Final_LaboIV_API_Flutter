import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static bool _darkmode = false;
  static late SharedPreferences _prefs;

  static Future<void> initShared() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get darkmode {
    return _prefs.getBool('darkmode') ?? _darkmode;
  }

  static set darkmode(bool value) {
    _darkmode = value;
    _prefs.setBool('darkmode', value);
  }
}