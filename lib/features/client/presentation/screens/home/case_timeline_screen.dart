import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/constants/app_typography.dart';
import 'package:timeline_tile/timeline_tile.dart';

class _TimelineEvent {
  final String date;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final bool isCompleted;
  final bool isUpcoming;

  const _TimelineEvent({
    required this.date,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.isCompleted = true,
    this.isUpcoming = false,
  });
}

class CaseTimelineScreen extends StatelessWidget {
  const CaseTimelineScreen({super.key});

  static const List<_TimelineEvent> _events = [
    _TimelineEvent(
      date: 'Jan 12, 2024',
      title: 'Case Filed',
      subtitle: 'Criminal case filed at Lahore Sessions Court. Case registered under Section 420 PPC.',
      icon: Icons.folder_open_rounded,
      color: AppColors.kSuccess,
    ),
    _TimelineEvent(
      date: 'Jan 15, 2024',
      title: 'Lawyer Assigned',
      subtitle: 'Adv. Raza Khan accepted the case and filed a Vakalatnama.',
      icon: Icons.person_add_rounded,
      color: AppColors.kBrandLight,
    ),
    _TimelineEvent(
      date: 'Feb 28, 2024',
      title: 'First Hearing',
      subtitle: 'Initial hearing held. Judge requested additional evidence from prosecution. Next date fixed.',
      icon: Icons.gavel_rounded,
      color: AppColors.kGold,
    ),
    _TimelineEvent(
      date: 'Mar 10, 2024',
      title: 'Evidence Submitted',
      subtitle: '3 documents and 2 witness statements submitted to the court registry.',
      icon: Icons.description_rounded,
      color: AppColors.kGold,
    ),
    _TimelineEvent(
      date: 'Apr 22, 2024',
      title: 'Second Hearing',
      subtitle: 'Cross-examination of prosecution witness completed. Defense arguments scheduled.',
      icon: Icons.gavel_rounded,
      color: AppColors.kGold,
    ),
    _TimelineEvent(
      date: 'Jul 15, 2024',
      title: 'Next Hearing — Defense Arguments',
      subtitle: 'Scheduled at Sessions Court, Court Room 3 at 10:00 AM. Your presence is required.',
      icon: Icons.event_rounded,
      color: AppColors.kBrandLight,
      isCompleted: false,
      isUpcoming: true,
    ),
    _TimelineEvent(
      date: 'TBD',
      title: 'Final Judgment',
      subtitle: 'Pending completion of hearing schedule.',
      icon: Icons.check_circle_outline_rounded,
      color: AppColors.kTextTertiary,
      isCompleted: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBgDeep,
      appBar: AppBar(
        backgroundColor: AppColors.kBgSurface,
        title: Text('Case Timeline', style: AppTypography.h3),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 20, 20, 40),
        child: Column(
          children: List.generate(_events.length, (i) {
            final event = _events[i];
            return TimelineTile(
              alignment: TimelineAlign.manual,
              lineXY: 0.15,
              isFirst: i == 0,
              isLast: i == _events.length - 1,
              indicatorStyle: IndicatorStyle(
                width: 36,
                height: 36,
                indicator: _buildIndicator(event),
              ),
              beforeLineStyle: LineStyle(
                color: i == 0 ? Colors.transparent : (event.isCompleted ? event.color.withValues(alpha: 0.4) : AppColors.kBorder),
                thickness: 2,
              ),
              afterLineStyle: LineStyle(
                color: event.isCompleted && i < _events.length - 1
                    ? _events[i + 1].color.withValues(alpha: 0.4)
                    : AppColors.kBorder,
                thickness: 2,
              ),
              endChild: _buildContent(event),
            ).animate(delay: (i * 120).ms).fadeIn(duration: 400.ms).slideX(begin: 0.1);
          }),
        ),
      ),
    );
  }

  Widget _buildIndicator(_TimelineEvent event) {
    if (event.isUpcoming) {
      return Container(
        decoration: BoxDecoration(
          color: event.color.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: event.color, width: 2),
        ),
        child: Icon(event.icon, size: 16, color: event.color),
      )
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .scaleXY(end: 1.15, duration: 800.ms);
    }

    return Container(
      decoration: BoxDecoration(
        color: event.isCompleted ? event.color : AppColors.kBgElevated,
        borderRadius: BorderRadius.circular(18),
        border: event.isCompleted ? null : Border.all(color: AppColors.kBorder, width: 2),
      ),
      child: Icon(event.icon, size: 16, color: event.isCompleted ? Colors.white : AppColors.kTextTertiary),
    );
  }

  Widget _buildContent(_TimelineEvent event) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 8, 0, 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: event.isUpcoming ? event.color.withValues(alpha: 0.08) : AppColors.kBgSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: event.isUpcoming ? event.color.withValues(alpha: 0.3) : AppColors.kBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (event.isUpcoming)
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: event.color.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text('UPCOMING',
                      style: AppTypography.button.copyWith(
                          fontSize: 9, color: event.color, letterSpacing: 0.5)),
                ),
              Expanded(
                child: Text(event.date,
                    style: AppTypography.caption.copyWith(
                        color: event.isUpcoming ? event.color : AppColors.kTextSecondary, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(event.title, style: AppTypography.h3),
          const SizedBox(height: 4),
          Text(event.subtitle, style: AppTypography.body.copyWith(fontSize: 12, height: 1.4)),
        ],
      ),
    );
  }
}
