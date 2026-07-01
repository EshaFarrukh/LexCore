import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lex_core/features/student/presentation/widgets/student_portal_header.dart';

class ResearchScreen extends StatefulWidget {
  const ResearchScreen({super.key});

  @override
  State<ResearchScreen> createState() => _ResearchScreenState();
}

class _ResearchScreenState extends State<ResearchScreen> {
  final TextEditingController _ctrl = TextEditingController();
  bool _isSearching = false;

  void _performSearch() async {
    if (_ctrl.text.isEmpty) return;
    setState(() => _isSearching = true);
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) setState(() => _isSearching = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9), // Match the updated deep background
      body: Column(
        children: [
          const StudentPortalHeader(bottomRadius: false),
          // Premium Search Header
          Container(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 40, top: 0),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(36), bottomRight: Radius.circular(36)),
              boxShadow: [
                BoxShadow(color: const Color(0xFF0F172A).withOpacity(0.15), blurRadius: 20, offset: const Offset(0, 10)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Search 100k+ Case Laws', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: -0.5)),
                const SizedBox(height: 8),
                Text('Find judgments, precedents, and statutes instantly', style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.7))),
                const SizedBox(height: 28),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 24, offset: const Offset(0, 8)),
                    ],
                  ),
                  child: TextField(
                    controller: _ctrl,
                    style: const TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.w600),
                    onSubmitted: (_) => _performSearch(),
                    decoration: InputDecoration(
                      hintText: 'e.g., PLD 2020 SC 1, Cybercrime...',
                      hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 15, fontWeight: FontWeight.w500),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: Icon(Icons.search_rounded, color: Color(0xFF3B82F6), size: 26),
                      ),
                      prefixIconConstraints: const BoxConstraints(minWidth: 50, minHeight: 50),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: _isSearching
                ? const Center(child: CircularProgressIndicator(color: Color(0xFF3B82F6)))
                : _ctrl.text.isEmpty
                    ? _buildCategories()
                    : _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Popular Journals', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF0F172A), letterSpacing: -0.5)),
              Text('View All', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: const Color(0xFF3B82F6).withOpacity(0.9))),
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 16, runSpacing: 16,
            children: [
              _journalChip('PLD', 'All Pakistan Legal Decisions', const Color(0xFF3B82F6), const Color(0xFFEFF6FF)),
              _journalChip('SCMR', 'Supreme Court Monthly Review', const Color(0xFF8B5CF6), const Color(0xFFF5F3FF)),
              _journalChip('CLC', 'Civil Law Cases', const Color(0xFFF59E0B), const Color(0xFFFFFBEB)),
              _journalChip('YLR', 'Yearly Law Reporter', const Color(0xFF10B981), const Color(0xFFECFDF5)),
            ],
          ).animate().fadeIn().slideY(begin: 0.1),
          const SizedBox(height: 40),
          const Text('Recent Searches', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF0F172A), letterSpacing: -0.5)),
          const SizedBox(height: 20),
          _recentRow('Article 62(1)(f) disqualification precedents'),
          _recentRow('Child custody welfare principle in Family Law'),
          _recentRow('Digital evidence admissibility under Qanun-e-Shahadat'),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _journalChip(String acr, String full, Color color, Color bgColor) {
    return Container(
      width: (MediaQuery.of(context).size.width - 64) / 2, // 48 padding + 16 spacing
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: const Color(0xFF0F172A).withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 8)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(acr, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: color, letterSpacing: 0.5)),
          ),
          const SizedBox(height: 16),
          Text(full, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF64748B), height: 1.4), maxLines: 2),
        ],
      ),
    );
  }

  Widget _recentRow(String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: const Color(0xFF0F172A).withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 8)),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.history_rounded, color: Color(0xFF94A3B8), size: 20),
          const SizedBox(width: 16),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF475569)))),
          const Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFFCBD5E1), size: 16),
        ],
      ),
    ).animate().fadeIn();
  }

  Widget _buildSearchResults() {
    final List<Map<String, String>> mockResults = [
      {
        'citation': 'PLD 2017 SC 265',
        'title': 'Imran Ahmad Khan Niazi v. Mian Muhammad Nawaz Sharif',
        'desc': 'Landmark judgment on Article 62(1)(f) of the Constitution regarding the disqualification of the Prime Minister and the definition of Sadiq and Ameen.',
        'court': 'Supreme Court of Pakistan',
      },
      {
        'citation': '2020 SCMR 122',
        'title': 'State vs. Ali Raza',
        'desc': 'A comprehensive review of the Prevention of Electronic Crimes Act (PECA), setting guidelines for the admissibility of digital and forensic evidence.',
        'court': 'Supreme Court of Pakistan',
      },
      {
        'citation': 'PLD 2019 SC 145',
        'title': 'Mst. Fatima vs. District Judge Family Court',
        'desc': 'Critical ruling establishing that the paramount consideration in child custody disputes must always be the welfare and psychological well-being of the minor.',
        'court': 'Supreme Court of Pakistan',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: mockResults.length,
      itemBuilder: (context, index) {
        final res = mockResults[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(color: const Color(0xFF0F172A).withOpacity(0.05), blurRadius: 24, offset: const Offset(0, 10)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(res['citation']!, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF3B82F6), letterSpacing: 0.5)),
                  ),
                  const Icon(Icons.bookmark_border_rounded, color: Color(0xFF94A3B8), size: 22),
                ],
              ),
              const SizedBox(height: 20),
              Text(res['title']!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF0F172A), height: 1.3, letterSpacing: -0.5)),
              const SizedBox(height: 12),
              Text(res['desc']!,
                  maxLines: 3, overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14, color: Color(0xFF64748B), height: 1.5)),
              const SizedBox(height: 24),
              Container(height: 1, color: const Color(0xFFF1F5F9)),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(Icons.account_balance_rounded, size: 18, color: Color(0xFF94A3B8)),
                  const SizedBox(width: 8),
                  Text(res['court']!, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF64748B))),
                  const Spacer(),
                  const Text('Read Full', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF3B82F6))),
                  const SizedBox(width: 6),
                  const Icon(Icons.arrow_forward_rounded, size: 16, color: Color(0xFF3B82F6)),
                ],
              ),
            ],
          ),
        ).animate(delay: (index * 100).ms).fadeIn().slideY(begin: 0.1);
      },
    );
  }
}
