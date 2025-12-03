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

  final int? savedUserId = prefs.getInt('user_id');
  final String? savedUserName = prefs.getString('user_name');
  final String? savedUsername = prefs.getString('username');
  final String? savedRole = prefs.getString('role');

  User? savedUser;

  if (savedUserId != null &&
      savedUserName != null &&
      savedUsername != null &&
      savedRole != null) {
    savedUser = User(
      id: savedUserId,
      name: savedUserName,
      username: savedUsername,
      role: savedRole,
    );
  }

  runApp(SmartDoorLockApp(savedUser: savedUser));
}

class SmartDoorLockApp extends StatelessWidget {
  final User? savedUser;
  const SmartDoorLockApp({super.key, this.savedUser});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      initialLocation: savedUser != null ? '/home' : '/',
      routes: [
        // ✅ Login
        GoRoute(
          path: '/',
          builder: (context, state) => const LoginScreen(),
        ),

        // ✅ Home
        GoRoute(
          path: '/home',
          builder: (context, state) {
            final user = state.extra is User
                ? state.extra as User
                : savedUser!;

            return HomeScreen(user: user);
          },
        ),

        // ✅ Profile
        GoRoute(
          path: '/profile',
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;

            return ProfileScreen(
              user: extra['user'] as User,
              doors: extra['doors'] as List<Door>,
            );
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
