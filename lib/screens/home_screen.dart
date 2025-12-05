// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/door.dart';
import '../widgets/door_card.dart';
import '../screens/profile_screen.dart';
import '../screens/logs_screen.dart';
import '../services/api_service.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  final User user;
  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  List<Door> doors = [];
  bool loading = true;
  Timer? _pollTimer; // optional periodic refresh

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadDoors();

    // OPTIONAL: Poll every 10 seconds to auto-update UI.
    // Comment out if you prefer manual refresh only.
    _pollTimer = Timer.periodic(const Duration(seconds: 10), (_) => _loadDoors(silent: true));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pollTimer?.cancel();
    super.dispose();
  }

  // When app returns to foreground, refresh the doors
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _loadDoors(silent: true);
    }
  }

  Future<void> _loadDoors({bool silent = false}) async {
    if (!silent) setState(() => loading = true);

    final data = await ApiService.getUserDoors(widget.user.id);

    final fetched = data.map((d) => Door(
      id: d['id'],
      name: d['name'],
      // Backend /api/user/{id}/doors does not include status; we keep local UI state.
      isLocked: true,
      activityLog: [],
    )).toList();

    if (!mounted) return;
    setState(() {
      doors = fetched;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: SafeArea(
        child: loading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : RefreshIndicator(
              color: Colors.white,
              backgroundColor: Colors.black,
              onRefresh: () => _loadDoors(), // pull to refresh
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(), // needed for RefreshIndicator
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Header
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Welcome ${widget.user.name}",
                              style: const TextStyle(
                                fontSize: 28,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.history, color: Colors.white),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => const LogsScreen()),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.person, color: Colors.white),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ProfileScreen(user: widget.user, doors: doors),
                                      ),
                                    ).then((_) {
                                      _loadDoors(silent: true);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(height: 2, color: Colors.white),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // If no doors, show a friendly message + manual refresh hint
                    if (doors.isEmpty)
                      Column(
                        children: const [
                          Text(
                            "No doors assigned to your account yet.",
                            style: TextStyle(color: Colors.white70),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Pull down to refresh after server changes.",
                            style: TextStyle(color: Colors.white38),
                          ),
                        ],
                      )
                    else
                      ...doors.map((door) => DoorCard(door: door)),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}