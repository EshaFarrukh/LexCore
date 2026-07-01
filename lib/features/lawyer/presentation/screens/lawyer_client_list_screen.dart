import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lex_core/core/constants/app_colors.dart';

class _MockClient {
  final String name;
  final String city;
  final int activeCases;
  final int totalCases;
  final String lastContact;
  final Color avatarColor;
  final String initials;

  const _MockClient({
    required this.name, required this.city, required this.activeCases,
    required this.totalCases, required this.lastContact, required this.avatarColor,
    required this.initials,
  });
}

class LawyerClientListScreen extends StatefulWidget {
  const LawyerClientListScreen({super.key});

  @override
  State<LawyerClientListScreen> createState() => _LawyerClientListScreenState();
}

class _LawyerClientListScreenState extends State<LawyerClientListScreen> {
  String _search = '';

  static const List<_MockClient> _clients = [
    _MockClient(name: 'Hassan Ali', city: 'Lahore', activeCases: 2, totalCases: 3, lastContact: 'Today', avatarColor: AppColors.kBrand, initials: 'HA'),
    _MockClient(name: 'Fatima Khan', city: 'Karachi', activeCases: 1, totalCases: 1, lastContact: 'Yesterday', avatarColor: AppColors.kSuccess, initials: 'FK'),
    _MockClient(name: 'Muhammad Usman', city: 'Islamabad', activeCases: 1, totalCases: 3, lastContact: '2 days ago', avatarColor: AppColors.kGold, initials: 'MU'),
    _MockClient(name: 'Zainab Malik', city: 'Lahore', activeCases: 1, totalCases: 1, lastContact: '3 days ago', avatarColor: AppColors.kBrand, initials: 'ZM'),
    _MockClient(name: 'Ahmed Raza', city: 'Rawalpindi', activeCases: 2, totalCases: 4, lastContact: '1 week ago', avatarColor: AppColors.kWarning, initials: 'AR'),
    _MockClient(name: 'Nadia Farooq', city: 'Faisalabad', activeCases: 0, totalCases: 2, lastContact: '2 weeks ago', avatarColor: AppColors.kError, initials: 'NF'),
    _MockClient(name: 'Tariq Hussain', city: 'Multan', activeCases: 1, totalCases: 2, lastContact: '1 week ago', avatarColor: AppColors.kInfo, initials: 'TH'),
    _MockClient(name: 'Sara Ahmed', city: 'Lahore', activeCases: 1, totalCases: 1, lastContact: '4 days ago', avatarColor: AppColors.kSuccess, initials: 'SA'),
    _MockClient(name: 'Imran Sheikh', city: 'Karachi', activeCases: 0, totalCases: 1, lastContact: '3 weeks ago', avatarColor: AppColors.kTextSecondary, initials: 'IS'),
    _MockClient(name: 'Amina Bibi', city: 'Peshawar', activeCases: 1, totalCases: 1, lastContact: '5 days ago', avatarColor: AppColors.kGold, initials: 'AB'),
  ];

  List<_MockClient> get _filtered => _search.isEmpty
      ? _clients
      : _clients.where((c) => c.name.toLowerCase().contains(_search.toLowerCase())).toList();

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;

    return Scaffold(
      backgroundColor: AppColors.kBgDeep,
      appBar: AppBar(
        backgroundColor: AppColors.kBgSurface,
        title: Text('My Clients', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700)),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.kBrand.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('${_clients.length} total',
                    style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.kBrand)),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.kBgSurface,
              border: const Border(bottom: BorderSide(color: AppColors.kBorder)),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.kBgElevated,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.kBorder),
              ),
              child: TextField(
                onChanged: (v) => setState(() => _search = v),
                style: GoogleFonts.plusJakartaSans(color: AppColors.kTextPrimary, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Search by name...',
                  hintStyle: GoogleFonts.plusJakartaSans(color: AppColors.kTextTertiary, fontSize: 14),
                  prefixIcon: const Icon(Icons.search_rounded, color: AppColors.kBrand, size: 20),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),

          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.group_off_rounded, size: 64, color: AppColors.kTextTertiary),
                        const SizedBox(height: 16),
                        Text('No clients found', style: GoogleFonts.plusJakartaSans(fontSize: 16, color: AppColors.kTextSecondary)),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: filtered.length,
                    itemBuilder: (context, i) {
                      final client = filtered[i];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.kBgSurface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.kBorder),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: client.avatarColor.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Center(
                                child: Text(client.initials,
                                    style: GoogleFonts.plusJakartaSans(
                                        fontSize: 16, fontWeight: FontWeight.w800, color: client.avatarColor)),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(client.name,
                                          style: GoogleFonts.plusJakartaSans(
                                              fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.kTextPrimary)),
                                      const SizedBox(width: 8),
                                      if (client.activeCases > 0)
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: AppColors.kSuccess.withOpacity(0.15),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text('${client.activeCases} Active',
                                              style: GoogleFonts.plusJakartaSans(
                                                  fontSize: 9, fontWeight: FontWeight.w700, color: AppColors.kSuccess)),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text('${client.city} • ${client.totalCases} total cases • Last: ${client.lastContact}',
                                      style: GoogleFonts.plusJakartaSans(
                                          fontSize: 11, color: AppColors.kTextSecondary)),
                                ],
                              ),
                            ),
                            const Icon(Icons.more_vert_rounded, color: AppColors.kTextTertiary, size: 20),
                          ],
                        ),
                      ).animate(delay: (i * 50).ms).fadeIn(duration: 300.ms).slideY(begin: 0.1);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
