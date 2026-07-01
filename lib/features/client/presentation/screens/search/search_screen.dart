import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/constants/app_typography.dart';
import 'package:lex_core/features/client/presentation/providers/home_screen_provider/search_provider.dart';
import 'package:lex_core/features/lawyer/domain/entities/lawyer_entity.dart';
import 'package:lex_core/features/lawyer/presentation/providers/lawyer_provider.dart';
import 'package:lex_core/app/router/route_names.dart';
import 'package:lex_core/features/lawyer/presentation/states/lawyer_state.dart';
import 'package:lex_core/shared/widgets/custom_appbar.dart';
import 'package:lex_core/shared/widgets/custom_search_filter_bar.dart';
import 'package:lex_core/features/client/presentation/widgets/lawyer_card.dart';
import 'package:lex_core/shared/widgets/failed_widget.dart';
import 'package:sizer/sizer.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    // Load initial page
    Future.microtask(() => ref.read(lawyerProvider.notifier).loadLawyers());

    // Infinite scroll detection
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.85) {
        ref.read(lawyerProvider.notifier).loadMore();
      }
    });
  }

  @override
  void dispose() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await ref.read(lawyerProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(lawyerProvider);
    final searchQuery = ref.watch(searchQueryProvider).toLowerCase();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text(
          "Find Lawyers",
          style: AppTypography.h1.copyWith(
            fontSize: 28,
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
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 0, right: 0, bottom: 32, top: 16),
            decoration: const BoxDecoration(
              color: Color(0xFF0F172A),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
            ),
            child: CustomSearchFilterBar(
              hintText: 'Search lawyers by name or expertise...',
              initialSearchQuery: ref.read(searchQueryProvider),
              onSearchChanged: (v) {
                if (_debounce?.isActive ?? false) _debounce!.cancel();
                _debounce = Timer(const Duration(milliseconds: 300), () {
                  ref.read(searchQueryProvider.notifier).state = v;
                });
              },
              padding: EdgeInsets.symmetric(horizontal: 6.w),
            ),
          ),
          SizedBox(height: 3.h),

              // Main content area
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _onRefresh,
                  color: const Color(0xFF3B82F6),
                  backgroundColor: Colors.white,
                  child: _buildBody(state, searchQuery),
                ),
              ),
            ],
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
              color: Color(0xFF3B82F6),
              strokeWidth: 4,
            ),
            SizedBox(height: 2.5.h),
            Text(
              "Loading lawyers...",
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF64748B),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    if (state is LawyerError) {
      return FailedWidget(
        text: state.message,
        icon: Icons.error_outline,
        title: "Failed to load lawyers",
        onRetry: () => ref.read(lawyerProvider.notifier).refresh(),
      );
    }

    final lawyers = state is LawyerLoaded ? state.lawyers : <LawyerEntity>[];

    final filtered = lawyers.where((lawyer) {
      return lawyer.fullName.toLowerCase().contains(query);
    }).toList();

    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search_off_rounded,
              size: 90,
              color: Color(0xFFCBD5E1),
            ),
            SizedBox(height: 3.5.h),
            Text(
              query.isEmpty
                  ? "No lawyers available yet"
                  : "No matching lawyers",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),
            ),
            SizedBox(height: 1.5.h),
            Text(
              query.isEmpty
                  ? "Check back later or adjust filters"
                  : "Try different keywords or clear search",
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF64748B),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      itemCount:
          filtered.length + (state is LawyerLoaded && state.hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        // Bottom loading indicator when fetching more
        if (index == filtered.length) {
          return Padding(
            padding: EdgeInsets.all(5.h),
            child: const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF3B82F6),
                strokeWidth: 3,
              ),
            ),
          );
        }

        final lawyer = filtered[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 2.h),
          child: LawyerCard(
            profileImage: lawyer.profilePhoto,
            firstName: lawyer.firstName,
            lastName: lawyer.lastName,
            ratings: lawyer.rating,
            onTap: () {
              context.push(RouteNames.lawyerScreen, extra: lawyer);
            },
          ),
        );
      },
    );
  }
}
