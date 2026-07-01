import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/constants/app_dimensions.dart';
import 'package:lex_core/core/constants/app_typography.dart';
import 'package:lex_core/features/client/domain/entities/case_entity.dart';
import 'package:lex_core/shared/widgets/lex_empty_state.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DisposedCasesTab extends StatelessWidget {
  final List<CaseEntity> cases;
  const DisposedCasesTab({super.key, required this.cases});

  @override
  Widget build(BuildContext context) {
    if (cases.isEmpty) {
      return const LexEmptyState(
        icon: Icons.history_rounded,
        title: "No disposed cases",
        subtitle: "Your past and resolved cases will appear here",
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 16, bottom: 24),
      itemCount: cases.length,
      itemBuilder: (_, i) {
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

                  if (c.lawyerName != null && c.lawyerName != 'Not Assigned') ...[
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.gavel_rounded, size: 16, color: Color(0xFF64748B)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "Lawyer: ${c.lawyerName}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF475569),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],

                  if (c.outcome != null) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.info_outline_rounded, size: 16, color: Color(0xFF64748B)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              c.outcome!,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF475569),
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  
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
                                color: const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.check_circle_rounded, size: 20, color: Color(0xFF10B981)), // Emerald check
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Disposed On",
                                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF94A3B8)),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    c.disposedDate ?? '-',
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
                          color: const Color(0xFFF8FAFC),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          "Resolved",
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF64748B)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),
        );
      },
    );
  }
}
