import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/constants/app_typography.dart';
import 'package:lex_core/features/client/presentation/providers/home_screen_provider/search_provider.dart';
import 'package:lex_core/features/lawyer/presentation/providers/lawyer_provider.dart';
import 'package:lex_core/features/client/presentation/controllers/chat_controller.dart';
import 'package:lex_core/app/router/route_names.dart';
import 'package:lex_core/features/lawyer/presentation/states/lawyer_state.dart';
import 'package:lex_core/shared/widgets/custom_appbar.dart';
import 'package:lex_core/features/client/presentation/widgets/search_widget.dart';
import 'package:lex_core/features/client/presentation/widgets/lawyer_card.dart';
import 'package:sizer/sizer.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(lawyerProvider.notifier).loadLawyers());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(lawyerProvider);
    final searchQuery = ref.watch(searchQueryProvider).toLowerCase();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppbar(
        title: "Chat with Lawyers",
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        color: AppColors.kBgDeep,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 2.h),

              // Search bar with glass effect
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: SearchWidget(
                      hintText: 'Search lawyers by name...',
                      useSearchProvider: true,
                      onChanged: (q) =>
                          ref.read(searchQueryProvider.notifier).state = q,
                      prefixIcon: Icons.search_rounded,
                      textColor: AppColors.kTextPrimary,
                      hintTextColor: AppColors.kTextSecondary,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 3.h),

              // Lawyer list / states
              Expanded(child: _buildBody(state, searchQuery)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(LawyerState state, String query) {
    if (state is LawyerLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              color: AppColors.kBrandLight,
              strokeWidth: 4,
            ),
            SizedBox(height: 2.h),
            Text(
              "Loading lawyers...",
              style: AppTypography.body,
            ),
          ],
        ),
      );
    }

    if (state is LawyerError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              size: 80,
              color: AppColors.kError,
            ),
            SizedBox(height: 2.5.h),
            Text(
              "Failed to load lawyers",
              style: AppTypography.h2,
            ),
            SizedBox(height: 1.h),
            Text(
              state.message,
              style: AppTypography.body.copyWith(color: AppColors.kError),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if (state is LawyerLoaded) {
      final filtered = state.lawyers.where((lawyer) {
        final fullName = '${lawyer.firstName} ${lawyer.lastName}'.toLowerCase();
        return fullName.contains(query);
      }).toList();

      if (filtered.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off_rounded,
                size: 90,
                color: AppColors.kTextSecondary.withValues(alpha: 0.6),
              ),
              SizedBox(height: 3.h),
              Text(
                "No lawyers found",
                style: AppTypography.h2,
              ),
              SizedBox(height: 1.2.h),
              Text(
                "Try adjusting your search or check back later",
                style: AppTypography.body,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
        itemCount: filtered.length,
        itemBuilder: (context, index) {
          final lawyer = filtered[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 2.h),
            child: LawyerCard(
              profileImage: lawyer.profilePhoto,
              firstName: lawyer.firstName,
              lastName: lawyer.lastName,
              ratings: lawyer.rating,
              onTap: () {
                ref.read(selectedLawyerProvider.notifier).setLawyer(lawyer);
                context.push(RouteNames.chatDetailScreen);
              },
            ),
          );
        },
      );
    }

    // Initial / unknown state
    return Center(
      child: Text(
        "Tap search to find lawyers",
        style: AppTypography.body,
      ),
    );
  }
}

