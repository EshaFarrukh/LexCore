class CaseStats {
  final int total;
  final int won;
  final int lost;
  final int pending;
  final int disposed;
  final double winRate;
  final List<MonthlyData> monthly;
  final Map<String, int> byCategory;

  CaseStats({
    required this.total,
    required this.won,
    required this.lost,
    required this.pending,
    required this.disposed,
    required this.winRate,
    required this.monthly,
    required this.byCategory,
  });
}

class MonthlyData {
  final String month;
  final int cases;
  final double earnings;
  MonthlyData({required this.month, required this.cases, required this.earnings});
}

class LocalAnalyticsService {
  static LocalAnalyticsService? _instance;
  static LocalAnalyticsService get instance =>
      _instance ??= LocalAnalyticsService._();
  LocalAnalyticsService._();

  CaseStats getLawyerStats() {
    return CaseStats(
      total: 47,
      won: 34,
      lost: 8,
      pending: 12,
      disposed: 35,
      winRate: 81.0,
      monthly: [
        MonthlyData(month: 'Jan', cases: 3, earnings: 24000),
        MonthlyData(month: 'Feb', cases: 5, earnings: 38000),
        MonthlyData(month: 'Mar', cases: 4, earnings: 31000),
        MonthlyData(month: 'Apr', cases: 6, earnings: 52000),
        MonthlyData(month: 'May', cases: 7, earnings: 61000),
        MonthlyData(month: 'Jun', cases: 8, earnings: 72000),
        MonthlyData(month: 'Jul', cases: 5, earnings: 44000),
        MonthlyData(month: 'Aug', cases: 9, earnings: 78000),
      ],
      byCategory: {
        'Criminal': 18,
        'Civil': 12,
        'Family': 9,
        'Property': 5,
        'Contract': 3,
      },
    );
  }

  double getCurrentMonthEarnings() => 72000;
  double getTotalEarnings() => 400000;
  int getPendingPayments() => 3;
}
