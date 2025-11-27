import '../models/user.dart';

class AuthService {
  // ✅ Step 1: Create a mock user database
  static final Map<String, String> _userDatabase = {
    'user': '1234',
    'admin': 'adminpass',
    'guest': '0000',
  };

  // ✅ Step 2: Validate ID and password
  static Future<User?> login(String userId, String password) async {
    await Future.delayed(Duration(seconds: 1)); // simulate network delay

    if (_userDatabase.containsKey(userId) && _userDatabase[userId] == password) {
      return User(name: userId);
    }

    return null;
  }
}