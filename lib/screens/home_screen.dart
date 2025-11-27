
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/door.dart';
//import '../models/activity.dart';
import '../widgets/door_card.dart';
import '../screens/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  final User user;

  HomeScreen({super.key, required this.user});

  final List<Door> doors = [
    Door(name: "Front Door", activityLog: []),
    Door(name: "Garage Door", activityLog: []),
    Door(name: "Back Door", activityLog: []),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Welcome ${user.name}",
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.person, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProfileScreen(user: user, doors: doors),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 30),
              ...doors.map((door) => DoorCard(door: door)),
            ],
          ),
        ),
      ),
    );
  }
}
