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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.door.name,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        SizedBox(height: 20),

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