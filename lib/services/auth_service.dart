// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../models/user.dart';
// import '../utils/constants.dart';

// class AuthService {
//   static Future<User?> login(String username, String password) async {
//     try {
//       final response = await http.post(
//         Uri.parse("${AppConstants.baseUrl}/api/login"),
//         headers: {
//           "Content-Type": "application/json",
//         },
//         body: jsonEncode({
//           "username": username,
//           "password": password,
//         }),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         return User.fromJson(data);
//       }

//       return null; // invalid credentials
//     } catch (e) {
//       return null; // network error
//     }
//   }
// }
