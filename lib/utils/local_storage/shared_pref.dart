import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefServices {
  static late SharedPreferences _sharedPref;

  static Future<void> init() async {
    _sharedPref = await SharedPreferences.getInstance();
  }

  static bool isFirstTime() {
    return _sharedPref.getBool('first_time') ?? true;
  }

  static Future<void> setSeen() async {
    await _sharedPref.setBool('first_time', false);
  }

  // Remember Me Logic
  static Future<void> saveRemeberMe(String email, String password) async {
    await _sharedPref.setString('email', email);
    await _sharedPref.setString('password', password);
    await _sharedPref.setBool('remember_me', true);
  }

  static bool isRememberMe() {
    return _sharedPref.getBool('remember_me') ?? false;
  }

  static String getEmail() {
    return _sharedPref.getString('email') ?? '';
  }

  static String getPassword() {
    return _sharedPref.getString('password') ?? '';
  }

  static Future<void> removeRememberMe() async {
    await _sharedPref.remove('email');
    await _sharedPref.remove('password');
    await _sharedPref.remove('remember_me');
  }
}
