import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lex_core/features/client/presentation/providers/bottom_navigation_provider/bottom_navigation_provider.dart';
import 'package:lex_core/features/chat/presentation/screens/chat_list_screen.dart';
import 'package:lex_core/features/client/presentation/screens/home/home_screen.dart';
import 'package:lex_core/features/client/presentation/screens/search/search_screen.dart';
import 'package:lex_core/features/client/presentation/screens/video/video_screen.dart';
import 'package:lex_core/shared/widgets/custom_bottom_navbar.dart';
import 'package:lex_core/features/client/presentation/screens/settings/client_settings_screen.dart';
import 'package:lex_core/shared/widgets/custom_client_drawer.dart';
import 'package:sizer/sizer.dart';

class BottomNavigationScreen extends ConsumerStatefulWidget {
  final int initialIndex;
  const BottomNavigationScreen({super.key, this.initialIndex = 0});

  @override
  ConsumerState<BottomNavigationScreen> createState() =>
      _BottomNavigationScreenState();
}

class _BottomNavigationScreenState
    extends ConsumerState<BottomNavigationScreen> {
  final List<Widget> _screens = [
    HomeScreen(),
    ChatListScreen(),
    VideoScreen(),
    SearchScreen(),
    const ClientSettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(bottomNavigationProvider);
    return Scaffold(
      drawer: const CustomClientDrawer(),
      backgroundColor: Colors.white,
      extendBody: true, // to make FAB overlap cleanly
      body: IndexedStack(
        index: currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: CustomBottomNavbar(
          currentIndex: currentIndex,
          onTap: (index) =>
              ref.read(bottomNavigationProvider.notifier).setIndex(index),
          items: [
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.dashboard_rounded),
              icon: Icon(Icons.dashboard_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.chat_rounded),
              icon: Icon(Icons.chat_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.videocam_rounded),
              icon: Icon(Icons.videocam_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.search_rounded),
              icon: Icon(Icons.search_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.settings_rounded),
              icon: Icon(Icons.settings_outlined),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
