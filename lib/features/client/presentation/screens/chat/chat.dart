import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/constants/app_typography.dart';
import 'package:lex_core/features/client/presentation/controllers/chat_controller.dart';
import 'package:sizer/sizer.dart';

class ChatDetailScreen extends ConsumerWidget {
  const ChatDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lawyer = ref.watch(selectedLawyerProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.kBrandLight.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.kBrandLight,
            ),
          ),
          onPressed: () => context.pop(),
        ),
        title: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.kBrandLight, width: 2.5),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.kBrandLight.withValues(alpha: 0.25),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ClipOval(
                child: SizedBox(
                  width: 4.h,
                  height: 4.h,
                  child: CachedNetworkImage(
                    imageUrl: lawyer?.profilePhoto ?? '',
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: AppColors.kBgSurface,
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.kBrandLight.withValues(alpha: 0.6),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: AppColors.kBgSurface,
                      child: Icon(
                        Icons.person_rounded,
                        color: AppColors.kTextSecondary,
                        size: 3.h,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 3.5.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${lawyer?.firstName ?? ''} ${lawyer?.lastName ?? ''}'.trim(),
                    style: AppTypography.h3,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 0.3.h),
                  Row(
                    children: [
                      Container(
                        width: 2.w,
                        height: 2.w,
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.greenAccent.withValues(alpha: 0.5),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'Online',
                        style: AppTypography.caption.copyWith(color: Colors.greenAccent),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Container(
              padding: EdgeInsets.all(1.h),
              decoration: BoxDecoration(
                color: AppColors.kBrandLight.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.call_rounded, color: AppColors.kBrandLight),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Container(
              padding: EdgeInsets.all(1.h),
              decoration: BoxDecoration(
                color: AppColors.kBrandLight.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.more_vert_rounded,
                color: AppColors.kBrandLight,
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),

      body: Container(
        color: AppColors.kBgDeep,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.fromLTRB(
                    5.w,
                    kToolbarHeight + 16,
                    5.w,
                    2.h,
                  ),
                  reverse: true, // New messages appear at the bottom
                  children: [
                    _buildDateHeader('Today'),
                    _buildReceivedMessage(
                      'Hi! I saw your profile and I need help with a family law case.',
                      '10:30 AM',
                    ),
                    _buildSentMessage(
                      'Hello! Sure, I can help. Could you tell me more about the case?',
                      '10:32 AM',
                    ),
                    _buildReceivedMessage(
                      'Yes, it’s about child custody after divorce.',
                      '10:33 AM',
                    ),
                    _buildSentMessage(
                      'Got it. I specialize in family law. Let’s schedule a call.',
                      '10:35 AM',
                    ),
                  ],
                ),
              ),

              // Input area (fixed at bottom)
              _buildInputArea(),
            ],
          ),
        ),
      ),
    );
  }

  // Date header
  Widget _buildDateHeader(String date) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 2.5.h),
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: AppColors.kBgSurface.withValues(alpha: 0.88),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.kBrandLight.withValues(alpha: 0.15)),
        ),
        child: Text(
          date,
          style: AppTypography.caption,
        ),
      ),
    );
  }

  // Received message (lawyer → left side, dark bubble)
  Widget _buildReceivedMessage(String text, String time) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 2.h, right: 20.w),
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.5.h),
        decoration: BoxDecoration(
          color: AppColors.kBgSurface.withValues(alpha: 0.94),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          border: Border.all(color: AppColors.kBrandLight.withValues(alpha: 0.12)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: AppTypography.body,
            ),
            SizedBox(height: 0.6.h),
            Text(
              time,
              style: AppTypography.caption,
            ),
          ],
        ),
      ),
    );
  }

  // Sent message (client → right side, emerald gradient)
  Widget _buildSentMessage(String text, String time) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(bottom: 2.h, left: 20.w),
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.5.h),
        decoration: BoxDecoration(
          gradient: AppColors.kBrandGradient,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.kBrandLight.withValues(alpha: 0.35),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(text, style: AppTypography.body.copyWith(color: Colors.white)),
            SizedBox(height: 0.6.h),
            Text(
              time,
              style: AppTypography.caption.copyWith(color: Colors.white.withValues(alpha: 0.75)),
            ),
          ],
        ),
      ),
    );
  }

  // Message input area
  Widget _buildInputArea() {
    final controller = TextEditingController();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppColors.kBgSurface.withValues(alpha: 0.94),
        border: Border(
          top: BorderSide(
            color: AppColors.kBrandLight.withValues(alpha: 0.15),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Attach button
          Container(
            padding: EdgeInsets.all(1.w),
            decoration: BoxDecoration(
              color: AppColors.kBrandLight.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.attach_file_rounded),
              color: AppColors.kBrandLight,
              iconSize: 2.h,
              onPressed: () {},
            ),
          ),

          SizedBox(width: 3.w),

          // Text field (glass effect)
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.kBrandLight.withValues(alpha: 0.18)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: TextField(
                  controller: controller,
                  style: AppTypography.body,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    hintStyle: AppTypography.caption,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 2.5.w,
                      vertical: 1.h,
                    ),
                  ),
                  maxLines: 20,
                  minLines: 1,
                ),
              ),
            ),
          ),

          SizedBox(width: 1.5.w),

          // Send button
          GestureDetector(
            onTap: () {
              if (controller.text.trim().isNotEmpty) {
                // TODO: Send message logic here
                controller.clear();
              }
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: const BoxDecoration(
                gradient: AppColors.kBrandGradient,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.send_rounded,
                color: Colors.white,
                size: 26,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
