import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_tracker/models/task.dart';
import 'package:task_tracker/providers/task_providers.dart';

class TaskTile extends ConsumerWidget {
  final Task task;
  final int index;

  const TaskTile({super.key, required this.task, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(task.title),
      subtitle: Text(
        '${task.startTime.hour}:${task.startTime.minute.toString().padLeft(2, '0')}'
        ' - '
        '${task.endTime.hour}:${task.endTime.minute.toString().padLeft(2, '0')}',
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: () {
          ref.read(taskProvider.notifier).deleteTask(index);
        },
      ),
    );
  }
}
