import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/constants/app_dimensions.dart';
import 'package:lex_core/core/constants/app_typography.dart';
import 'package:lex_core/features/lawyer/domain/entities/lawyer_case_entity.dart';
import 'package:lex_core/shared/widgets/lex_button.dart';
import 'package:lex_core/shared/widgets/lex_empty_state.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DisposedLawyerCasesTab extends StatelessWidget {
  final List<LawyerCaseEntity> cases;

  const DisposedLawyerCasesTab({super.key, required this.cases});

  @override
  Widget build(BuildContext context) {
    if (cases.isEmpty) {
      return const LexEmptyState(
        icon: Icons.check_circle_outline_rounded,
        title: 'No disposed cases yet',
        subtitle: 'Completed matters will appear here',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.lg, vertical: AppDimensions.sm),
      itemCount: cases.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, i) {
        final c = cases[i];

        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC), // Very soft slate
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFE2E8F0)),
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: Text(
                              c.caseNo.split('/').last,
                              style: const TextStyle(
                                color: Color(0xFF94A3B8),
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFDCFCE7),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.check_circle_rounded, size: 14, color: Color(0xFF16A34A)),
                                const SizedBox(width: 4),
                                const Text(
                                  'Disposed',
                                  style: TextStyle(
                                    color: Color(0xFF16A34A),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        c.title,
                        style: const TextStyle(
                          color: Color(0xFF475569),
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Color(0xFFCBD5E1),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.person_outline_rounded, size: 16, color: Color(0xFF94A3B8)),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              c.client,
                              style: const TextStyle(
                                color: Color(0xFF64748B),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Divider(color: Color(0xFFE2E8F0), height: 1),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Closed on: ${c.disposedDate != null ? _formatDateOnly(c.disposedDate!) : '-'}',
                            style: const TextStyle(
                              color: Color(0xFF94A3B8),
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Color(0xFFCBD5E1)),
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

  static String _formatDate(String? raw) {
    if (raw == null || raw.trim().isEmpty) return '-';
    try {
      final dt = DateTime.parse(raw).toLocal();
      return DateFormat('dd MMM yyyy  •  hh:mm a').format(dt);
    } catch (_) {
      return raw;
    }
  }

  static String _formatDateOnly(String raw) {
    try {
      final dt = DateTime.parse(raw).toLocal();
      return DateFormat('dd MMM yyyy').format(dt);
    } catch (_) {
      return raw;
    }
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

  void _showCaseDetails(BuildContext context, LawyerCaseEntity c) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (a) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, ctrl) => Container(
          decoration: BoxDecoration(
            color: AppColors.kSurface.withValues(alpha: 0.97),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            border: Border.all(color: AppColors.kEmerald.withValues(alpha: 0.18)),
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
                        border: Border.all(color: AppColors.kEmerald.withValues(alpha: 0.2)),
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
                              "Category",
                              c.category,
                              valueColor: c.category.toLowerCase().contains('criminal')
                                  ? Colors.redAccent
                                  : AppColors.kEmerald,
                            ),
                            _tableRow(
                              "Disposed Date",
                              _formatDate(c.disposedDate),
                              valueColor: AppColors.kEmerald,
                            ),
                            if (c.outcomeSummary != null)
                              _tableRow("Outcome", c.outcomeSummary!),
                            _tableRow("Advocate", (c.advocate != null && c.advocate!.trim().isNotEmpty) ? c.advocate! : 'Not Assigned'),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: AppDimensions.xxxl),

                    // ── Documents Section ──
                    Text(
                      "Documents",
                      style: AppTypography.h3.copyWith(
                        color: AppColors.kEmerald,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.md),

                    c.documents.isEmpty
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: AppDimensions.lg, horizontal: AppDimensions.lg),
                            decoration: BoxDecoration(
                              color: AppColors.kInputBg.withValues(alpha: 0.6),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  color: AppColors.kEmerald
                                      .withValues(alpha: 0.15)),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.description_rounded,
                                  color: AppColors.kEmerald
                                      .withValues(alpha: 0.5),
                                  size: 22,
                                ),
                                const SizedBox(width: AppDimensions.md),
                                Expanded(
                                  child: Text(
                                    "No documents uploaded",
                                    style: AppTypography.body.copyWith(
                                      color: AppColors.kTextSecondary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Column(
                            children: c.documents.map((doc) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: AppDimensions.sm),
                                child: Container(
                                  padding: const EdgeInsets.all(AppDimensions.md),
                                  decoration: BoxDecoration(
                                    color: AppColors.kInputBg.withValues(alpha: 0.85),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: AppColors.kEmerald.withValues(alpha: 0.2),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.insert_drive_file_rounded,
                                        color: AppColors.kTextSecondary,
                                        size: 24,
                                      ),
                                      const SizedBox(width: AppDimensions.md),
                                      Expanded(
                                        child: Text(
                                          doc,
                                          style: AppTypography.body.copyWith(
                                            color: AppColors.kTextPrimary,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.visibility_rounded,
                                        color: AppColors.kEmerald,
                                        size: 22,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
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
                                vertical: AppDimensions.lg, horizontal: AppDimensions.lg),
                            decoration: BoxDecoration(
                              color: AppColors.kInputBg.withValues(alpha: 0.6),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  color: AppColors.kEmerald
                                      .withValues(alpha: 0.15)),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.notes_rounded,
                                  color: AppColors.kEmerald
                                      .withValues(alpha: 0.5),
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
                                margin: EdgeInsets.only(bottom: idx < c.notes.length - 1 ? AppDimensions.lg : 0),
                                decoration: BoxDecoration(
                                  color: AppColors.kInputBg.withValues(alpha: 0.85),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: AppColors.kEmerald.withValues(alpha: 0.2)),
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
                                      _tableRow("Note #${idx + 1}", note.createdBy ?? "System", isHeader: true),
                                      if (note.createdOn != null)
                                        _tableRow("Date", _formatDate(note.createdOn)),
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
                      onPressed: () => Navigator.pop(context),
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
}
