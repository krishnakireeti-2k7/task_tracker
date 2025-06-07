import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:task_tracker/models/task.dart';
import 'package:task_tracker/providers/theme_provider.dart';
import 'package:task_tracker/screens/task_tracking_screen.dart';

void showTaskDetails(BuildContext context, WidgetRef ref, Task task) {
  // Get the current theme mode from the provider
  final currentThemeMode = ref.watch(themeProvider);
  final theme = appThemes[currentThemeMode]!; // Get the corresponding ThemeData
  final timeFormatter = DateFormat('hh:mm a');

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    enableDrag: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque, // Makes taps outside register
        onTap: () => Navigator.of(context).pop(), // Dismiss on tap outside
        child: DraggableScrollableSheet(
          initialChildSize: 0.4,
          minChildSize: 0.3,
          maxChildSize: 0.75,
          builder: (context, scrollController) {
            return GestureDetector(
              onTap: () {}, // Prevent tap-through on the content itself
              child: Container(
                decoration: BoxDecoration(
                  color:
                      theme.colorScheme.surface, // Use theme's background color
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        task.title,
                        style: theme.textTheme.headlineLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(
                            Icons.play_arrow_rounded,
                            color: const Color.fromARGB(255, 46, 134, 49),
                            size: 28,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Start: ${timeFormatter.format(task.startTime)}',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.stop_rounded, color: Colors.redAccent,size: 25,),
                          const SizedBox(width: 8),
                          Text(
                            'End: ${timeFormatter.format(task.endTime)}',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Description",
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        task.description?.trim().isEmpty == false
                            ? task.description!
                            : "No description provided.",
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontSize: 15,
                          color: Colors.grey.shade700,
                        ),
                      ),
                                            const SizedBox(height: 24),
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(
                              context,
                            ).pop(); // Close the bottom sheet
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => TaskTrackingScreen(task: task),
                              ),
                            );
                          },
                          icon: Icon(Icons.play_circle_fill_rounded, size: 24),
                          label: Text("Continue"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
