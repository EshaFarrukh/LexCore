import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/constants/app_typography.dart';
import 'package:go_router/go_router.dart';
import 'package:lex_core/app/router/route_names.dart';
import 'package:lex_core/shared/widgets/lex_text_field.dart';

class _LawyerResult {
  final String id;
  final String name;
  final String title;
  final String experience;
  final double rating;
  final int reviews;
  final String location;
  final List<String> specializations;
  final int fee;
  final String avatarUrl;

  const _LawyerResult({
    required this.id, required this.name, required this.title, required this.experience,
    required this.rating, required this.reviews, required this.location,
    required this.specializations, required this.fee, required this.avatarUrl,
  });
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _ctrl = TextEditingController();
  String _query = '';
  String _selectedSpec = 'All';

  final List<String> _specializations = ['All', 'Criminal', 'Civil', 'Family', 'Property', 'Corporate'];

  final List<_LawyerResult> _lawyers = const [
    _LawyerResult(id: 'l1', name: 'Adv. Raza Khan', title: 'Senior Advocate High Court', experience: '15 Years', rating: 4.9, reviews: 124, location: 'Lahore', specializations: ['Criminal', 'Property'], fee: 15000, avatarUrl: ''),
    _LawyerResult(id: 'l2', name: 'Adv. Fatima Ahmed', title: 'Advocate High Court', experience: '8 Years', rating: 4.8, reviews: 89, location: 'Islamabad', specializations: ['Family', 'Civil'], fee: 10000, avatarUrl: ''),
    _LawyerResult(id: 'l3', name: 'Adv. Hassan Ali', title: 'Advocate Supreme Court', experience: '22 Years', rating: 5.0, reviews: 210, location: 'Karachi', specializations: ['Corporate', 'Civil'], fee: 25000, avatarUrl: ''),
    _LawyerResult(id: 'l4', name: 'Adv. Zainab Malik', title: 'Advocate High Court', experience: '5 Years', rating: 4.6, reviews: 45, location: 'Lahore', specializations: ['Family', 'Criminal'], fee: 8000, avatarUrl: ''),
  ];

  List<_LawyerResult> get _filtered {
    return _lawyers.where((l) {
      final matchQ = _query.isEmpty || l.name.toLowerCase().contains(_query.toLowerCase()) || l.location.toLowerCase().contains(_query.toLowerCase());
      final matchS = _selectedSpec == 'All' || l.specializations.contains(_selectedSpec);
      return matchQ && matchS;
    }).toList();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBgDeep,
      appBar: AppBar(
        backgroundColor: AppColors.kBgDeep,
        title: Text('Find Lawyers You Trust', style: AppTypography.h2),
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.kTextPrimary, size: 20),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          // Search & Filter header
          Container(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
            child: Column(
              children: [
                LexTextField(
                  controller: _ctrl,
                  hintText: 'Search by name or city...',
                  prefixIcon: Icons.search_rounded,
                  onChanged: (v) => setState(() => _query = v),
                ).animate().fadeIn().slideY(begin: -0.1),
                const SizedBox(height: 24),
                
                SizedBox(
                  height: 44,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    clipBehavior: Clip.none,
                    itemCount: _specializations.length,
                    itemBuilder: (context, index) {
                      final spec = _specializations[index];
                      final selected = _selectedSpec == spec;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedSpec = spec),
                        behavior: HitTestBehavior.opaque,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          decoration: BoxDecoration(
                            color: selected ? AppColors.kSurfaceInverted : AppColors.kBgSurface,
                            borderRadius: BorderRadius.circular(999),
                            border: selected ? null : Border.all(color: AppColors.kBorder),
                            boxShadow: selected ? [
                              BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 4))
                            ] : null,
                          ),
                          child: Center(
                            child: Text(spec, style: AppTypography.button.copyWith(
                              color: selected ? Colors.white : AppColors.kTextSecondary,
                            )),
                          ),
                        ),
                      );
                    },
                  ),
                ).animate(delay: 100.ms).fadeIn(),
              ],
            ),
          ),

          // Results
          Expanded(
            child: _filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.search_off_rounded, size: 64, color: AppColors.kTextTertiary),
                        const SizedBox(height: 16),
                        Text('No lawyers found', style: AppTypography.body.copyWith(color: AppColors.kTextSecondary)),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    itemCount: _filtered.length,
                    itemBuilder: (context, i) {
                      final l = _filtered[i];
                      return GestureDetector(
                        onTap: () => context.push(RouteNames.lawyerProfileScreen, extra: l.id),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 24),
                          decoration: BoxDecoration(
                            color: AppColors.kBgSurface,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: AppColors.kBorder),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 24, offset: const Offset(0, 8)),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Avatar Area
                              Container(
                                height: 160,
                                decoration: BoxDecoration(
                                  color: AppColors.kBrandLight.withValues(alpha: 0.15),
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                                ),
                                child: Center(
                                  child: Container(
                                    width: 80, height: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4)),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(l.name.substring(5, 6), style: AppTypography.display.copyWith(color: AppColors.kBrand)),
                                    ),
                                  ),
                                ),
                              ),
                              
                              // Details Area
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(l.name, style: AppTypography.h2),
                                              const SizedBox(height: 4),
                                              Text(l.title, style: AppTypography.bodySm.copyWith(color: AppColors.kTextSecondary)),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFFFF7ED),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            children: [
                                              const Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 14),
                                              const SizedBox(width: 4),
                                              Text('${l.rating}', style: AppTypography.button.copyWith(color: const Color(0xFFD97706))),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on_outlined, size: 16, color: AppColors.kTextTertiary),
                                        const SizedBox(width: 4),
                                        Text(l.location, style: AppTypography.caption),
                                        const SizedBox(width: 16),
                                        const Icon(Icons.military_tech_outlined, size: 16, color: AppColors.kTextTertiary),
                                        const SizedBox(width: 4),
                                        Text(l.experience, style: AppTypography.caption),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    
                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: l.specializations.map((s) => Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: AppColors.kInputBg,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(s, style: AppTypography.caption.copyWith(fontWeight: FontWeight.w600)),
                                      )).toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ).animate(delay: (i * 100).ms).fadeIn().slideY(begin: 0.1),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
