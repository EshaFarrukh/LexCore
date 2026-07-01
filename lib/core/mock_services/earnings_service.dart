class EarningRecord {
  final String id;
  final String caseNumber;
  final String caseTitle;
  final double amount;
  final bool isPaid;
  final String date;
  final String type;

  const EarningRecord({
    required this.id,
    required this.caseNumber,
    required this.caseTitle,
    required this.amount,
    required this.isPaid,
    required this.date,
    required this.type,
  });
}

class EarningsService {
  static final EarningsService instance = EarningsService._();
  EarningsService._();

  static const List<EarningRecord> records = [
    EarningRecord(id: '1', caseNumber: '2024-CR-001', caseTitle: 'State vs. Ahmed Khan', amount: 15000, isPaid: true, date: 'Jun 15, 2026', type: 'Court Appearance'),
    EarningRecord(id: '2', caseNumber: '2024-CV-023', caseTitle: 'Property Dispute - Raza vs Malik', amount: 25000, isPaid: true, date: 'Jun 10, 2026', type: 'Retainer'),
    EarningRecord(id: '3', caseNumber: '2024-FM-045', caseTitle: 'Divorce Proceedings - Ali Family', amount: 12000, isPaid: false, date: 'Jun 08, 2026', type: 'Consultation'),
    EarningRecord(id: '4', caseNumber: '2024-CR-067', caseTitle: 'Bail Application - Hussain', amount: 8000, isPaid: true, date: 'Jun 02, 2026', type: 'Document Review'),
    EarningRecord(id: '5', caseNumber: '2024-PT-012', caseTitle: 'Commercial Property Transfer', amount: 35000, isPaid: true, date: 'May 28, 2026', type: 'Retainer'),
    EarningRecord(id: '6', caseNumber: '2024-CV-089', caseTitle: 'Breach of Contract - Tech Corp', amount: 20000, isPaid: false, date: 'May 25, 2026', type: 'Court Appearance'),
    EarningRecord(id: '7', caseNumber: '2024-FM-034', caseTitle: 'Child Custody - Farooq vs Nadia', amount: 18000, isPaid: true, date: 'May 20, 2026', type: 'Retainer'),
    EarningRecord(id: '8', caseNumber: '2024-CR-102', caseTitle: 'Theft Case - District Court', amount: 6000, isPaid: true, date: 'May 15, 2026', type: 'Consultation'),
    EarningRecord(id: '9', caseNumber: '2024-PT-099', caseTitle: 'Land Revenue Mutation Dispute', amount: 22000, isPaid: false, date: 'May 10, 2026', type: 'Court Appearance'),
    EarningRecord(id: '10', caseNumber: '2024-CV-112', caseTitle: 'Contract Enforcement - Rashid & Sons', amount: 30000, isPaid: true, date: 'May 05, 2026', type: 'Retainer'),
  ];

  double get totalPaid =>
      records.where((r) => r.isPaid).fold(0.0, (s, r) => s + r.amount);
  double get totalPending =>
      records.where((r) => !r.isPaid).fold(0.0, (s, r) => s + r.amount);
  int get pendingCount => records.where((r) => !r.isPaid).length;
  double get totalEarnings =>
      records.fold(0.0, (s, r) => s + r.amount);
}
