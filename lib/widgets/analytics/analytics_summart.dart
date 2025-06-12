import 'package:flutter/material.dart';
import 'package:task_tracker/models/task.dart';

// Custom consistent color mapping per task
const Map<String, Color> taskColorMap = {
  'Coding': Colors.teal,
  'Workout': Colors.red,
  'Reading': Colors.pink,
  'Meditation': Colors.deepOrange,
  'Break': Colors.grey,
};

Color getTaskColor(String title) {
  return taskColorMap[title] ?? Colors.blueGrey;
}

class AnalyticsSummary extends StatelessWidget {
  final List<Task> tasks;

  const AnalyticsSummary({super.key, required this.tasks});

  List<Task> _topTasks(List<Task> tasks) {
    final sorted = [...tasks]..sort((a, b) => b.duration.compareTo(a.duration));
    return sorted.take(5).toList(); // Top 5
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else if (minutes > 0) {
      return '${minutes}m';
    } else {
      return '${seconds}s';
    }
  }

  @override
  Widget build(BuildContext context) {
    final topTasks = tasks.where((t) => t.duration.inSeconds > 0).toList();
    if (topTasks.isEmpty) {
      return const Center(child: Text('No data to show yet.'));
    }

    // Sort by duration descending
    topTasks.sort(
      (a, b) => b.duration.inSeconds.compareTo(a.duration.inSeconds),
    );

    final totalDuration = topTasks.fold<Duration>(
      Duration.zero,
      (sum, task) => sum + task.duration,
    );
    final totalSeconds = totalDuration.inSeconds;

    // Just some example colors — you can customize these
    final colors = [
      Colors.teal,
      Colors.pinkAccent,
      Colors.redAccent,
      Colors.deepOrange,
      Colors.brown,
      Colors.grey,
      Colors.blueGrey,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Today’s Time Breakdown',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          children:
              topTasks.asMap().entries.map((entry) {
                final index = entry.key;
                final task = entry.value;
                final seconds = task.duration.inSeconds;
                final widthFactor = seconds / totalSeconds;

                return Expanded(
                  flex: (widthFactor * 1000).clamp(1, 1000).toInt(),
                  child: Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: colors[index % colors.length],
                      borderRadius:
                          index == 0
                              ? const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                              )
                              : index == topTasks.length - 1
                              ? const BorderRadius.only(
                                topRight: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              )
                              : BorderRadius.zero,
                    ),
                  ),
                );
              }).toList(),
        ),
        const SizedBox(height: 16),
        ...topTasks.asMap().entries.map((entry) {
          final index = entry.key;
          final task = entry.value;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: colors[index % colors.length],
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(child: Text(task.title)),
                Text(_formatDuration(task.duration)),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}