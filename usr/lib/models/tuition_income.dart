class TuitionIncome {
  final String studentName;
  final double amount;
  final DateTime date;
  final String? notes;

  TuitionIncome({
    required this.studentName,
    required this.amount,
    required this.date,
    this.notes,
  });
}
