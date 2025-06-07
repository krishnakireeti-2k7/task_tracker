import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_tracker/providers/task_providers.dart';
import 'package:task_tracker/screens/analytics_screen.dart';
import 'package:task_tracker/screens/task_tracking_screen.dart';
import 'package:task_tracker/widgets/app_drawer.dart';
import 'package:task_tracker/widgets/show_task_details.dart';
import 'package:task_tracker/widgets/task_tile.dart';
import 'package:task_tracker/providers/bottom_appbar_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);
    final selectedIndex = ref.watch(bottomNavIndexProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Task Tracker'), centerTitle: true),
      drawer: AppDrawer(),
      body:
          selectedIndex == 0
              ? (tasks.isEmpty
                  ? const Center(
                    child: Text('No tasks Added yet. Start Working!'),
                  )
                  : ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          showTaskDetails(
                            context,
                            ref,
                            tasks[index],
                          ); // Pass 'ref' as the second argument
                        },
                        child: TaskTile(task: tasks[index], index: index),
                      );
                    },
                  ))
              : Container(), // Replace with your settings widget
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TaskTrackingScreen()),
          );
          ref.invalidate(taskProvider);
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked, // <-- Centered with notch
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(), // <-- Notch for FAB
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: FaIcon(FontAwesomeIcons.houseChimneyWindow),
              onPressed: () {
                ref.read(bottomNavIndexProvider.notifier).state =
                    0; // or 1 for settings
              },
            ),
            SizedBox(width: 48), // Space for the FAB
            IconButton(
              icon: FaIcon(
                FontAwesomeIcons.chartSimple,
              ), //FaIcon(FontAwesomeIcons.chartSimple)
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AnalyticsScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Color getCardColor(BuildContext context) {
  return Theme.of(context).colorScheme.surface;
}
