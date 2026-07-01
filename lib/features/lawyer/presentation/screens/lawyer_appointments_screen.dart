import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lex_core/core/constants/app_colors.dart';

class _Appointment {
  final String clientName;
  final String date;
  final String time;
  final String type;
  final bool isPast;

  const _Appointment(this.clientName, this.date, this.time, this.type, this.isPast);
}

class LawyerAppointmentsScreen extends StatelessWidget {
  const LawyerAppointmentsScreen({super.key});

  final List<_Appointment> _appointments = const [
    _Appointment('Ali Khan', 'Today', '02:00 PM', 'Video Call', false),
    _Appointment('Fatima Bibi', 'Today', '05:30 PM', 'In Person', false),
    _Appointment('Zainab Ali', 'Tomorrow', '10:00 AM', 'Video Call', false),
    _Appointment('Ahmed Raza', 'Yesterday', '11:00 AM', 'Video Call', true),
    _Appointment('Usman Tariq', 'Mon, Oct 20', '03:00 PM', 'In Person', true),
  ];

  @override
  Widget build(BuildContext context) {
    final upcoming = _appointments.where((a) => !a.isPast).toList();
    final past = _appointments.where((a) => a.isPast).toList();

    return Scaffold(
      backgroundColor: AppColors.kBgDeep,
      appBar: AppBar(
        backgroundColor: AppColors.kBgSurface,
        title: Text('Appointments', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Upcoming', style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.kTextPrimary)),
            const SizedBox(height: 16),
            ...upcoming.map((a) => _buildCard(a, false)),
            const SizedBox(height: 32),
            Text('Past', style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.kTextPrimary)),
            const SizedBox(height: 16),
            ...past.map((a) => _buildCard(a, true)),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(_Appointment a, bool isPast) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.kBgSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isPast ? AppColors.kBorder : AppColors.kBrand.withOpacity(0.3)),
        boxShadow: isPast ? null : [BoxShadow(color: AppColors.kBrand.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Row(
        children: [
          Container(
            width: 48, height: 48,
            decoration: BoxDecoration(
              color: isPast ? AppColors.kBgElevated : AppColors.kBrand.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(a.type == 'Video Call' ? Icons.videocam_rounded : Icons.storefront_rounded,
                color: isPast ? AppColors.kTextTertiary : AppColors.kBrand),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(a.clientName, style: GoogleFonts.plusJakartaSans(fontSize: 15, fontWeight: FontWeight.w700, color: isPast ? AppColors.kTextSecondary : AppColors.kTextPrimary)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.schedule_rounded, size: 12, color: AppColors.kTextTertiary),
                    const SizedBox(width: 4),
                    Text('${a.date} at ${a.time}', style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.kTextSecondary)),
                  ],
                ),
              ],
            ),
          ),
          if (!isPast) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.kBrand,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(a.type == 'Video Call' ? 'Join' : 'Details', style: GoogleFonts.plusJakartaSans(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white)),
            ),
          ],
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.1);
  }
}
