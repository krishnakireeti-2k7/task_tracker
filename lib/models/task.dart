import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  DateTime startTime;

  @HiveField(2)
  DateTime endTime;

  @HiveField(3)
  String? description;

  @HiveField(4)
  Duration duration;


  Task({
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.description,
    this.duration = Duration.zero,
  });
}
