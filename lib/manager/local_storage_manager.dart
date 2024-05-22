import 'package:shared_preferences/shared_preferences.dart';



class LocalStorageManager {
  static const String _jwtToken = "JWT_TOKEN";
  SharedPreferences? prefs;

  Future<void> writeToken(String token) async {
    prefs ??= await SharedPreferences.getInstance();
    await prefs?.setString(_jwtToken, token);
  }

  Future<String?> readToken() async {
    prefs ??= await SharedPreferences.getInstance();
    return prefs?.getString(_jwtToken);

    // return 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJha21hbCIsImlhdCI6MTcxNDk5MTMwMiwiZXhwIjoxNzE1MDc3NzAyLCJpc3MiOiJBa29iaXIgQWJkdWdhbmlldiIsInJvbGUiOiJST0xFX1VTRVIifQ.ocT7YvAyDIKntMm1OVAMVPGEAAmAelDQY-hT4ZLtiMI';
  }

  Future<void> deleteToken() async {
    prefs ??= await SharedPreferences.getInstance();
    await prefs?.remove(_jwtToken);
  }
}
