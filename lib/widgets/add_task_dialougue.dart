import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_tracker/models/task.dart';
import 'package:task_tracker/providers/task_providers.dart';

class AddTaskDialougue extends ConsumerStatefulWidget {
  const AddTaskDialougue({super.key});

  @override
  ConsumerState<AddTaskDialougue> createState() => _AddTaskDialougueState();
}

class _AddTaskDialougueState extends ConsumerState<AddTaskDialougue> {
  final TextEditingController _titleControler = TextEditingController();
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('New task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleControler,
            decoration: const InputDecoration(labelText: 'Task title'),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              final picked = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (picked != null) setState(() => _startTime = picked);
            },
            child: Text(
              _startTime == null
              ? "Pick start time"
              : "Start: ${_startTime!.format(context)}"
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final picked = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (picked != null) setState(() => _endTime = picked);
            },
            child: Text(
              _endTime == null
                  ? "Pick End Time"
                  : "End: ${_endTime!.format(context)}",
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: const Text('Add'),
          onPressed: () {
            final title = _titleControler.text.trim();
            if (title.isEmpty || _startTime == null || _endTime == null) return;

            final now = DateTime.now();
            final task = Task(
              title: title,
              startTime: DateTime(now.year, now.month, now.day, _startTime!.hour, _startTime!.minute),
              endTime: DateTime(now.year, now.month, now.day, _endTime!.hour, _endTime!.minute),
            );

            ref.read(taskProvider.notifier).addTask(task);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
