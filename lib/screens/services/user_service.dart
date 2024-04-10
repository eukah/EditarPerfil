import 'package:shared_preferences/shared_preferences.dart';
import '../user.dart';

class UserService {
  static const String _userKey = 'user';

  static Future<User> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);
    if (userJson == null) {
      return User(
        nome: '',
        email: '',
        profilePicture: '',
        password: '',
      );
    }
    final userMap = (userJson);
    return User.fromJson(userMap);
  }

  static Future<void> saveUser(User user) async {
    final userJson = user.toJson();
    userJson;
  }

  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
  
static Future<bool> checkCredentials(String email, String password) async {
  final prefs = await SharedPreferences.getInstance();
  final storedEmail = prefs.getString('email');
  final storedPassword = prefs.getString('password');

  if (email == storedEmail && password == storedPassword) {
    return true;
  } else {
    return false;
  }
}
}