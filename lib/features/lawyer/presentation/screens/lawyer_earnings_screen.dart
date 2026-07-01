import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/mock_services/earnings_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lex_core/core/mock_services/local_analytics_service.dart';

class LawyerEarningsScreen extends StatelessWidget {
  const LawyerEarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = EarningsService.instance;
    final analytics = LocalAnalyticsService.instance;
    final stats = analytics.getLawyerStats();

    return Scaffold(
      backgroundColor: AppColors.kBgDeep,
      appBar: AppBar(
        backgroundColor: AppColors.kBgSurface,
        title: Text('Earnings', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Total earnings header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: AppColors.kBrandGradient,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text('Total Earnings',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 13, color: Colors.white70, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 4),
                  Text('Rs. ${service.totalEarnings.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 34, fontWeight: FontWeight.w800, color: Colors.white)),
                ],
              ),
            ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),
            const SizedBox(height: 16),

            // Quick stats
            Row(
              children: [
                _quickCard('This Month', 'Rs. 72,000', AppColors.kSuccess),
                const SizedBox(width: 10),
                _quickCard('Pending', 'Rs. ${service.totalPending.toStringAsFixed(0)}', AppColors.kWarning),
                const SizedBox(width: 10),
                _quickCard('Collected', 'Rs. ${service.totalPaid.toStringAsFixed(0)}', AppColors.kBrand),
              ],
            ).animate(delay: 200.ms).fadeIn(duration: 400.ms),
            const SizedBox(height: 28),

            // Earnings chart
            Text('Monthly Earnings',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.kTextPrimary)),
            const SizedBox(height: 16),
            Container(
              height: 200,
              padding: const EdgeInsets.fromLTRB(8, 16, 16, 8),
              decoration: BoxDecoration(
                color: AppColors.kBgSurface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.kBorder),
              ),
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 100000,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: (_) => AppColors.kBgElevated,
                      tooltipRoundedRadius: 8,
                      getTooltipItem: (group, gi, rod, ri) => BarTooltipItem(
                        'Rs. ${rod.toY.toInt()}',
                        GoogleFonts.plusJakartaSans(color: AppColors.kTextPrimary, fontSize: 11),
                      ),
                    ),
                  ),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (val, _) => Text(
                          stats.monthly[val.toInt()].month,
                          style: GoogleFonts.plusJakartaSans(color: AppColors.kTextTertiary, fontSize: 10),
                        ),
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  gridData: const FlGridData(show: false),
                  barGroups: stats.monthly.asMap().entries.map((e) {
                    return BarChartGroupData(
                      x: e.key,
                      barRods: [
                        BarChartRodData(
                          toY: e.value.earnings,
                          width: 16,
                          gradient: AppColors.kSuccessGradient,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ).animate(delay: 400.ms).fadeIn(duration: 500.ms),
            const SizedBox(height: 28),

            // Fee History
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Fee History',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.kTextPrimary)),
                Text('${EarningsService.records.length} records',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 12, color: AppColors.kTextSecondary)),
              ],
            ),
            const SizedBox(height: 12),
            ...EarningsService.records.asMap().entries.map((e) {
              final r = e.value;
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.kBgSurface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.kBorder),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: (r.isPaid ? AppColors.kSuccess : AppColors.kWarning).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        r.isPaid ? Icons.check_circle_rounded : Icons.pending_rounded,
                        color: r.isPaid ? AppColors.kSuccess : AppColors.kWarning,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(r.caseTitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.kTextPrimary)),
                          const SizedBox(height: 2),
                          Text('${r.caseNumber} · ${r.type}',
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 11, color: AppColors.kTextSecondary)),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Rs. ${r.amount.toStringAsFixed(0)}',
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.kTextPrimary)),
                        const SizedBox(height: 2),
                        Text(r.date,
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 10, color: AppColors.kTextTertiary)),
                      ],
                    ),
                  ],
                ),
              ).animate(delay: (e.key * 60).ms).fadeIn(duration: 300.ms).slideX(begin: 0.05);
            }),

            const SizedBox(height: 20),
            // Withdraw button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: AppColors.kBrandGradient,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ElevatedButton.icon(
                  onPressed: () => _showWithdrawDialog(context),
                  icon: const Icon(Icons.account_balance_wallet_rounded, color: Colors.white),
                  label: Text('Withdraw Earnings',
                      style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _quickCard(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.kBgSurface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.kBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: GoogleFonts.plusJakartaSans(fontSize: 10, color: AppColors.kTextSecondary, fontWeight: FontWeight.w500)),
            const SizedBox(height: 4),
            Text(value,
                style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w700, color: color)),
          ],
        ),
      ),
    );
  }

  void _showWithdrawDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.kBgSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Withdraw Funds',
            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, color: AppColors.kTextPrimary)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Transfer to linked bank account',
                style: GoogleFonts.plusJakartaSans(fontSize: 13, color: AppColors.kTextSecondary)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.kBgElevated,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('HBL Personal Account',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.kTextPrimary)),
                  Text('**** **** **** 4521',
                      style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.kTextSecondary)),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel', style: GoogleFonts.plusJakartaSans(color: AppColors.kTextSecondary)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Withdrawal processing... Funds will be transferred within 2-3 business days.',
                      style: GoogleFonts.plusJakartaSans()),
                  backgroundColor: AppColors.kSuccess,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.kBrand),
            child: Text('Confirm', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
