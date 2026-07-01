import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lex_core/features/student/presentation/widgets/student_portal_header.dart';

class _Task {
  final String title;
  final String module;
  final String deadline;
  final bool isCompleted;
  final Color tagColor;
  final Color tagBgColor;

  const _Task({
    required this.title, 
    required this.module, 
    required this.deadline, 
    this.isCompleted = false,
    required this.tagColor,
    required this.tagBgColor,
  });
}

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final List<_Task> _tasks = const [
    _Task(
      title: 'Analyze Precedent: Miranda v. Arizona', 
      module: 'Constitutional Law', 
      deadline: 'Today, 11:59 PM',
      tagColor: Color(0xFFEF4444),
      tagBgColor: Color(0xFFFEF2F2),
    ),
    _Task(
      title: 'Draft Non-Disclosure Agreement (NDA)', 
      module: 'Corporate Law', 
      deadline: 'Tomorrow, 5:00 PM',
      tagColor: Color(0xFF3B82F6),
      tagBgColor: Color(0xFFEFF6FF),
    ),
    _Task(
      title: 'Mock Trial Prep: Opening Statements', 
      module: 'Advocacy Skills', 
      deadline: 'Jun 28, 2026',
      tagColor: Color(0xFFF97316),
      tagBgColor: Color(0xFFFFF7ED),
    ),
    _Task(
      title: 'Review PLD 2021 SC 89 Judgment', 
      module: 'Case Law Analysis', 
      deadline: 'Jul 2, 2026',
      tagColor: Color(0xFF8B5CF6),
      tagBgColor: Color(0xFFF5F3FF),
    ),
    _Task(
      title: 'Submit Dispute Resolution Paper', 
      module: 'Arbitration', 
      deadline: 'Jul 10, 2026',
      tagColor: Color(0xFF14B8A6),
      tagBgColor: Color(0xFFF0FDFA),
    ),
    _Task(
      title: 'Complete Quiz: Criminal Procedure Code', 
      module: 'Criminal Law', 
      deadline: 'Completed', 
      isCompleted: true,
      tagColor: Color(0xFF64748B),
      tagBgColor: Color(0xFFF8FAFC),
    ),
    _Task(
      title: 'Client Counseling Video Submission', 
      module: 'Ethics & Practice', 
      deadline: 'Completed', 
      isCompleted: true,
      tagColor: Color(0xFF64748B),
      tagBgColor: Color(0xFFF8FAFC),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final pending = _tasks.where((t) => !t.isCompleted).toList();
    final completed = _tasks.where((t) => t.isCompleted).toList();
    final progress = completed.length / _tasks.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9), // Matching new dashboard background
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StudentPortalHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Premium Progress Hero Card
                  Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(color: const Color(0xFF0F172A).withOpacity(0.3), blurRadius: 24, offset: const Offset(0, 12)),
                      ],
                    ),
                    child: Row(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 80, height: 80,
                              child: CircularProgressIndicator(
                                value: progress,
                                backgroundColor: Colors.white.withOpacity(0.05),
                                valueColor: const AlwaysStoppedAnimation(Color(0xFF22C55E)),
                                strokeWidth: 10,
                                strokeCap: StrokeCap.round,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(color: const Color(0xFF22C55E).withOpacity(0.2), blurRadius: 10),
                                ],
                              ),
                              child: Text('${(progress * 100).toInt()}%',
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white)),
                            ),
                          ],
                        ),
                        const SizedBox(width: 28),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Weekly Progress', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: -0.5)),
                              const SizedBox(height: 8),
                              Text('${completed.length} out of ${_tasks.length} tasks completed', style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.7))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn().slideY(begin: 0.1),
                  const SizedBox(height: 36),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Pending Tasks', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF0F172A), letterSpacing: -0.5)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE2E8F0),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text('${pending.length}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF475569))),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ...pending.map((t) => _buildTaskCard(t, false)),

                  const SizedBox(height: 40),
                  const Text('Completed', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF0F172A), letterSpacing: -0.5)),
                  const SizedBox(height: 20),
                  ...completed.map((t) => _buildTaskCard(t, true)),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(_Task task, bool completed) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: completed ? const Color(0xFFF8FAFC) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: completed ? const Color(0xFF22C55E).withOpacity(0.3) : Colors.transparent),
        boxShadow: completed ? [] : [
          BoxShadow(
            color: const Color(0xFF0F172A).withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Custom Checkbox
          Container(
            width: 28, height: 28,
            margin: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              color: completed ? const Color(0xFF22C55E) : const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: completed ? const Color(0xFF22C55E) : const Color(0xFFCBD5E1), width: 2),
              boxShadow: completed ? [
                BoxShadow(color: const Color(0xFF22C55E).withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4)),
              ] : [],
            ),
            child: completed ? const Icon(Icons.check_rounded, color: Colors.white, size: 18) : null,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title, 
                  style: TextStyle(
                    fontSize: 16, 
                    fontWeight: FontWeight.w800, 
                    color: completed ? const Color(0xFF94A3B8) : const Color(0xFF0F172A), 
                    decoration: completed ? TextDecoration.lineThrough : null,
                    height: 1.3,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Module Tag
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: task.tagBgColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.menu_book_rounded, size: 14, color: task.tagColor),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                task.module, 
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: task.tagColor),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    
                    // Deadline
                    Row(
                      children: [
                        Icon(Icons.schedule_rounded, size: 16, color: completed ? const Color(0xFF22C55E) : const Color(0xFF64748B)),
                        const SizedBox(width: 6),
                        Text(task.deadline, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: completed ? const Color(0xFF22C55E) : const Color(0xFF64748B))),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideX(begin: 0.1);
  }
}
