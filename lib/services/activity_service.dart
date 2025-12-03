// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../models/user.dart';

// class AuthService {
//   // ✅ Change this to your backend IP + port
//   static const String _baseUrl = "http://192.168.1.100:5000";

//   static Future<User?> login(String username, String password) async {
//     try {
//       final response = await http.post(
//         Uri.parse("$_baseUrl/api/login"),
//         headers: {
//           "Content-Type": "application/json",
//         },
//         body: jsonEncode({
//           "username": username,
//           "password": password,
//         }),
//       );

//       // ✅ Login success
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = jsonDecode(response.body);
//         return User.fromJson(data);
//       }

//       // ✅ Invalid username or password
//       return null;
//     } catch (e) {
//       // ✅ Network / server error
//       return null;
//     }
//   }
// }
