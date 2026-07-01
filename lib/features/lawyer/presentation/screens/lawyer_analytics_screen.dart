import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/mock_services/local_analytics_service.dart';
import 'package:fl_chart/fl_chart.dart';

class LawyerAnalyticsScreen extends StatelessWidget {
  const LawyerAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = LocalAnalyticsService.instance.getLawyerStats();

    return Scaffold(
      backgroundColor: AppColors.kBgDeep,
      appBar: AppBar(
        backgroundColor: AppColors.kBgSurface,
        title: Text('Analytics', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick stats row
            Row(
              children: [
                _statMini('Total', '${stats.total}', Icons.folder_rounded, AppColors.kBrand),
                const SizedBox(width: 10),
                _statMini('Won', '${stats.won}', Icons.check_circle_rounded, AppColors.kSuccess),
                const SizedBox(width: 10),
                _statMini('Pending', '${stats.pending}', Icons.pending_rounded, AppColors.kWarning),
                const SizedBox(width: 10),
                _statMini('Win Rate', '${stats.winRate.toInt()}%', Icons.trending_up_rounded, AppColors.kGold),
              ].animate(interval: 100.ms).fadeIn(duration: 400.ms).slideY(begin: 0.2),
            ),
            const SizedBox(height: 28),

            // Monthly Cases Bar Chart
            _sectionTitle('Monthly Case Load'),
            const SizedBox(height: 16),
            Container(
              height: 220,
              padding: const EdgeInsets.fromLTRB(12, 20, 20, 12),
              decoration: _cardDecoration(),
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 12,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: (_) => AppColors.kBgElevated,
                      tooltipRoundedRadius: 8,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                          '${stats.monthly[group.x].month}: ${rod.toY.toInt()} cases',
                          GoogleFonts.plusJakartaSans(color: AppColors.kTextPrimary, fontSize: 12),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (val, meta) => Text(
                          stats.monthly[val.toInt()].month,
                          style: GoogleFonts.plusJakartaSans(color: AppColors.kTextSecondary, fontSize: 10),
                        ),
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        getTitlesWidget: (val, meta) {
                          if (val % 3 != 0) return const SizedBox.shrink();
                          return Text('${val.toInt()}', style: GoogleFonts.plusJakartaSans(color: AppColors.kTextTertiary, fontSize: 10));
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (val) =>
                        FlLine(color: AppColors.kBorder.withOpacity(0.3), strokeWidth: 1),
                  ),
                  barGroups: stats.monthly.asMap().entries.map((e) {
                    return BarChartGroupData(
                      x: e.key,
                      barRods: [
                        BarChartRodData(
                          toY: e.value.cases.toDouble(),
                          width: 18,
                          color: AppColors.kBrand,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                          ),
                          backDrawRodData: BackgroundBarChartRodData(
                            show: true,
                            toY: 12,
                            color: AppColors.kBorder.withOpacity(0.2),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ).animate(delay: 300.ms).fadeIn(duration: 500.ms).slideY(begin: 0.1),
            const SizedBox(height: 28),

            // Win/Loss Pie Chart
            _sectionTitle('Case Outcomes'),
            const SizedBox(height: 16),
            Container(
              height: 250,
              padding: const EdgeInsets.all(20),
              decoration: _cardDecoration(),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: PieChart(
                      PieChartData(
                        centerSpaceRadius: 40,
                        sectionsSpace: 3,
                        sections: [
                          PieChartSectionData(
                            value: stats.won.toDouble(),
                            color: AppColors.kSuccess,
                            title: '${stats.won}',
                            radius: 60,
                            titleStyle: GoogleFonts.plusJakartaSans(
                                fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                          ),
                          PieChartSectionData(
                            value: stats.lost.toDouble(),
                            color: AppColors.kError,
                            title: '${stats.lost}',
                            radius: 60,
                            titleStyle: GoogleFonts.plusJakartaSans(
                                fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                          ),
                          PieChartSectionData(
                            value: 5,
                            color: AppColors.kWarning,
                            title: '5',
                            radius: 60,
                            titleStyle: GoogleFonts.plusJakartaSans(
                                fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _legendItem('Won', stats.won, AppColors.kSuccess),
                        const SizedBox(height: 12),
                        _legendItem('Lost', stats.lost, AppColors.kError),
                        const SizedBox(height: 12),
                        _legendItem('Settled', 5, AppColors.kWarning),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate(delay: 500.ms).fadeIn(duration: 500.ms).slideY(begin: 0.1),
            const SizedBox(height: 28),

            // Category Breakdown
            _sectionTitle('Practice Area Breakdown'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: _cardDecoration(),
              child: Column(
                children: stats.byCategory.entries.map((e) {
                  final maxVal = stats.byCategory.values.reduce((a, b) => a > b ? a : b);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(e.key,
                                style: GoogleFonts.plusJakartaSans(
                                    color: AppColors.kTextPrimary, fontSize: 13, fontWeight: FontWeight.w500)),
                            Text('${e.value} cases',
                                style: GoogleFonts.plusJakartaSans(
                                    color: AppColors.kTextSecondary, fontSize: 12)),
                          ],
                        ),
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: e.value / maxVal,
                            backgroundColor: AppColors.kBorder.withOpacity(0.3),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              _getCategoryColor(e.key),
                            ),
                            minHeight: 8,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ).animate(delay: 700.ms).fadeIn(duration: 500.ms).slideY(begin: 0.1),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _statMini(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.kBgSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.kBorder),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 8),
            Text(value,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.kTextPrimary)),
            const SizedBox(height: 2),
            Text(label,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 10, color: AppColors.kTextSecondary, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(text,
        style: GoogleFonts.plusJakartaSans(
            fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.kTextPrimary));
  }

  Widget _legendItem(String label, int value, Color color) {
    return Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3))),
        const SizedBox(width: 8),
        Expanded(
          child: Text('$label ($value)',
              style: GoogleFonts.plusJakartaSans(color: AppColors.kTextSecondary, fontSize: 12)),
        ),
      ],
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Criminal': return AppColors.kError;
      case 'Civil': return AppColors.kBrand;
      case 'Family': return AppColors.kSuccess;
      case 'Property': return AppColors.kGold;
      default: return AppColors.kBrandLight;
    }
  }

  BoxDecoration _cardDecoration() => BoxDecoration(
        color: AppColors.kBgSurface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.kBorder),
      );
}
