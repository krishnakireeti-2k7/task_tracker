import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_tracker/providers/task_providers.dart'; // Import your provider file

class AnalyticsScreen extends ConsumerStatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  ConsumerState<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends ConsumerState<AnalyticsScreen> {
  @override
  Widget build(BuildContext context) {
    final myValue = ref.watch(taskProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Analytics')),
      body: Center(
        child: Text(
          'Analytics Screen',
        ), // Display the value from the provider
      ),
    );
  }
}
