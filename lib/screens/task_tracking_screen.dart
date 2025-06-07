import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_tracker/models/task.dart';
import 'package:task_tracker/providers/task_providers.dart';

class TaskTrackingScreen extends ConsumerStatefulWidget {
  final Task? task;
  const TaskTrackingScreen({super.key, this.task});

  @override
  ConsumerState<TaskTrackingScreen> createState() => _TaskTrackingScreenState();
}

class _TaskTrackingScreenState extends ConsumerState<TaskTrackingScreen> {
  DateTime? startTime;
  DateTime? endTime;
  Duration elapsed = Duration.zero;
  Timer? _timer;

  bool isTracking = false;

  final TextEditingController titleController =
      TextEditingController(); // Title controller
  final TextEditingController descriptionController =
      TextEditingController(); // Description controller

  /// Starts the timer and sets the start time
  void _startTimer() {
    startTime ??= DateTime.now();

    isTracking = true;

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        elapsed += const Duration(seconds: 1);
      });
    });

    setState(() {});
  }

  void _stopTimer() {
    _timer?.cancel();
    isTracking = false;
    if (startTime == null) return;
    endTime = DateTime.now();

    if (widget.task != null) {
      widget.task!
        ..endTime = endTime!
        ..title =
            titleController.text.trim().isEmpty
                ? 'Untitled Task'
                : titleController.text.trim()
        ..description =
            descriptionController.text.trim().isEmpty
                ? null
                : descriptionController.text.trim()
        ..duration = elapsed; //  Store actual tracked duration
      widget.task!.save();
    } else {
      final newTask = Task(
        startTime: startTime!,
        endTime: endTime!,
        title:
            titleController.text.trim().isEmpty
                ? 'Untitled Task'
                : titleController.text.trim(),
        description:
            descriptionController.text.trim().isEmpty
                ? null
                : descriptionController.text.trim(),
        duration: elapsed, //  Save this
      );
      ref.read(taskProvider.notifier).addTask(newTask);
    }

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
  void initState() {
    super.initState();

    if (widget.task != null) {
      titleController.text = widget.task!.title;
      descriptionController.text = widget.task!.description ?? '';
      startTime = widget.task!.startTime;
      elapsed = widget.task!.duration;
      _startTimer();
    } else {
      elapsed = Duration.zero; // Explicitly reset
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat.yMMMd().add_jm();

    return Scaffold(
      //backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Start tracking ',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 16),

                const Text(
                  'Start Time',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Text(
                  startTime != null ? dateFormat.format(startTime!) : '--',
                  style: const TextStyle(fontSize: 18),
                ),

                const SizedBox(height: 32),

                Center(
                  child: Text(
                    _formatDuration(elapsed),
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Title field
                const Text(
                  'Title',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: titleController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: 'Enter a title or use quick tags',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Quick tags for title
                Wrap(
                  spacing: 8,
                  children: [
                    for (final label in ['Work', 'Study', 'Relax', 'Exercise'])
                      ActionChip(
                        label: Text(label),
                        onPressed: () {
                          titleController.text =
                              label; // Set title from quick tag
                          titleController
                              .selection = TextSelection.fromPosition(
                            TextPosition(offset: titleController.text.length),
                          );
                          setState(() {});
                        },
                      ),
                  ],
                ),

                const SizedBox(height: 24),

                // Description field
                const Text(
                  'Description',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
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

                if (!isTracking)
                  ElevatedButton(
                    onPressed: _startTimer,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: Colors.blue,
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
                      backgroundColor: Colors.blue,
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
