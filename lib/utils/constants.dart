class AppConstants {
  // ✅ Backend base URL (Flask server)
  static const String baseUrl = "http://192.168.8.125:5001";

  // ---------------- AUTH ----------------
  static const String login = "$baseUrl/api/login";

  // ---------------- USER DATA ----------------
  // Replace {userId} dynamically when calling
  static const String userKeys = "$baseUrl/api/user/{userId}/keys";
  static const String userDoors = "$baseUrl/api/user/{userId}/doors";

  // ---------------- ADMIN / APP COMMAND ----------------
  static const String doorCommand = "$baseUrl/api/admin/door/command";

  // ---------------- ACCESS LOGS ----------------
  static const String logs = "$baseUrl/api/logs";
}
