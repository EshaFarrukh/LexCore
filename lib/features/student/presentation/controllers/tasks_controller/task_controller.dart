import 'dart:developer';

import 'package:flutter_riverpod/legacy.dart';
import 'package:lex_core/core/constants/app_keys.dart';
import 'package:lex_core/core/utils/storage/storage_service.dart';
import 'package:lex_core/di/injection_container.dart';
import 'package:lex_core/features/student/data/models/task_model.dart';
import 'package:lex_core/features/student/domain/usecases/student_usecases.dart';
import 'package:lex_core/features/student/presentation/states/task_states.dart';

class TaskController extends StateNotifier<TaskStates> {
  final GetTasksUseCase _getTasksUseCase;

  TaskController({GetTasksUseCase? getTasksUseCase})
      : _getTasksUseCase = getTasksUseCase ?? sl<GetTasksUseCase>(),
        super(TaskInitialState());

  Future<void> getAllTasks() async {
    state = TaskLoadingState();
    try {
      final String? userId = await StorageService.instance.read(AppKeys.userIdKey);
      if (userId == null || userId.isEmpty) {
        state = TaskFailureState(error: "User not logged in");
        return;
      }

      final tasks = await _getTasksUseCase.execute(userId);

      final activeList = tasks.where((t) => !t.isCompleted).toList();
      final completedList = tasks.where((t) => t.isCompleted).toList();

      final allTasks = AllTasksResponse(
        activeTasks: activeList,
        completedTasks: completedList,
      );

      state = TaskSuccessState(data: allTasks);
    } catch (e, stack) {
      log('Get All Tasks -> Error: $e\n$stack');
      state = TaskFailureState(error: 'Unable to load tasks data');
    }
  }

  Future<void> markTaskAsComplete(String taskId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      if (state is TaskSuccessState) {
        final currentData = (state as TaskSuccessState).data;
        final activeTasks = List<TaskModel>.from(currentData.activeTasks);
        final completedTasks = List<TaskModel>.from(currentData.completedTasks);

        final taskToComplete = activeTasks.firstWhere(
          (task) => task.id == taskId,
          orElse: () => throw Exception('Task not found'),
        );

        // Move task from active to completed
        final completedTask = TaskModel(
          id: taskToComplete.id,
          title: taskToComplete.title,
          description: taskToComplete.description,
          category: taskToComplete.category,
          dueDate: taskToComplete.dueDate,
          isCompleted: true,
          priority: taskToComplete.priority,
        );

        activeTasks.removeWhere((task) => task.id == taskId);
        completedTasks.add(completedTask);

        final updatedData = AllTasksResponse(
          activeTasks: activeTasks,
          completedTasks: completedTasks,
        );

        state = TaskSuccessState(data: updatedData);
      }
    } catch (e, stack) {
      log('Mark Task Complete â†’ Error: $e\n$stack');
      state = TaskFailureState(error: 'Failed to update task status');
    }
  }

  Future<void> refreshTasks() async {
    await getAllTasks();
  }
}

