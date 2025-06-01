import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_tracker/models/task.dart';

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]) {
    loadTask();
  }
  void loadTask() {
    final box = Hive.box<Task>('task');
    state = box.values.toList();
  }

  void addTask(Task task) {
    final box = Hive.box<Task>('task');
    box.add(task);
    state = [...state, task];
  }

  void deleteTask(int index) {
    final box = Hive.box<Task>('task');
    box.deleteAt(index);
    state = [...state]..removeAt(index);
  }
}

final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  return TaskNotifier();
});
