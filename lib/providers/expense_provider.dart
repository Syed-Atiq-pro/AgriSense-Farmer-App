import 'package:flutter/material.dart';
import '../models/expense.dart';

class ExpenseProvider with ChangeNotifier {
  final List<Expense> _expenses = [
    Expense(
      id: '1',
      title: 'Sold Wheat',
      amount: 45000,
      date: DateTime.now().subtract(const Duration(days: 3)),
      isIncome: true,
      category: 'Crop Sale',
    ),
    Expense(
      id: '2',
      title: 'Fertilizer',
      amount: 3200,
      date: DateTime.now().subtract(const Duration(days: 5)),
      isIncome: false,
      category: 'Input',
    ),
    Expense(
      id: '3',
      title: 'Diesel',
      amount: 1800,
      date: DateTime.now().subtract(const Duration(days: 1)),
      isIncome: false,
      category: 'Fuel',
    ),
  ];

  List<Expense> get expenses => _expenses;

  double get totalIncome =>
      _expenses.where((e) => e.isIncome).fold(0, (sum, e) => sum + e.amount);

  double get totalExpense =>
      _expenses.where((e) => !e.isIncome).fold(0, (sum, e) => sum + e.amount);

  double get profit => totalIncome - totalExpense;

  void addExpense(Expense expense) {
    _expenses.insert(0, expense);
    notifyListeners();
  }
}