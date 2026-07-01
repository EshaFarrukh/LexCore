import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lex_core/core/database/hive_service.dart';

class StudentPortalHeader extends StatelessWidget {
  final bool bottomRadius;
  const StudentPortalHeader({super.key, this.bottomRadius = true});

  @override
  Widget build(BuildContext context) {
    final name = HiveService.getUserName()?.split(' ').first ?? 'Esha';

    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 32, top: 60), // Top padding accounts for status bar
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: bottomRadius ? const BorderRadius.only(bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)) : BorderRadius.zero,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 2),
                ),
                child: const CircleAvatar(
                  radius: 22,
                  backgroundImage: NetworkImage('https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=300&q=80'),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('STUDENT PORTAL', 
                    style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8), fontWeight: FontWeight.w700, letterSpacing: 1.2)
                  ),
                  const SizedBox(height: 2),
                  Text(name, 
                    style: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w800, letterSpacing: -0.5)
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {}, // context.push(RouteNames.notificationScreen)
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                  ),
                  child: const Icon(Icons.notifications_none_rounded, color: Colors.white, size: 22),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  ScaffoldState? scaffold = Scaffold.maybeOf(context);
                  if (scaffold != null && scaffold.hasDrawer) {
                    scaffold.openDrawer();
                  } else {
                    context.visitAncestorElements((element) {
                      if (element.widget is Scaffold) {
                        final scaffoldWidget = element.widget as Scaffold;
                        if (scaffoldWidget.drawer != null) {
                          final state = (element as StatefulElement).state as ScaffoldState;
                          state.openDrawer();
                          return false;
                        }
                      }
                      return true;
                    });
                  }
                },
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: const Icon(Icons.menu_rounded, color: Colors.white, size: 24),
                ),
              ),
            ],
          ),
        ],
      ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.1),
    );
  }
}
