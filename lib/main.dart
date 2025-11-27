import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/user.dart';
import 'models/door.dart';

import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final savedUserName = prefs.getString('userName');

  runApp(SmartDoorLockApp(savedUserName: savedUserName));
}

class SmartDoorLockApp extends StatelessWidget {
  final String? savedUserName;
  const SmartDoorLockApp({super.key, this.savedUserName});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      initialLocation: savedUserName != null ? '/home' : '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => LoginScreen(), // ✅ FIXED
        ),

        GoRoute(
          path: '/home',
          builder: (context, state) {
            final userName = state.extra is String
                ? state.extra as String
                : savedUserName ?? 'Guest';

            return HomeScreen(user: User(name: userName));
          },
        ),

        GoRoute(
          path: '/profile',
          builder: (context, state) {
            final extra = state.extra is Map<String, dynamic>
                ? state.extra as Map<String, dynamic>
                : {};

            final user = extra['user'] as User? ??
                User(name: savedUserName ?? 'Guest');

            final doors = extra['doors'] as List<Door>? ?? [];

            return ProfileScreen(user: user, doors: doors);
          },
        ),
      ],
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Smart Door Lock',
      theme: ThemeData.dark(),
      routerConfig: router,
    );
  }
}
