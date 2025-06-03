import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_tracker/models/task.dart';
import 'package:task_tracker/providers/task_providers.dart';

class TaskTrackingScreen extends ConsumerStatefulWidget {
  const TaskTrackingScreen({super.key});

  @override
  ConsumerState<TaskTrackingScreen> createState() => _TaskTrackingScreenState();
}

class _TaskTrackingScreenState extends ConsumerState<TaskTrackingScreen> {
  DateTime? startTime;
  DateTime? endTime;
  Duration elapsed = Duration.zero;
  Timer? _timer;

  bool isTracking = false;

  final TextEditingController descriptionController = TextEditingController();

  /// Starts the timer and sets the start time
  void _startTimer() {
    startTime = DateTime.now();
    isTracking = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        elapsed = DateTime.now().difference(startTime!);
      });
    });
    setState(() {});
  }

  /// Stops the timer and saves the task via provider
  void _stopTimer() {
    _timer?.cancel();
    endTime = DateTime.now();

    // Save task to provider
    final newTask = Task(
      startTime: startTime!,
      endTime: endTime!,
      title: descriptionController.text.trim(),
    );

    ref.read(taskProvider.notifier).addTask(newTask);

    // Pop back to home screen
    Navigator.pop(context);
  }

  /// Formats timer like 00:10:32
  String _formatDuration(Duration duration) {
    final h = duration.inHours.toString().padLeft(2, '0');
    final m = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  @override
  void dispose() {
    _timer?.cancel();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat.yMMMd().add_jm();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Task Tracker',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Start Time',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  startTime != null ? dateFormat.format(startTime!) : '--:--',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 32),
                Center(
                  child: Text(
                    _formatDuration(elapsed),
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Description',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: descriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'What are you working on now?',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 8,
                  children: [
                    for (final label in ['Work', 'Study', 'Relax', 'Exercise'])
                      ActionChip(
                        label: Text(label),
                        onPressed: () {
                          descriptionController.text = label;
                          descriptionController
                              .selection = TextSelection.fromPosition(
                            TextPosition(
                              offset: descriptionController.text.length,
                            ),
                          );
                          setState(() {});
                        },
                      ),
                  ],
                ),
                if (!isTracking)
                  ElevatedButton(
                    onPressed: _startTimer,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text('Start', style: TextStyle(fontSize: 18)),
                  ),
                if (isTracking)
                  ElevatedButton(
                    onPressed: _stopTimer,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text('Stop', style: TextStyle(fontSize: 18)),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
