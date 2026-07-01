import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class CustomBottomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<BottomNavigationBarItem> items;

  const CustomBottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 6.w, right: 6.w, bottom: 4.h),
      child: Container(
        height: 72,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.75),
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.5),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 32,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(items.length, (index) {
                  final isSelected = currentIndex == index;
                  final item = items[index];
                  return GestureDetector(
                    onTap: () => onTap(index),
                    behavior: HitTestBehavior.opaque,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOutCubic,
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.kSurfaceInverted
                            : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          isSelected && item.activeIcon is Icon
                              ? (item.activeIcon as Icon).icon
                              : (item.icon as Icon).icon,
                          color: isSelected
                              ? Colors.white
                              : AppColors.kTextSecondary,
                          size: 26,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
