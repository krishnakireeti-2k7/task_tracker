import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_tracker/models/task.dart';
import 'package:task_tracker/providers/task_providers.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_tracker/widgets/analytics/analytics_summart.dart';

Future<Map<String, Duration>> groupTasksByCustomDay(List<Task> tasks) async {
  final prefs = await SharedPreferences.getInstance();
  final startStr = prefs.getString('dayStartTime') ?? '05:00';
  final endStr = prefs.getString('dayEndTime') ?? '05:00';

  final startParts = startStr.split(':').map(int.parse).toList();
  final dayStartHour = startParts[0];
  final dayStartMinute = startParts[1];

  Map<String, Duration> grouped = {};

  for (final task in tasks) {
    // Determine custom day key based on user-defined start
    DateTime taskTime = task.startTime;
    final customStart = DateTime(
      taskTime.year,
      taskTime.month,
      taskTime.day,
      dayStartHour,
      dayStartMinute,
    );

    if (taskTime.isBefore(customStart)) {
      taskTime = taskTime.subtract(const Duration(days: 1));
    }

    final key = DateFormat(
      'MMM d',
    ).format(DateTime(taskTime.year, taskTime.month, taskTime.day));

    grouped[key] = (grouped[key] ?? Duration.zero) + task.duration;
  }

  return grouped;
}

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
        : AnalyticsSummary(tasks: tasks),
      ),
    );
  }
}
