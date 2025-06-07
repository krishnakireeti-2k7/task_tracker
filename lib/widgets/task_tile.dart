import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_tracker/models/task.dart';
import 'package:task_tracker/providers/task_providers.dart';
import 'package:intl/intl.dart'; // <-- Add this for formatting

class TaskTile extends ConsumerWidget {
  final Task task;
  final int index;

  const TaskTile({super.key, required this.task, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeFormatter = DateFormat('hh:mm a'); // 12-hour format

    return ListTile(
      title: Text(task.title),
      subtitle: Text(
        '${timeFormatter.format(task.startTime)} - ${timeFormatter.format(task.endTime)}',
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.grey),
        onPressed: () {
          ref.read(taskProvider.notifier).deleteTask(index);
        },
      ),
    );
  }
}
