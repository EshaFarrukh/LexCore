import 'package:flutter/material.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/features/student/data/models/certification_model.dart';
import 'package:lex_core/shared/widgets/custom_button.dart';
import 'package:lex_core/shared/widgets/custom_text.dart';

class CertificationItemWidget extends StatelessWidget {
  final CertificationModel certification;
  final bool isCompleted;
  final VoidCallback? onTap;
  final VoidCallback? onEnroll;

  const CertificationItemWidget({
    super.key,
    required this.certification,
    required this.isCompleted,
    this.onTap,
    this.onEnroll,
  });

  @override
  Widget build(BuildContext context) {
    final levelColor = _getLevelColor(certification.level);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 64, height: 64,
                    decoration: BoxDecoration(
                      color: isCompleted ? const Color(0xFFF0FDF4) : const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Icon(
                        isCompleted ? Icons.workspace_premium_rounded : Icons.school_rounded,
                        color: isCompleted ? const Color(0xFF22C55E) : const Color(0xFF3B82F6),
                        size: 32,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          certification.title,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF0F172A), height: 1.2, letterSpacing: -0.5),
                          maxLines: 2,
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: isCompleted ? const Color(0xFF22C55E).withOpacity(0.1) : levelColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            isCompleted ? "COMPLETED" : certification.level.toUpperCase(),
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: isCompleted ? const Color(0xFF22C55E) : levelColor, letterSpacing: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                certification.description,
                style: const TextStyle(fontSize: 14, color: Color(0xFF64748B), height: 1.5),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(Icons.person_rounded, size: 18, color: Color(0xFF3B82F6)),
                  const SizedBox(width: 8),
                  Text(certification.instructor, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF475569))),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.schedule_rounded, size: 18, color: Color(0xFF3B82F6)),
                  const SizedBox(width: 8),
                  Text(certification.duration, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF64748B))),
                ],
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: certification.skills
                    .take(3)
                    .map((skill) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(skill, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF475569))),
                        ))
                    .toList(),
              ),
              if (!isCompleted) ...[
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onEnroll,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F172A),
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shadowColor: const Color(0xFF0F172A).withOpacity(0.4),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text('Enroll Now', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0.5)),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color _getLevelColor(String level) {
    switch (level.toLowerCase()) {
      case 'beginner':
        return Colors.greenAccent.shade700;
      case 'intermediate':
        return Colors.orangeAccent.shade700;
      case 'advanced':
        return Colors.redAccent.shade700;
      default:
        return const Color(0xFF3B82F6);
    }
  }
}
