import 'package:lotalk_frontend/src/model/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static const String _ACCESS_TOKEN_KEY = "JWT_ACCESS";

  static Future<void> storeToken(Token token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_ACCESS_TOKEN_KEY, token.accessToken);
  }

  static Future<String> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return Future.value(prefs.getString(_ACCESS_TOKEN_KEY));
  }
}
