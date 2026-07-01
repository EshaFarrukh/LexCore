import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lex_core/app/router/route_names.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/constants/app_typography.dart';
import 'package:lex_core/core/database/hive_service.dart';
import 'package:lex_core/features/client/domain/entities/case_entity.dart';
import 'package:lex_core/features/client/presentation/providers/client_cases_provider/client_case_provider.dart';
import 'package:lex_core/features/client/presentation/widgets/tabs/dispose_case_tab.dart';
import 'package:lex_core/features/client/presentation/widgets/tabs/donation_tab.dart';
import 'package:lex_core/features/client/presentation/widgets/tabs/new_case_tab.dart';
import 'package:lex_core/features/client/presentation/widgets/tabs/pending_case.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedTab = 0;
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(caseControllerProvider.notifier).getAllCases());
  }

  @override
  Widget build(BuildContext context) {
    final caseState = ref.watch(caseControllerProvider);
    final name = HiveService.getUserName()?.split(' ').first ?? 'James';

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 32, top: 60),
            decoration: const BoxDecoration(
              color: Color(0xFF0F172A),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
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
                            backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/55.jpg'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('CLIENT PORTAL', 
                              style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.7), fontWeight: FontWeight.w700, letterSpacing: 1.2)
                            ),
                            const SizedBox(height: 2),
                            Text('James Carter', 
                              style: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w800, letterSpacing: -0.5)
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => context.push(RouteNames.notificationScreen),
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
                          onTap: () => Scaffold.of(context).openDrawer(),
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                            ),
                            child: const Icon(Icons.menu_rounded, color: Colors.white, size: 24),
                          ),
                        ),
                      ],
                    ),
                  ],
                ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.1),
                const SizedBox(height: 32),

                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: TextField(
                    onChanged: (v) => setState(() => _searchQuery = v),
                    style: const TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      hintText: 'Search lawyers, cases, courts...',
                      hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 15),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 16, right: 8),
                        child: Icon(Icons.search_rounded, color: Color(0xFF64748B), size: 22),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    ),
                  ),
                ).animate().fadeIn(delay: 100.ms).slideY(begin: -0.1),
              ],
            ),
          ),
          
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => ref.read(caseControllerProvider.notifier).getAllCases(),
              color: const Color(0xFF3B82F6),
              backgroundColor: Colors.white,
              child: CustomScrollView(
                slivers: [

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Quick Actions",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF0F172A)),
                      ).animate().fadeIn(),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _quickAction(Icons.person_search_rounded, 'Lawyers', () => context.push(RouteNames.searchScreen), const Color(0xFFEFF6FF), const Color(0xFF3B82F6)),
                          _quickAction(Icons.account_balance_rounded, 'Courts', () => context.push(RouteNames.courtMapScreen), const Color(0xFFFEF2F2), const Color(0xFFEF4444)),
                          _quickAction(Icons.timeline_rounded, 'Timeline', () => context.push(RouteNames.caseTimelineScreen), const Color(0xFFF0FDF4), const Color(0xFF22C55E)),
                          _quickAction(Icons.article_rounded, 'News', () => context.push(RouteNames.legalNewsScreen), const Color(0xFFFFF7ED), const Color(0xFFF97316)),
                        ],
                      ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.1),
                      const SizedBox(height: 40),

                      // Tabs
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        clipBehavior: Clip.none,
                        child: Row(
                          children: [
                            _tabBtn('Active Cases', 0),
                            const SizedBox(width: 12),
                            _tabBtn('New Matter', 1),
                            const SizedBox(width: 12),
                            _tabBtn('History', 2),
                          ],
                        ),
                      ).animate(delay: 300.ms).fadeIn(),
                    ],
                  ),
                ),
              ),

              // Content Area
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: caseState.when(
                  initial: () => const SliverToBoxAdapter(child: SizedBox()),
                  loading: () => const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(40),
                      child: Center(child: CircularProgressIndicator(color: Color(0xFF3B82F6))),
                    ),
                  ),
                  failure: (err) => SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Center(
                        child: Column(
                          children: [
                            const Icon(Icons.error_outline_rounded, color: Color(0xFFEF4444), size: 48),
                            const SizedBox(height: 16),
                            const Text('Failed to load cases', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF0F172A))),
                            const SizedBox(height: 8),
                            Text(err, style: const TextStyle(fontSize: 14, color: Color(0xFF64748B)), textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                    ),
                  ),
                  success: (data) {
                    final filtered = data.pendingCases.where((c) =>
                        c.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                        c.caseNo.toLowerCase().contains(_searchQuery.toLowerCase())).toList();

                    Widget content;
                    switch (_selectedTab) {
                      case 0: content = PendingCasesTab(cases: filtered, key: const ValueKey(0)); break;
                      case 1: content = const NewCaseTab(key: ValueKey(1)); break;
                      case 2: content = DisposedCasesTab(cases: data.disposedCases, key: const ValueKey(2)); break;
                      default: content = const SizedBox();
                    }

                    return SliverToBoxAdapter(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: content,
                      ),
                    );
                  },
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 120)),
            ],
          ),
        ),
      ),
      ],
      ),
    );
  }

  Widget _quickAction(IconData icon, String label, VoidCallback onTap, Color bgColor, Color iconColor) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          Container(
            width: 64, height: 64,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE2E8F0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: bgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(label, style: const TextStyle(fontSize: 13, color: Color(0xFF475569), fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _tabBtn(String label, int index) {
    final active = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF3B82F6) : Colors.white,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: active ? const Color(0xFF3B82F6) : const Color(0xFFE2E8F0)),
          boxShadow: active ? [
            BoxShadow(
              color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            )
          ] : null,
        ),
        child: Center(
          child: Text(label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: active ? Colors.white : const Color(0xFF64748B),
              )),
        ),
      ),
    );
  }
}
