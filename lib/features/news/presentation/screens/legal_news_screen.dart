import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lex_core/core/constants/app_colors.dart';

class _NewsArticle {
  final String id;
  final String title;
  final String summary;
  final String content;
  final String category;
  final String source;
  final String date;
  final String readTime;
  final bool isBreaking;

  const _NewsArticle({
    required this.id, required this.title, required this.summary, required this.content,
    required this.category, required this.source, required this.date,
    this.readTime = '3 min read', this.isBreaking = false,
  });
}

class LegalNewsScreen extends StatefulWidget {
  const LegalNewsScreen({super.key});

  @override
  State<LegalNewsScreen> createState() => _LegalNewsScreenState();
}

class _LegalNewsScreenState extends State<LegalNewsScreen> {
  String _selectedCategory = 'All';
  final _bookmarks = <String>{};

  static const _categories = ['All', 'Supreme Court', 'Criminal', 'Constitutional', 'Property', 'Family', 'International'];

  static const List<_NewsArticle> _articles = [
    _NewsArticle(id: '1', title: 'Supreme Court Orders Immediate Clearance of Bail Applications Backlog', summary: 'The Supreme Court of Pakistan has directed all sessions courts to clear the bail applications backlog within 60 days.', content: 'In a landmark directive, the Supreme Court of Pakistan has ordered all Sessions Courts across the country to clear the backlog of pending bail applications within 60 days. The Chief Justice observed that delayed bail hearings violate fundamental rights under Article 9 and Article 10 of the Constitution.\n\nThe court noted that over 45,000 bail applications are pending across various courts in Pakistan, with some applicants waiting months for their first hearing. The directive applies to all bailable and non-bailable offence categories.\n\nAdditional measures include the establishment of dedicated bail courts in districts with high pending volumes and weekly reporting to the Supreme Court registry.', category: 'Supreme Court', source: 'Dawn News', date: 'Jun 28, 2026', readTime: '4 min read', isBreaking: true),
    _NewsArticle(id: '2', title: 'Lahore High Court Landmark Ruling on Cybercrime Evidence Admissibility', summary: 'LHC establishes new precedent for digital evidence standards in criminal trials.', content: 'The Lahore High Court has issued a landmark judgment establishing clear standards for the admissibility of digital evidence in criminal proceedings. The ruling, authored by Justice Ahmed Shah, addresses the growing challenge of presenting electronic evidence in Pakistani courts.\n\nThe judgment outlines specific requirements including proper chain of custody for digital devices, forensic examination protocols, and expert testimony requirements. The ruling also addresses the authentication of social media content, text messages, and email communications.\n\nLegal experts have welcomed the ruling as a much-needed modernisation of evidence law in Pakistan, noting that the existing Qanun-e-Shahadat Order 1984 has limited provisions for electronic evidence.', category: 'Criminal', source: 'The News', date: 'Jun 27, 2026', readTime: '5 min read'),
    _NewsArticle(id: '3', title: 'New Property Transfer Laws Take Effect Across Punjab', summary: 'Provincial government implements simplified property transfer process with digital verification.', content: 'The Punjab government has officially implemented new property transfer regulations that significantly simplify the transfer process. The new laws require digital verification of all property transactions through the Punjab Land Record Authority (PLRA) system.\n\nKey changes include mandatory biometric verification at the time of registry, real-time cross-referencing with NADRA records, and automated valuation certificates. The reforms aim to reduce property fraud and disputes.\n\nProperty lawyers have noted that while the changes add transparency, the transition period may cause delays as sub-registrar offices adapt to the new digital workflows.', category: 'Property', source: 'Express Tribune', date: 'Jun 26, 2026'),
    _NewsArticle(id: '4', title: 'Federal Shariat Court Reviews Inheritance Distribution Standards', summary: 'Court examines discrepancies in inheritance distribution practices across provinces.', content: 'The Federal Shariat Court has taken suo motu notice of widespread discrepancies in inheritance distribution practices across Pakistan. The court observed that despite clear Sharia guidelines, many families continue to deny women their lawful share in inherited property.\n\nThe court has directed the provincial governments to submit reports on the enforcement of inheritance rights within 30 days. Legal aid organisations have been asked to present data on inheritance-related cases filed in family courts.', category: 'Constitutional', source: 'Geo News', date: 'Jun 25, 2026'),
    _NewsArticle(id: '5', title: 'Pakistan Bar Association Announces Digital Legal Services Initiative', summary: 'PBA launches nationwide platform for online legal consultations and document filing.', content: 'The Pakistan Bar Association has launched a digital legal services initiative aimed at providing accessible legal assistance to citizens in remote areas. The platform will enable online legal consultations, electronic document filing, and virtual court appearances for select case categories.\n\nThe initiative, funded through a partnership with the Ministry of Law and Justice, will initially operate in 20 pilot districts across all four provinces. Registered lawyers will be able to offer discounted consultation services through the platform.', category: 'Supreme Court', source: 'Business Recorder', date: 'Jun 24, 2026'),
    _NewsArticle(id: '6', title: 'Sindh High Court Sets Precedent in Family Court Appeals', summary: 'SHC ruling clarifies appeal procedures for child custody decisions.', content: 'The Sindh High Court has set a new precedent in family court appeals by ruling that child custody decisions must prioritise the welfare of the child over procedural technicalities. The judgment addresses the growing concern about delayed custody proceedings.\n\nThe court emphasized that family courts must conduct custody evaluations within 60 days and that appellate courts should give maximum weight to the child\'s expressed preference if they are above 7 years of age.', category: 'Family', source: 'Dawn News', date: 'Jun 23, 2026'),
    _NewsArticle(id: '7', title: 'Anti-Corruption Laws Amended: Key Changes for Business Owners', summary: 'National Accountability Bureau threshold increased to Rs. 100 million for commercial cases.', content: 'The government has passed significant amendments to the National Accountability Ordinance (NAO), raising the minimum threshold for NAB investigations in commercial cases from Rs. 50 million to Rs. 100 million. The amendments aim to separate genuine business disputes from corruption cases.\n\nAdditional changes include the removal of NAB\'s power to arrest during investigation for commercial disputes and a mandatory time limit of 10 months for completing investigations. The business community has largely welcomed these changes.', category: 'Criminal', source: 'The News', date: 'Jun 22, 2026'),
    _NewsArticle(id: '8', title: 'Constitutional Petition Filed Over Privacy Rights in Digital Age', summary: 'Citizen challenges government surveillance powers under Article 14 of the Constitution.', content: 'A constitutional petition has been filed before the Islamabad High Court challenging the government\'s digital surveillance powers under the Prevention of Electronic Crimes Act (PECA) 2016. The petitioner argues that certain provisions of PECA violate the fundamental right to privacy under Article 14 of the Constitution.\n\nThe petition specifically targets Section 29 of PECA, which allows law enforcement to request real-time data from service providers without judicial oversight in certain circumstances.', category: 'Constitutional', source: 'Dawn News', date: 'Jun 21, 2026'),
    _NewsArticle(id: '9', title: 'International Court of Justice Ruling Impacts Pakistan Trade Disputes', summary: 'ICJ ruling on trade arbitration affects ongoing Pakistan-India commercial disputes.', content: 'A recent International Court of Justice ruling on trade dispute arbitration mechanisms has implications for several pending commercial disputes between Pakistani and Indian business entities. The ruling establishes clearer guidelines for bilateral trade arbitration under the 1958 New York Convention.\n\nPakistani trade law experts note that the ruling could expedite resolution of long-pending disputes related to the 2019 trade restrictions.', category: 'International', source: 'Reuters', date: 'Jun 20, 2026'),
    _NewsArticle(id: '10', title: 'Punjab Government Introduces Mandatory ADR for Civil Cases Under Rs. 5 Million', summary: 'New rule requires mediation before civil suits can proceed to trial.', content: 'The Punjab government has introduced mandatory Alternative Dispute Resolution (ADR) for all civil cases with a disputed value under Rs. 5 million. The new rule requires parties to attempt mediation before filing a civil suit in court.\n\nThe initiative aims to reduce the burden on already overwhelmed civil courts. Mediation centres will be established at every district court, staffed by trained mediators from the bar association.', category: 'Property', source: 'Express Tribune', date: 'Jun 19, 2026'),
  ];

