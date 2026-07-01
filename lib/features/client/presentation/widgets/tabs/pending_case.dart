import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/constants/app_dimensions.dart';
import 'package:lex_core/core/constants/app_typography.dart';
import 'package:lex_core/features/client/domain/entities/case_entity.dart';
import 'package:lex_core/shared/widgets/lex_button.dart';
import 'package:lex_core/shared/widgets/lex_empty_state.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PendingCasesTab extends StatelessWidget {
  final List<CaseEntity> cases;
  const PendingCasesTab({super.key, required this.cases});

  // ------------------------------------------------------------------
  // Helpers
  // ------------------------------------------------------------------

  /// Format ISO-8601 string to "dd MMM yyyy  •  hh:mm a"
  /// Returns "-" if null or unparsable.
  static String _formatDate(String? raw) {
    if (raw == null || raw.trim().isEmpty) return '-';
    try {
      final dt = DateTime.parse(raw).toLocal();
      return DateFormat('dd MMM yyyy  •  hh:mm a').format(dt);
    } catch (_) {
      return raw;
    }
  }

  /// Return just the year from an ISO-8601 string. Returns "-" if null.
  static String _yearOnly(String? raw) {
    if (raw == null || raw.trim().isEmpty) return '-';
    try {
      return DateTime.parse(raw).year.toString();
    } catch (_) {
      return raw;
    }
  }

  // ------------------------------------------------------------------
  // Bottom-sheet detail
  // ------------------------------------------------------------------
  void _showCaseDetails(BuildContext context, CaseEntity c) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (a) => DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, ctrl) => Container(
          decoration: BoxDecoration(
            color: AppColors.kSurface.withValues(alpha: 0.97),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            border: Border.all(
              color: AppColors.kEmerald.withValues(alpha: 0.18),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.45),
                blurRadius: 32,
                offset: const Offset(0, -8),
              ),
            ],
          ),
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                width: 48,
                height: 5,
                decoration: BoxDecoration(
                  color: AppColors.kEmerald.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: AppDimensions.xl),

              Expanded(
                child: ListView(
                  controller: ctrl,
                  children: [
                    // Title
                    Text(
                      c.title,
                      style: AppTypography.h2,
                      maxLines: 2,
                    ),
                    const SizedBox(height: AppDimensions.xs),

                    Text(
                      "Client: ${c.client}",
                      style: AppTypography.body.copyWith(
                        color: AppColors.kTextSecondary,
                      ),
                    ),

                    if (c.lawyerName != null &&
                        c.lawyerName != 'Not Assigned') ...[
                      const SizedBox(height: AppDimensions.xs),
                      Row(
                        children: [
                          const Icon(
                            Icons.gavel_rounded,
                            color: AppColors.kGold,
                            size: 18,
                          ),
                          const SizedBox(width: AppDimensions.xs),
                          Expanded(
                            child: Text(
                              "Lawyer: ${c.lawyerName}${c.lawyerId != null ? ' (${c.lawyerId})' : ''}",
                              style: AppTypography.body.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.kGoldLight,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: AppDimensions.xxl),

                    // ── Case Details Section ──
                    Text(
                      "Case Details",
                      style: AppTypography.h3.copyWith(
                        color: AppColors.kEmerald,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.md),

                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.kInputBg.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.kEmerald.withValues(alpha: 0.2),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Table(
                          border: TableBorder.all(
                            color: AppColors.kEmerald.withValues(alpha: 0.12),
                            width: 1,
                          ),
                          columnWidths: const {
                            0: IntrinsicColumnWidth(),
                            1: FlexColumnWidth(),
                          },
                          children: [
                            _tableRow("Case ID", c.caseNo, isHeader: true),
                            _tableRow("Court", c.court),
                            _tableRow("Status", c.status),
                            _tableRow(
                              "Appointment",
                              _formatDate(c.hearingDate),
                              valueColor: AppColors.kEmerald,
                            ),
                            if (c.nextHearing != null)
                              _tableRow(
                                "Next Hearing",
                                _formatDate(c.nextHearing),
                                valueColor: AppColors.kGold,
                              ),
                            _tableRow(
                              "Category",
                              c.category,
                              valueColor:
                                  c.category.toLowerCase().contains('criminal')
                                  ? Colors.redAccent
                                  : AppColors.kEmerald,
                            ),
                            if (c.submissionMethod != null)
                              _tableRow("Submission", c.submissionMethod!),
                            if (c.appointmentType != null)
                              _tableRow("Appt. Type", c.appointmentType!),
                            _tableRow("Advocate", (c.advocate != null && c.advocate!.trim().isNotEmpty) ? c.advocate! : 'Not Assigned'),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: AppDimensions.xxxl),

                    // ── Notes Section ──
                    Text(
                      "Notes",
                      style: AppTypography.h3.copyWith(
                        color: AppColors.kEmerald,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.md),

                    c.notes.isEmpty
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppDimensions.lg,
                              horizontal: AppDimensions.lg,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.kInputBg.withValues(alpha: 0.6),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: AppColors.kEmerald.withValues(
                                  alpha: 0.15,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.notes_rounded,
                                  color: AppColors.kEmerald.withValues(
                                    alpha: 0.5,
                                  ),
                                  size: 22,
                                ),
                                const SizedBox(width: AppDimensions.md),
                                Expanded(
                                  child: Text(
                                    "No notes added yet",
                                    style: AppTypography.body.copyWith(
                                      color: AppColors.kTextSecondary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Column(
                            children: c.notes.asMap().entries.map((entry) {
                              final idx = entry.key;
                              final note = entry.value;
                              return Container(
                                margin: EdgeInsets.only(
                                  bottom: idx < c.notes.length - 1 ? AppDimensions.lg : 0,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.kInputBg.withValues(
                                    alpha: 0.85,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: AppColors.kEmerald.withValues(
                                      alpha: 0.2,
                                    ),
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Table(
                                    border: TableBorder.all(
                                      color: AppColors.kEmerald.withValues(
                                        alpha: 0.12,
                                      ),
                                      width: 1,
                                    ),
                                    columnWidths: const {
                                      0: IntrinsicColumnWidth(),
                                      1: FlexColumnWidth(),
                                    },
                                    children: [
                                      _tableRow(
                                        "Note #${idx + 1}",
                                        'Created By: ${note.createdBy ?? "System"}',
                                        isHeader: true,
                                      ),
                                      if (note.createdOn != null)
                                        _tableRow(
                                          "Date",
                                          _formatDate(note.createdOn),
                                        ),
                                      _tableRow("Note", note.notes, maxLines: null),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),

                    const SizedBox(height: AppDimensions.huge),

                    // Close Button
                    LexButton(
                      label: "Close",
                      onPressed: () => context.pop(),
                      style: LexButtonStyle.primary,
                    ),
                    const SizedBox(height: AppDimensions.xxxl),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static TableRow _tableRow(
    String label,
    String value, {
    bool isHeader = false,
    Color? valueColor,
    int? maxLines = 3,
  }) {
    return TableRow(
      decoration: BoxDecoration(
        color: isHeader ? AppColors.kEmerald.withValues(alpha: 0.12) : null,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimensions.md, vertical: AppDimensions.md),
          child: Text(
            label,
            style: AppTypography.caption.copyWith(
              color: isHeader ? AppColors.kEmerald : AppColors.kTextSecondary,
              fontWeight: isHeader ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimensions.md, vertical: AppDimensions.md),
          child: Text(
            value,
            style: AppTypography.body.copyWith(
              color: valueColor ?? AppColors.kTextPrimary,
              fontWeight: FontWeight.w600,
            ),
            maxLines: maxLines,
            overflow: maxLines != null ? TextOverflow.ellipsis : null,
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------------
  // Build
  // ------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    if (cases.isEmpty) {
      return const LexEmptyState(
        icon: Icons.hourglass_empty_rounded,
        title: 'No pending cases',
        subtitle: 'New matters assigned to you will appear here',
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 16, bottom: 24),
      itemCount: cases.length,
      itemBuilder: (ctx, i) {
        final c = cases[i];
        
        final isCriminal = c.category.toLowerCase().contains('criminal');
        final isCorporate = c.category.toLowerCase().contains('corporate');
        final isFamily = c.category.toLowerCase().contains('family');

        Color categoryColor = const Color(0xFF3B82F6); // Blue
        Color categoryBg = const Color(0xFFEFF6FF);
        IconData categoryIcon = Icons.gavel_rounded;

        if (isCriminal) {
          categoryColor = const Color(0xFFEF4444); // Red
          categoryBg = const Color(0xFFFEF2F2);
          categoryIcon = Icons.local_police_rounded;
        } else if (isCorporate) {
          categoryColor = const Color(0xFF8B5CF6); // Purple
          categoryBg = const Color(0xFFF5F3FF);
          categoryIcon = Icons.business_center_rounded;
        } else if (isFamily) {
          categoryColor = const Color(0xFFF59E0B); // Amber
          categoryBg = const Color(0xFFFFFBEB);
          categoryIcon = Icons.family_restroom_rounded;
        }

        final hearingLabel = c.hearingDate != null
            ? DateFormat('dd MMM, yyyy').format(
                DateTime.tryParse(c.hearingDate!)?.toLocal() ?? DateTime.now(),
              )
            : 'TBD';

        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0F172A).withValues(alpha: 0.04),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _showCaseDetails(context, c),
                borderRadius: BorderRadius.circular(24),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Row: Category Tag and Case No
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: categoryBg,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(categoryIcon, size: 14, color: categoryColor),
                                const SizedBox(width: 6),
                                Flexible(
                                  child: Text(
                                    c.category.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.5,
                                      color: categoryColor,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Text(
                              c.caseNo.isNotEmpty ? 'ID: ${c.caseNo}' : '',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF94A3B8),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      // Case Title
                      Text(
                        c.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F172A),
                          letterSpacing: -0.5,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      
                      // Court Row
                      Row(
                        children: [
                          const Icon(Icons.account_balance_rounded, size: 16, color: Color(0xFF64748B)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              c.court,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF64748B),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Divider(color: Color(0xFFF1F5F9), height: 1, thickness: 1.5),
                      ),
                      
                      // Bottom Row: Date and Action
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF8FAFC),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(Icons.event_rounded, size: 20, color: Color(0xFF475569)),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Next Hearing",
                                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF94A3B8)),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        hearingLabel,
                                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF0F172A)),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0F172A),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              "Details",
                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),
        );
      },
    );
  }
}
