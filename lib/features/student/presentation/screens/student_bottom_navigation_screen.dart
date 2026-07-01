import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lex_core/features/student/presentation/providers/bottom_navigation_provider/student_bottom_navigation_provider.dart';
import 'package:lex_core/features/student/presentation/screens/student_dashboard_screen.dart';
import 'package:lex_core/features/student/presentation/screens/certification_screens/certification_screen.dart';
import 'package:lex_core/features/student/presentation/screens/tasks_screen.dart';
import 'package:lex_core/features/student/presentation/screens/research_screen.dart';
import 'package:lex_core/features/student/presentation/screens/student_profile_screen.dart';
import 'package:lex_core/shared/widgets/custom_bottom_navbar.dart';
import 'package:lex_core/shared/widgets/custom_student_drawer.dart';
import 'package:sizer/sizer.dart';

class StudentBottomNavigationScreen extends ConsumerStatefulWidget {
  const StudentBottomNavigationScreen({super.key});

  @override
  ConsumerState<StudentBottomNavigationScreen> createState() =>
      _StudentBottomNavigationScreenState();
}

class _StudentBottomNavigationScreenState
    extends ConsumerState<StudentBottomNavigationScreen> {
  final List<Widget> _screens = [
    const StudentDashboardScreen(),
    const CertificationScreen(),
    const TasksScreen(),
    const ResearchScreen(),
    const StudentProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(studentBottomNavigationProvider);

    return Scaffold(
      drawer: const CustomStudentDrawer(),
      backgroundColor: Colors.white, // unified white background
      extendBody: true, // important for glass effect to show behind
      body: IndexedStack(index: currentIndex, children: _screens),
      bottomNavigationBar: SafeArea(
        top: false,
        child: CustomBottomNavbar(
          currentIndex: currentIndex,
          onTap: (index) => ref
              .read(studentBottomNavigationProvider.notifier)
              .setIndex(index),
          items: [
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.dashboard_rounded),
              icon: Icon(Icons.dashboard_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.school_rounded),
              icon: Icon(Icons.school_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.assignment_rounded),
              icon: Icon(Icons.assignment_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.science_rounded),
              icon: Icon(Icons.science_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.person_rounded),
              icon: Icon(Icons.person_outline_rounded),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
