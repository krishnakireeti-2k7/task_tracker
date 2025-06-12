import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> showDayTimeDialog(BuildContext context) async {
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).dialogTheme.backgroundColor?.withOpacity(0.85)
                    ?? Theme.of(context).cardColor.withOpacity(0.85),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 30,
                    offset: Offset(0, 12),
                  )
                ],
              ),
              padding: const EdgeInsets.all(24),
              child: StatefulBuilder(
                builder: (context, setState) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Customize Your Day',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 24),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(Icons.wb_sunny_outlined, color: Theme.of(context).iconTheme.color),
                        title: Text(
                          startTime != null
                              ? 'Starts at: ${startTime!.format(context)}'
                              : 'Select start time',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        onTap: () async {
                          final picked = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay(hour: 6, minute: 0),
                          );
                          if (picked != null) {
                            setState(() => startTime = picked);
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(Icons.nights_stay_outlined, color: Theme.of(context).iconTheme.color),
                        title: Text(
                          endTime != null
                              ? 'Ends at: ${endTime!.format(context)}'
                              : 'Select end time',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        onTap: () async {
                          final picked = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay(hour: 22, minute: 0),
                          );
                          if (picked != null) {
                            setState(() => endTime = picked);
                          }
                        },
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Cancel'),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () async {
                              if (startTime != null && endTime != null) {
                                final prefs = await SharedPreferences.getInstance();
                                final now = DateTime.now();

                                final startDateTime = DateTime(
                                  now.year,
                                  now.month,
                                  now.day,
                                  startTime!.hour,
                                  startTime!.minute,
                                );

                                final endDateTime = DateTime(
                                  now.year,
                                  now.month,
                                  now.day,
                                  endTime!.hour,
                                  endTime!.minute,
                                );

                                await prefs.setString(
                                  'dayStartTime',
                                  startDateTime.toIso8601String(),
                                );
                                await prefs.setString(
                                  'dayEndTime',
                                  endDateTime.toIso8601String(),
                                );

                                Navigator.of(context).pop();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please select both times.'),
                                  ),
                                );
                              }
                            },
                            child: const Text('Save'),
                          ),
                        ],
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      );
    },
  );
}
