import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoScreen extends ConsumerStatefulWidget {
  const VideoScreen({super.key});

  @override
  ConsumerState<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends ConsumerState<VideoScreen> {
  @override
  Widget build(BuildContext context) {
    // We will show a mock active video call for the client
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          "Video Consultations",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            color: Color(0xFF0F172A),
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
                color: const Color(0xFFF8FAFC),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: const Icon(Icons.menu_rounded, color: Color(0xFF475569), size: 24),
            ),
          ),
        ],
      ),
      body: _buildVideoList(context),
    );
  }

  Widget _buildVideoList(BuildContext context) {
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
                  child: _buildVideoCard(
                    context, 
                    "Ayesha Khan", 
                    "Today, 04:00 PM", 
                    'https://randomuser.me/api/portraits/women/44.jpg'
                  ),
                );
              },
              childCount: 1, // Show 1 scheduled call
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
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
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
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2563EB),
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
                // context.push('/video-call');
              },
            ),
          ),
        ],
      ),
    );
  }
}
