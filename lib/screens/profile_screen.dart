import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/door.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  final User user;
  final List<Door> doors;

  const ProfileScreen({
    super.key,
    required this.user,
    required this.doors,
  });

  void _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await prefs.remove('user_id');
    await prefs.remove('user_name');
    await prefs.remove('username');
    await prefs.remove('role');
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => context.pop(),
                    ),
                    const Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Logged in as ${user.name}",
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Door Summary",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    ...doors.map(
                      (door) => ListTile(
                        leading: Icon(
                          door.isLocked ? Icons.lock : Icons.lock_open,
                          color: door.isLocked ? Colors.red : Colors.green,
                        ),
                        title: Text(
                          door.name,
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          door.isLocked ? "Locked" : "Unlocked",
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () => _logout(context),
                        icon: const Icon(Icons.logout),
                        label: const Text("Logout"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
