import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_tracker/providers/task_providers.dart';
import 'package:task_tracker/screens/task_tracking_screen.dart';
import 'package:task_tracker/widgets/task_tile.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Task Tracker'), centerTitle: true),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(child: Text('Menu'),decoration: BoxDecoration(color: Colors.blue),),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
      body:
          tasks.isEmpty
              ? const Center(child: Text('No tasks Added yet. Start Working!'))
              : ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return TaskTile(task: tasks[index], index: index);
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TaskTrackingScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
