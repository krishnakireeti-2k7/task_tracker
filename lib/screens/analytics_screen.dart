import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_tracker/models/task.dart';
import 'package:task_tracker/providers/task_providers.dart';
import 'package:intl/intl.dart';

class AnalyticsScreen extends ConsumerStatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  ConsumerState<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends ConsumerState<AnalyticsScreen> {
  Duration _totalTime(List<Task> tasks) {
    return tasks.fold(Duration.zero, (sum, task) => sum + task.duration);
  }

  Duration _todayTime(List<Task> tasks) {
    final today = DateTime.now();
    return tasks
        .where(
          (task) =>
              task.startTime.year == today.year &&
              task.startTime.month == today.month &&
              task.startTime.day == today.day,
        )
        .fold(Duration.zero, (sum, task) => sum + task.duration);
  }

  List<Task> _topTasks(List<Task> tasks) {
    final sorted = [...tasks]..sort((a, b) => b.duration.compareTo(a.duration));
    return sorted.take(3).toList();
  }

  String _formatDuration(Duration duration) {
    final h = duration.inHours;
    final m = duration.inMinutes.remainder(60);
    return '${h}h ${m}m';
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(taskProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Analytics')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: tasks.isEmpty
        ? const Center(child: Text('No tasks to analyze yet.'),)
        : Column(
          children: [
                    Text(
                      '🧠 Total Time Tracked: ${_formatDuration(_totalTime(tasks))}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '📅 Time Spent Today: ${_formatDuration(_todayTime(tasks))}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      '🏆 Top 3 Tasks:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ..._topTasks(tasks).map(
                      (task) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          '• ${task.title} – ${_formatDuration(task.duration)}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
        ),
      ),
    );
  }
}
