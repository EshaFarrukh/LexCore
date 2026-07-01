import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/constants/app_typography.dart';
import 'package:lex_core/features/chat/domain/models/chat_models.dart';
import 'package:lex_core/features/chat/presentation/providers/chat_availability_provider.dart';
import 'package:intl/intl.dart';

class ChatListScreen extends ConsumerWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mock data for conversations
    final List<Conversation> conversations = [
      Conversation(
        id: 1,
        otherUserId: 'u1',
        otherUserName: 'Zayahan Hasan',
        otherUserAvatar: 'https://i.pravatar.cc/150?u=u1',
        lastMessage: 'Hello, I have a question about my case.',
        lastMessageTimestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        unreadCount: 2,
        isOnline: true,
      ),
      Conversation(
        id: 2,
        otherUserId: 'u2',
        otherUserName: 'Ahmad Khan',
        otherUserAvatar: 'https://i.pravatar.cc/150?u=u2',
        lastMessage: 'The documents are ready for review.',
        lastMessageTimestamp: DateTime.now().subtract(const Duration(hours: 1)),
        unreadCount: 0,
        isOnline: false,
      ),
      Conversation(
        id: 3,
        otherUserId: 'u3',
        otherUserName: 'Sara Ahmed',
        otherUserAvatar: 'https://i.pravatar.cc/150?u=u3',
        lastMessage: 'Thank you for your help!',
        lastMessageTimestamp: DateTime.now().subtract(const Duration(days: 1)),
        unreadCount: 0,
        isOnline: true,
      ),
    ];

    final availabilityAsync = ref.watch(chatAvailabilityProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text(
          "Messages",
          style: AppTypography.h1.copyWith(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded, color: Colors.white, size: 28),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.edit_square, color: Colors.white, size: 26),
            onPressed: () {},
          ),
          GestureDetector(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.only(left: 8, right: 16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: const Icon(Icons.menu_rounded, color: Colors.white, size: 20),
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
                width: double.infinity,
                padding: const EdgeInsets.only(left: 0, right: 0, bottom: 32, top: 16),
                decoration: const BoxDecoration(
                  color: Color(0xFF0F172A),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
                ),
                child: _buildOnlineUsers(conversations),
              ),
              Expanded(
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final conv = conversations[index];
                          return _buildConversationTile(context, conv);
                        },
                        childCount: conversations.length,
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 120)), // Space for bottom nav
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.kBrand)),
        error: (err, stack) => const Center(child: Text("Error loading chats", style: TextStyle(color: Colors.red))),
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
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.chat_bubble_outline_rounded, size: 64, color: Color(0xFF94A3B8)),
            ),
            const SizedBox(height: 24),
            Text(
              "No Messages Yet",
              style: AppTypography.h3.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              "Conversations will appear here once you connect with someone.",
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

  Widget _buildOnlineUsers(List<Conversation> conversations) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: conversations.length,
        itemBuilder: (context, index) {
          final conv = conversations[index];
          return Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: conv.isOnline ? const Color(0xFF3B82F6) : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: const Color(0xFFE2E8F0),
                        backgroundImage: NetworkImage(conv.otherUserAvatar),
                      ),
                    ),
                    if (conv.isOnline)
                      Positioned(
                        right: 4,
                        bottom: 2,
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: const Color(0xFF22C55E),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2.5),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  conv.otherUserName.split(' ')[0],
                  style: AppTypography.caption.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF475569),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildConversationTile(BuildContext context, Conversation conv) {
    final bool hasUnread = conv.unreadCount > 0;
    
    return InkWell(
      onTap: () {
        context.push('/client/chat/${conv.id}');
      },
      highlightColor: const Color(0xFFF8FAFC),
      splashColor: const Color(0xFFF1F5F9),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: const Color(0xFFE2E8F0),
              backgroundImage: NetworkImage(conv.otherUserAvatar),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        conv.otherUserName,
                        style: AppTypography.h3.copyWith(
                          fontSize: 17,
                          fontWeight: hasUnread ? FontWeight.w800 : FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      Text(
                        DateFormat('hh:mm a').format(conv.lastMessageTimestamp),
                        style: AppTypography.caption.copyWith(
                          fontSize: 13,
                          fontWeight: hasUnread ? FontWeight.w600 : FontWeight.w500,
                          color: hasUnread ? const Color(0xFF3B82F6) : const Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          conv.lastMessage,
                          style: AppTypography.bodySm.copyWith(
                            fontSize: 15,
                            color: hasUnread ? const Color(0xFF334155) : const Color(0xFF64748B),
                            fontWeight: hasUnread ? FontWeight.w600 : FontWeight.w400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (hasUnread) ...[
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: const BoxDecoration(
                            color: Color(0xFF3B82F6),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            conv.unreadCount.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ]
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
