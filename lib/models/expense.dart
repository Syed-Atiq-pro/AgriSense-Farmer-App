class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final bool isIncome; // true = income, false = expense
  final String category;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.isIncome,
    required this.category,
  });
}