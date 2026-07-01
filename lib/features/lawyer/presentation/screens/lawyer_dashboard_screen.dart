import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/constants/app_typography.dart';
import 'package:lex_core/core/database/hive_service.dart';
import 'package:lex_core/features/lawyer/domain/entities/lawyer_case_entity.dart';
import 'package:lex_core/features/lawyer/presentation/providers/lawyer_cases_provider/lawyer_case_provider.dart';
import 'package:lex_core/features/lawyer/presentation/states/case_states/lawyer_case_states.dart';
import 'package:lex_core/features/lawyer/presentation/widgets/dashboard_widgets/disposed_case_tab.dart';
import 'package:lex_core/features/lawyer/presentation/widgets/dashboard_widgets/pending_case_tab.dart';
import 'package:intl/intl.dart';

class LawyerDashboardScreen extends ConsumerStatefulWidget {
  const LawyerDashboardScreen({super.key});

  @override
  ConsumerState<LawyerDashboardScreen> createState() => _LawyerDashboardScreenState();
}

class _LawyerDashboardScreenState extends ConsumerState<LawyerDashboardScreen> {
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(lawyerCaseControllerProvider.notifier).getAllCases());
  }

  @override
  Widget build(BuildContext context) {
    final caseState = ref.watch(lawyerCaseControllerProvider);
    
    // Fix name per user request
    String name = HiveService.getUserName()?.split(' ').first ?? 'Esha';
    if (name.toLowerCase() == 'ayesha') name = 'Esha';

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9), // Deep cool grey for premium feel
      body: Column(
        children: [
          // Premium Dark Gradient Header spanning into Next Hearing
          Container(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 40, top: 60),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(36), bottomRight: Radius.circular(36)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hello, $name', 
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -1,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Text('Here is your legal practice overview', 
                            style: TextStyle(
                              color: const Color(0xFF94A3B8),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.08),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white.withOpacity(0.12)),
                          ),
                          child: const Icon(Icons.notifications_outlined, color: Colors.white, size: 24),
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
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.08),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white.withOpacity(0.12)),
                            ),
                            child: const Icon(Icons.menu_rounded, color: Colors.white, size: 24),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                _buildNextHearingCard(caseState),
              ],
            ),
          ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.1),
          
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => ref.read(lawyerCaseControllerProvider.notifier).getAllCases(),
              color: const Color(0xFF3B82F6),
              backgroundColor: Colors.white,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Stats Header
                          Text('Case Overview', 
                            style: const TextStyle(
                              fontSize: 20, 
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0F172A),
                              letterSpacing: -0.5,
                            )
                          ).animate(delay: 150.ms).fadeIn(),
                          const SizedBox(height: 16),

                          // Bento Box Stats
                          _buildStats(caseState).animate(delay: 200.ms).fadeIn().slideY(begin: 0.1),
                          const SizedBox(height: 36),

                          // Fluid Segmented Tabs
                          Container(
                            height: 52,
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE2E8F0).withOpacity(0.8), 
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                Expanded(child: _tabBtn('Pending', 0)),
                                Expanded(child: _tabBtn('Disposed', 1)),
                              ],
                            ),
                          ).animate(delay: 300.ms).fadeIn(),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                  
                  // Case List
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    sliver: _buildCaseList(caseState),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 120)), // Space for bottom nav
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabBtn(String label, int index) {
    final active = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          color: active ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: active ? [
            BoxShadow(
              color: const Color(0xFF0F172A).withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            )
          ] : [],
        ),
        child: Center(
          child: Text(label,
            style: TextStyle(
              color: active ? const Color(0xFF0F172A) : const Color(0xFF64748B),
              fontWeight: active ? FontWeight.w800 : FontWeight.w600,
              fontSize: 15,
            )
          ),
        ),
      ),
    );
  }

  Widget _buildNextHearingCard(LawyerCaseStates state) {
    String title = "No Upcoming Hearings";
    String subtitle = "Your schedule is completely clear.";
    bool hasHearing = false;

    if (state is LawyerCaseSuccessState) {
      LawyerCaseEntity? nextCase;
      for (final c in state.data.pendingCases) {
        if (c.hearingDate != null && c.hearingDate!.isNotEmpty) {
          nextCase = c;
          break;
        }
      }
      if (nextCase != null) {
        title = nextCase.title;
        final rawDate = nextCase.hearingDate!;
        String fDate = rawDate;
        try {
          fDate = DateFormat('dd MMM yyyy • hh:mm a').format(DateTime.parse(rawDate));
        } catch (_) {}
        subtitle = "$fDate • ${nextCase.court}";
        hasHearing = true;
      }
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: hasHearing ? [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.2),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ] : [],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: hasHearing ? const Color(0xFF3B82F6).withOpacity(0.2) : Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: hasHearing ? const Color(0xFF3B82F6).withOpacity(0.5) : Colors.transparent),
            ),
            child: Icon(
              hasHearing ? Icons.gavel_rounded : Icons.event_available_rounded, 
              color: hasHearing ? const Color(0xFF60A5FA) : Colors.white70, 
              size: 28,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(hasHearing ? "Next Hearing" : "Schedule Clear",
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, 
                        color: Color(0xFF94A3B8), 
                        letterSpacing: 1,
                        fontSize: 12,
                    )),
                const SizedBox(height: 6),
                Text(title,
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    )),
                const SizedBox(height: 4),
                Text(subtitle,
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFFCBD5E1),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStats(LawyerCaseStates state) {
    int total = 0;
    int pending = 0;
    int disposed = 0;

    if (state is LawyerCaseSuccessState) {
      pending = state.data.pendingCases.length;
      disposed = state.data.disposedCases.length;
      total = pending + disposed;
    }

    return Row(
      children: [
        _statCard('Total', total.toString(), Icons.folder_open_rounded, const Color(0xFF3B82F6), const Color(0xFFEFF6FF)),
        const SizedBox(width: 12),
        _statCard('Pending', pending.toString(), Icons.pending_actions_rounded, const Color(0xFFF59E0B), const Color(0xFFFFF7ED)),
        const SizedBox(width: 12),
        _statCard('Disposed', disposed.toString(), Icons.task_alt_rounded, const Color(0xFF10B981), const Color(0xFFF0FDF4)),
      ],
    );
  }

  Widget _statCard(String label, String value, IconData icon, Color accentColor, Color bgColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(color: const Color(0xFF0F172A).withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 8)),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: accentColor, size: 24),
            ),
            const SizedBox(height: 16),
            Text(value, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 28, fontWeight: FontWeight.w900, height: 1.1)),
            const SizedBox(height: 6),
            Text(
              label, 
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF64748B), 
                fontWeight: FontWeight.w700, 
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCaseList(LawyerCaseStates state) {
    return state.when(
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
                const Icon(Icons.error_outline_rounded, color: Colors.redAccent, size: 48),
                const SizedBox(height: 16),
                const Text('Failed to load cases', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Text(err, style: const TextStyle(color: Color(0xFF64748B)), textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
      success: (data) => SliverToBoxAdapter(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _selectedTab == 0
              ? PendingLawyerCasesTab(key: const ValueKey('pending'), cases: data.pendingCases)
              : DisposedLawyerCasesTab(key: const ValueKey('disposed'), cases: data.disposedCases),
        ),
      ),
    );
  }
}
