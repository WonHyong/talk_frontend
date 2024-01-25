import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static final SharedPrefs _instance = SharedPrefs._internal();
  factory SharedPrefs() => _instance;
  SharedPrefs._internal();

  late final SharedPreferences _prefs;
  static const String _USER_NAME = "USER_NAME";
  static const String _IS_LOGINED_BEFORE = "LOGINED_BEFORE";

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String get username => _prefs.getString(_USER_NAME) ?? "";
  set username(String value) {
    _prefs.setString(_USER_NAME, value);
  }

  // TODO: sync ??
  bool get isFirstLogin => _prefs.getBool(_IS_LOGINED_BEFORE) ?? true;
  set isFirstLogin(bool value) {
    _prefs.setBool(_IS_LOGINED_BEFORE, value);
  }
}
