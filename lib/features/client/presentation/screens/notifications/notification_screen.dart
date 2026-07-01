import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lex_core/core/constants/app_colors.dart';

class _MockNotification {
  final String id;
  final String title;
  final String body;
  final String timeAgo;
  final IconData icon;
  final Color iconColor;
  final String group;
  bool isRead;

  _MockNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.timeAgo,
    required this.icon,
    required this.iconColor,
    this.group = 'Today',
    this.isRead = false,
  });
}

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  late final List<_MockNotification> _notifications;

  @override
  void initState() {
    super.initState();
    _notifications = [
      _MockNotification(id: '1', title: 'New Message', body: 'Adv. Raza Khan sent you a message about your property case.', timeAgo: '2 min ago', icon: Icons.chat_bubble_rounded, iconColor: AppColors.kBrand, group: 'Today'),
      _MockNotification(id: '2', title: 'Case Status Updated', body: 'Case #2024-CR-001 status changed to "Hearing Scheduled".', timeAgo: '15 min ago', icon: Icons.update_rounded, iconColor: AppColors.kSuccess, group: 'Today'),
      _MockNotification(id: '3', title: 'Hearing Reminder', body: 'Your case hearing is tomorrow at 10:00 AM, Sessions Court Room 3.', timeAgo: '1 hour ago', icon: Icons.event_rounded, iconColor: AppColors.kWarning, group: 'Today'),
      _MockNotification(id: '4', title: 'Lawyer Accepted Case', body: 'Adv. Fatima Ahmed has accepted your divorce case.', timeAgo: '3 hours ago', icon: Icons.person_add_rounded, iconColor: AppColors.kBrand, group: 'Today'),
      _MockNotification(id: '5', title: 'Donation Successful', body: 'Thank you! Your donation of Rs. 1,000 was received successfully.', timeAgo: '5 hours ago', icon: Icons.favorite_rounded, iconColor: AppColors.kError, group: 'Today'),
      _MockNotification(id: '6', title: 'Document Uploaded', body: 'New evidence document uploaded to Case #2024-CV-023.', timeAgo: '1 day ago', icon: Icons.description_rounded, iconColor: AppColors.kGold, group: 'This Week', isRead: true),
      _MockNotification(id: '7', title: 'New Message', body: 'Adv. Hussain replied to your query about bail procedures.', timeAgo: '1 day ago', icon: Icons.chat_bubble_rounded, iconColor: AppColors.kBrand, group: 'This Week', isRead: true),
      _MockNotification(id: '8', title: 'Case Disposed', body: 'Case #2024-FM-045 has been disposed. Outcome: Settled.', timeAgo: '2 days ago', icon: Icons.check_circle_rounded, iconColor: AppColors.kSuccess, group: 'This Week', isRead: true),
      _MockNotification(id: '9', title: 'Payment Reminder', body: 'Consultation fee of Rs. 8,000 is pending for Case #2024-CR-067.', timeAgo: '3 days ago', icon: Icons.payment_rounded, iconColor: AppColors.kWarning, group: 'This Week', isRead: true),
      _MockNotification(id: '10', title: 'Rating Request', body: 'How was your experience with Adv. Raza Khan? Leave a review.', timeAgo: '4 days ago', icon: Icons.star_rounded, iconColor: AppColors.kGold, group: 'This Week', isRead: true),
      _MockNotification(id: '11', title: 'System Update', body: 'LexCore has been updated with new features. Check them out!', timeAgo: '1 week ago', icon: Icons.system_update_rounded, iconColor: AppColors.kBrandLight, group: 'Earlier', isRead: true),
      _MockNotification(id: '12', title: 'Welcome to LexCore', body: 'Thank you for joining. Complete your profile to get started.', timeAgo: '2 weeks ago', icon: Icons.celebration_rounded, iconColor: AppColors.kBrand, group: 'Earlier', isRead: true),
    ];
  }

  void _markAllRead() {
    setState(() {
      for (final n in _notifications) {
        n.isRead = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final grouped = <String, List<_MockNotification>>{};
    for (final n in _notifications) {
      grouped.putIfAbsent(n.group, () => []).add(n);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text(
          "Notifications",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            color: const Color(0xFF0F172A),
          ),
        ),
        actions: [
          TextButton(
            onPressed: _markAllRead,
            child: Text(
              'Mark all read',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                color: const Color(0xFF3B82F6),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_off_rounded, size: 64, color: AppColors.kTextTertiary),
                  const SizedBox(height: 16),
                  Text('No notifications yet',
                      style: GoogleFonts.plusJakartaSans(fontSize: 16, color: AppColors.kTextSecondary)),
                ],
              ),
            )
          : ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: grouped.entries.expand((entry) {
                return [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                    child: Text(entry.key,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.kTextSecondary, letterSpacing: 0.6)),
                  ),
                  ...entry.value.asMap().entries.map((e) {
                    final n = e.value;
                    return Dismissible(
                      key: Key(n.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: AppColors.kError.withOpacity(0.2),
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        child: const Icon(Icons.delete_rounded, color: AppColors.kError),
                      ),
                      onDismissed: (_) => setState(() => _notifications.remove(n)),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: n.isRead ? AppColors.kBgSurface : AppColors.kBgElevated,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: n.isRead ? AppColors.kBorder : AppColors.kBrand.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: n.iconColor.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(n.icon, color: n.iconColor, size: 20),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(n.title,
                                      style: GoogleFonts.plusJakartaSans(
                                          fontSize: 13,
                                          fontWeight: n.isRead ? FontWeight.w500 : FontWeight.w700,
                                          color: AppColors.kTextPrimary)),
                                  const SizedBox(height: 3),
                                  Text(n.body,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.plusJakartaSans(
                                          fontSize: 12, color: AppColors.kTextSecondary, height: 1.3)),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(n.timeAgo,
                                    style: GoogleFonts.plusJakartaSans(
                                        fontSize: 10, color: AppColors.kTextTertiary)),
                                if (!n.isRead) ...[
                                  const SizedBox(height: 6),
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: AppColors.kBrand,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                    ).animate(delay: (e.key * 50).ms).fadeIn(duration: 300.ms);
                  }),
                ];
              }).toList(),
            ),
    );
  }
}
