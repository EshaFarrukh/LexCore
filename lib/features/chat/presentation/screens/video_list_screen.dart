import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/constants/app_typography.dart';
import 'package:lex_core/features/chat/presentation/providers/chat_availability_provider.dart';

class VideoListScreen extends ConsumerWidget {
  const VideoListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final availabilityAsync = ref.watch(chatAvailabilityProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text(
          "Video Consultations",
          style: AppTypography.h1.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            color: Colors.white,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: Container(
              width: 44,
              height: 44,
              margin: const EdgeInsets.only(right: 16),
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
      body: availabilityAsync.when(
        data: (hasCases) {
          if (!hasCases) {
            return Column(
              children: [
                Container(
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Color(0xFF0F172A),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
                  ),
                ),
                Expanded(child: _buildEmptyState(context)),
              ],
            );
          }
          return Column(
            children: [
              Container(
                height: 32,
                decoration: const BoxDecoration(
                  color: Color(0xFF0F172A),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
                ),
              ),
              Expanded(child: _buildVideoList(context)),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.kBrand)),
        error: (err, stack) => const Center(child: Text("Error loading video availability", style: TextStyle(color: Colors.red))),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Color(0xFFF1F5F9),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.videocam_off_outlined, size: 64, color: Color(0xFF94A3B8)),
            ),
            const SizedBox(height: 24),
            Text(
              "No Scheduled Calls",
              style: AppTypography.h3.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              "Video calling will be enabled once you have an active case or a confirmed appointment.",
              style: AppTypography.body.copyWith(
                fontSize: 16,
                color: const Color(0xFF64748B),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoList(BuildContext context) {
    // Mock video call list
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(24),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildVideoCard(context, "Zayahan Hasan", "Today, 04:00 PM", 'https://i.pravatar.cc/150?u=u1'),
                );
              },
              childCount: 2,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 120)), // Space for bottom nav
      ],
    );
  }

  Widget _buildVideoCard(BuildContext context, String name, String time, String avatarUrl) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFF1F5F9), width: 2),
            ),
            child: CircleAvatar(
              radius: 28,
              backgroundColor: const Color(0xFFE2E8F0),
              backgroundImage: NetworkImage(avatarUrl),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTypography.h3.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.access_time_rounded, size: 14, color: Color(0xFF3B82F6)),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          time,
                          style: AppTypography.caption.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF2563EB),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF3B82F6),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.videocam_rounded, color: Colors.white, size: 24),
              onPressed: () {
                context.push('/video-call');
              },
            ),
          ),
        ],
      ),
    );
  }
}
