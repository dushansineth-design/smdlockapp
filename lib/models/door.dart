// lib/models/door.dart
import 'activity.dart';

class Door {
  final int id;           // <-- add
  final String name;
  bool isLocked;
  List<Activity> activityLog;

  Door({
    required this.id,     // <-- add
    required this.name,
    this.isLocked = true,
    required this.activityLog,
  });
}