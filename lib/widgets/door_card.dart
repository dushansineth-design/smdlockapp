import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/door.dart';
import 'custom_button.dart';

class DoorCard extends StatefulWidget {
  final Door door;

  const DoorCard({super.key, required this.door});

  @override
  State<DoorCard> createState() => _DoorCardState();
}

class _DoorCardState extends State<DoorCard> {
  void _toggleLock() {
    setState(() {
      widget.door.isLocked = !widget.door.isLocked;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "${widget.door.name} ${widget.door.isLocked ? "locked" : "unlocked"}",
        ),
      ),
    );
  }

  Color _getDoorColor(String doorName) {
    switch (doorName) {
      case "Main Door":
        return Colors.blue;
      case "Lab Door":
        return Colors.green;
      case "Cabin Door":
        return Colors.orange;
      default:
        return Colors.purple;
    }
  }

  Color _getSecondaryDoorColor(String doorName) {
    switch (doorName) {
      case "Main Door":
        return Colors.blue.shade800;
      case "Lab Door":
        return Colors.green.shade800;
      case "Cabin Door":
        return Colors.orange.shade800;
      default:
        return Colors.purple.shade800;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Door name with gradient background
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _getDoorColor(widget.door.name),
                _getSecondaryDoorColor(widget.door.name),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: _getDoorColor(widget.door.name).withAlpha(100),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(
            widget.door.name,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),

        SizedBox(height: 20),

        // Custom button remains unchanged
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(230),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withAlpha(230)),
                ),
                child: CustomButton(
                  text: widget.door.isLocked ? "Tap to Unlock" : "Tap to Lock",
                  icon: widget.door.isLocked ? Icons.lock : Icons.lock_open,
                  onPressed: _toggleLock,
                  backgroundColor:
                      widget.door.isLocked ? const Color.fromARGB(255, 255, 17, 0) : const Color.fromARGB(255, 0, 255, 8),
                  glowColor:
                      widget.door.isLocked ? const Color.fromARGB(255, 255, 0, 0) : const Color.fromARGB(255, 0, 255, 132),
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 30),
      ],
    );
  }
}