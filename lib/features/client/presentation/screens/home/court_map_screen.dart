import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lex_core/core/constants/app_colors.dart';

class _Court {
  final String name;
  final String city;
  final String type;
  final String hours;
  final double lat;
  final double lng;
  final double rating;
  const _Court(this.name, this.city, this.type, this.hours, this.lat, this.lng, this.rating);
}

class CourtMapScreen extends StatefulWidget {
  const CourtMapScreen({super.key});

  @override
  State<CourtMapScreen> createState() => _CourtMapScreenState();
}

class _CourtMapScreenState extends State<CourtMapScreen> {
  final _mapController = MapController();
  String _searchQuery = '';

  static const List<_Court> _courts = [
    _Court('Supreme Court of Pakistan', 'Islamabad', 'Supreme', 'Mon–Fri: 8:00 AM – 3:00 PM', 33.7215, 73.0887, 4.9),
    _Court('Lahore High Court', 'Lahore', 'High', 'Mon–Fri: 8:00 AM – 3:00 PM', 31.5497, 74.3436, 4.7),
    _Court('Sindh High Court', 'Karachi', 'High', 'Mon–Fri: 8:30 AM – 3:30 PM', 24.8607, 67.0011, 4.6),
    _Court('Peshawar High Court', 'Peshawar', 'High', 'Mon–Fri: 8:00 AM – 2:30 PM', 34.0151, 71.5249, 4.5),
    _Court('Balochistan High Court', 'Quetta', 'High', 'Mon–Fri: 8:00 AM – 2:00 PM', 30.1798, 66.9750, 4.3),
    _Court('Islamabad District Court', 'Islamabad', 'Sessions', 'Mon–Fri: 8:00 AM – 4:00 PM', 33.7294, 73.0931, 4.4),
    _Court('Lahore Sessions Court', 'Lahore', 'Sessions', 'Mon–Fri: 8:00 AM – 4:00 PM', 31.5604, 74.3587, 4.2),
    _Court('Karachi Civil Court', 'Karachi', 'Civil', 'Mon–Fri: 8:30 AM – 4:00 PM', 24.8608, 67.0104, 4.1),
    _Court('Rawalpindi District Court', 'Rawalpindi', 'Sessions', 'Mon–Fri: 8:00 AM – 4:00 PM', 33.5651, 73.0169, 4.0),
    _Court('Faisalabad District Court', 'Faisalabad', 'Sessions', 'Mon–Fri: 8:00 AM – 3:30 PM', 31.4504, 73.1350, 3.9),
    _Court('Multan District Court', 'Multan', 'Sessions', 'Mon–Fri: 8:00 AM – 3:00 PM', 30.1575, 71.5249, 4.0),
    _Court('Federal Shariat Court', 'Islamabad', 'Shariat', 'Mon–Fri: 8:00 AM – 3:00 PM', 33.7300, 73.0900, 4.5),
    _Court('Lahore Family Court', 'Lahore', 'Family', 'Mon–Fri: 8:30 AM – 4:00 PM', 31.5553, 74.3572, 3.8),
    _Court('Hyderabad District Court', 'Hyderabad', 'Sessions', 'Mon–Fri: 8:30 AM – 3:30 PM', 25.3960, 68.3578, 3.9),
    _Court('Gujranwala Sessions Court', 'Gujranwala', 'Sessions', 'Mon–Fri: 8:00 AM – 3:30 PM', 32.1877, 74.1945, 3.8),
  ];

  List<_Court> get _filtered => _searchQuery.isEmpty
      ? _courts
      : _courts.where((c) => c.name.toLowerCase().contains(_searchQuery) || c.city.toLowerCase().contains(_searchQuery)).toList();

  void _showCourtSheet(_Court court) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.kBgSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.kBorder, borderRadius: BorderRadius.circular(2))),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  width: 48, height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.kBrand.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.account_balance_rounded, color: AppColors.kBrand, size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(court.name, style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.kTextPrimary)),
                      Text(court.city, style: GoogleFonts.plusJakartaSans(fontSize: 13, color: AppColors.kTextSecondary)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.kGold.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.star_rounded, color: AppColors.kGold, size: 16),
                      const SizedBox(width: 4),
                      Text(court.rating.toString(), style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.kGold)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _infoRow(Icons.access_time_rounded, 'Hours', court.hours),
            const SizedBox(height: 12),
            _infoRow(Icons.category_rounded, 'Court Type', '${court.type} Court'),
            const SizedBox(height: 12),
            _infoRow(Icons.location_on_rounded, 'Coordinates', '${court.lat.toStringAsFixed(4)}°N, ${court.lng.toStringAsFixed(4)}°E'),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  final url = 'https://www.google.com/maps/search/?api=1&query=${court.lat},${court.lng}';
                  launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                },
                icon: const Icon(Icons.directions_rounded),
                label: Text('Get Directions', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.kBrand,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.kTextSecondary),
        const SizedBox(width: 10),
        Text('$label: ', style: GoogleFonts.plusJakartaSans(fontSize: 13, color: AppColors.kTextSecondary)),
        Expanded(
          child: Text(value, style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.kTextPrimary)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBgDeep,
      body: Stack(
        children: [
          // Map
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: const LatLng(30.3753, 69.3451),
              initialZoom: 5.5,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.lexcore.app',
              ),
              MarkerLayer(
                markers: _filtered.map((c) {
                  return Marker(
                    point: LatLng(c.lat, c.lng),
                    width: 44,
                    height: 44,
                    child: GestureDetector(
                      onTap: () => _showCourtSheet(c),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: AppColors.kBrandGradient,
                          borderRadius: BorderRadius.circular(22),
                          boxShadow: [BoxShadow(color: AppColors.kBrandGlow, blurRadius: 10, spreadRadius: 2)],
                        ),
                        child: const Icon(Icons.account_balance_rounded, color: Colors.white, size: 20),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),

          // Search bar overlay
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            left: 16,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.kBgSurface.withOpacity(0.95),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.kBorder),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 16)],
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: AppColors.kTextPrimary),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (v) => setState(() => _searchQuery = v.toLowerCase()),
                      style: GoogleFonts.plusJakartaSans(color: AppColors.kTextPrimary, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Search courts by city...',
                        hintStyle: GoogleFonts.plusJakartaSans(color: AppColors.kTextTertiary, fontSize: 14),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: Icon(Icons.search_rounded, color: AppColors.kBrand, size: 22),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.2),
          ),

          // Court count badge
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 24,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.kBgSurface.withOpacity(0.95),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.kBorder),
              ),
              child: Text('${_filtered.length} courts found',
                  style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.kTextSecondary, fontWeight: FontWeight.w500)),
            ),
          ),
        ],
      ),
    );
  }
}
