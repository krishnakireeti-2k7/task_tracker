import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_tracker/models/task.dart';

void showTaskDetails(BuildContext context, Task task) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      final theme = Theme.of(context);
      return Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(color: Colors.black.withAlpha(128)),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.5,
            maxChildSize: 0.8,
            minChildSize: 0.3,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor, // Use theme's background color
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 16,),
                      Text(
                        'Start Time: ${task.startTime}',
                        style: theme.textTheme.bodyMedium,
                      ),
                      SizedBox(height: 8,),
                      SizedBox(height: 8),
                      Text(
                        'End Time: ${task.endTime}',
                        style:
                            theme.textTheme.bodyMedium, // Use theme's text style
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Description: ${task.description ?? "No description provided"}',
                        style:
                            theme.textTheme.bodyMedium, // Use theme's text style
                      ),
                    ],
                  )
                )
              );
            },
          ),
        ],
      );
    },
  );
}
