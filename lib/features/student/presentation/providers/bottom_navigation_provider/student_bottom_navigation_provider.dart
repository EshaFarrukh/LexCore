import 'package:flutter_riverpod/legacy.dart';
import 'package:lex_core/features/student/presentation/controllers/bottom_navigation_controller/student_bottom_navigation_controller.dart';

final studentBottomNavigationProvider =
    StateNotifierProvider<StudentBottomNavigationController, int>((ref) {
      return StudentBottomNavigationController();
    });

