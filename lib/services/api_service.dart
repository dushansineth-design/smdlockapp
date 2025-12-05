// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../utils/constants.dart'; // <-- add this

class ApiService {
  // LOGIN
  static Future<User?> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(AppConstants.login),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return User.fromJson(data);
      }
      return null;
    } catch (e) {
      print("Login error: $e");
      return null;
    }
  }

  // GET KEYS
  static Future<List<Map<String, dynamic>>> getUserKeys(int userId) async {
    final url = AppConstants.userKeys.replaceFirst('{userId}', '$userId');
    try {
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        return List<Map<String, dynamic>>.from(jsonDecode(res.body));
      }
      return [];
    } catch (e) {
      print("getUserKeys error: $e");
      return [];
    }
  }

  // GET DOORS
  static Future<List<Map<String, dynamic>>> getUserDoors(int userId) async {
    final url = AppConstants.userDoors.replaceFirst('{userId}', '$userId');
    try {
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        return List<Map<String, dynamic>>.from(jsonDecode(res.body));
      }
      return [];
    } catch (e) {
      print("getUserDoors error: $e");
      return [];
    }
  }

  // TOGGLE DOOR COMMAND
  static Future<bool> sendDoorCommand({required int doorId, required String command}) async {
    try {
      final res = await http.post(
        Uri.parse(AppConstants.doorCommand),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'door_id': doorId, 'command': command}), // command: "lock" or "unlock"
      );
      return res.statusCode == 200;
    } catch (e) {
      print("sendDoorCommand error: $e");
      return false;
    }
  }


  static Future<List<Map<String, dynamic>>> getLogs() async {
    try {
      final res = await http.get(Uri.parse(AppConstants.logs));
      if (res.statusCode == 200) {
        return List<Map<String, dynamic>>.from(jsonDecode(res.body));
      }
      return [];
    } catch (e) {
      print("getLogs error: $e");
      return [];
    }
  }
}