  List<_NewsArticle> get _filtered => _selectedCategory == 'All'
      ? _articles
      : _articles.where((a) => a.category == _selectedCategory).toList();

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;

    return Scaffold(
      backgroundColor: AppColors.kBgDeep,
      appBar: AppBar(
        backgroundColor: AppColors.kBgSurface,
        title: Text('Legal News', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700)),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Category chips
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _categories.length,
              itemBuilder: (context, i) {
                final cat = _categories[i];
                final selected = _selectedCategory == cat;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = cat),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: selected ? AppColors.kBrandGradient : null,
                      color: selected ? null : AppColors.kBgElevated,
                      borderRadius: BorderRadius.circular(20),
                      border: selected ? null : Border.all(color: AppColors.kBorder),
                    ),
                    child: Center(
                      child: Text(cat,
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 12, fontWeight: FontWeight.w600,
                              color: selected ? Colors.white : AppColors.kTextSecondary)),
                    ),
                  ),
                );
              },
            ),
          ),

          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1));
                setState(() {}); // simulate refresh
              },
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
                itemCount: filtered.length,
                itemBuilder: (context, i) {
                  final article = filtered[i];
                  // Featured card for first article
                  if (i == 0) return _buildFeaturedCard(article);
                  return _buildArticleCard(article, i);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedCard(_NewsArticle article) {
    return GestureDetector(
      onTap: () => _openArticle(article),
      child: Container(
        height: 200,
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1a1a2e), Color(0xFF16213e)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.kBrand.withOpacity(0.3)),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -20,
              right: -20,
              child: Icon(Icons.balance_rounded, size: 120, color: AppColors.kBrand.withOpacity(0.07)),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (article.isBreaking) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.kError,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text('BREAKING',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 9, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: 0.8)),
                    ),
                    const SizedBox(height: 8),
                  ],
                  _categoryBadge(article.category),
                  const SizedBox(height: 10),
                  Text(article.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.kTextPrimary, height: 1.3)),
                  const SizedBox(height: 8),
                  Text('${article.source} · ${article.date} · ${article.readTime}',
                      style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.kTextSecondary)),
                ],
              ),
            ),
          ],
        ),
      ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),
    );
  }

  Widget _buildArticleCard(_NewsArticle article, int index) {
    return GestureDetector(
      onTap: () => _openArticle(article),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.kBgSurface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.kBorder),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _categoryBadge(article.category),
                  const SizedBox(height: 8),
                  Text(article.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.kTextPrimary, height: 1.3)),
                  const SizedBox(height: 6),
                  Text('${article.source} · ${article.date} · ${article.readTime}',
                      style: GoogleFonts.plusJakartaSans(fontSize: 10, color: AppColors.kTextSecondary)),
                ],
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                setState(() {
                  _bookmarks.contains(article.id) ? _bookmarks.remove(article.id) : _bookmarks.add(article.id);
                });
              },
              child: Icon(
                _bookmarks.contains(article.id) ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                color: _bookmarks.contains(article.id) ? AppColors.kGold : AppColors.kTextTertiary,
                size: 22,
              ),
            ),
          ],
        ),
      ).animate(delay: (index * 60).ms).fadeIn(duration: 300.ms),
    );
  }

  Widget _categoryBadge(String category) {
    final color = _categoryColor(category);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(category,
          style: GoogleFonts.plusJakartaSans(fontSize: 10, fontWeight: FontWeight.w600, color: color)),
    );
  }

  Color _categoryColor(String c) {
    switch (c) {
      case 'Supreme Court': return AppColors.kGold;
      case 'Criminal': return AppColors.kError;
      case 'Constitutional': return AppColors.kBrand;
      case 'Property': return AppColors.kSuccess;
      case 'Family': return AppColors.kBrandLight;
      case 'International': return AppColors.kInfo;
      default: return AppColors.kTextSecondary;
    }
  }

  void _openArticle(_NewsArticle article) {
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => _ArticleDetailScreen(article: article),
    ));
  }
}

class _ArticleDetailScreen extends StatelessWidget {
  final _NewsArticle article;
  const _ArticleDetailScreen({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBgDeep,
      appBar: AppBar(
        backgroundColor: AppColors.kBgSurface,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.bookmark_border_rounded), onPressed: () {}),
          IconButton(icon: const Icon(Icons.share_rounded), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.kBrand.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(article.category,
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.kBrand)),
            ),
            const SizedBox(height: 16),
            Text(article.title,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.kTextPrimary, height: 1.3)),
            const SizedBox(height: 12),
            Text('${article.source} · ${article.date} · ${article.readTime}',
                style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.kTextSecondary)),
            const SizedBox(height: 20),
            const Divider(color: AppColors.kBorder),
            const SizedBox(height: 20),
            Text(article.content,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 15, color: AppColors.kTextPrimary, height: 1.7)),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
