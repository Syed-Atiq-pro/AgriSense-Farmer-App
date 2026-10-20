import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../theme/app_theme.dart';
import '../widgets/interactive_widgets.dart';
import '../providers/expense_provider.dart';
import '../models/expense.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ExpenseProvider>(context);

    return Scaffold(
      backgroundColor: AppTheme.softBg,
      appBar: AppBar(title: const Text('Expense & Profit')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Row(
              children: [
                Expanded(
                  child: InteractiveCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Income', style: TextStyle(color: AppTheme.textGrey, fontSize: 13)),
                        const SizedBox(height: 8),
                        Text(
                          '₹${provider.totalIncome.toStringAsFixed(0)}',
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppTheme.primary),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: InteractiveCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Expense', style: TextStyle(color: AppTheme.textGrey, fontSize: 13)),
                        const SizedBox(height: 8),
                        Text(
                          '₹${provider.totalExpense.toStringAsFixed(0)}',
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppTheme.danger),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Profit Banner
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InteractiveCard(
              color: provider.profit >= 0 ? AppTheme.primary : AppTheme.danger,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Net Profit', style: TextStyle(color: Colors.white, fontSize: 16)),
                  Text(
                    '₹${provider.profit.toStringAsFixed(0)}',
                    style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: provider.expenses.length,
              itemBuilder: (context, index) {
                final item = provider.expenses[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: InteractiveCard(
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: (item.isIncome ? AppTheme.primary : AppTheme.danger).withOpacity(0.12),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            item.isIncome ? Icons.trending_up_rounded : Icons.trending_down_rounded,
                            color: item.isIncome ? AppTheme.primary : AppTheme.danger,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15.5)),
                              const SizedBox(height: 2),
                              Text(
                                '${item.category} • ${DateFormat('dd MMM').format(item.date)}',
                                style: const TextStyle(color: AppTheme.textGrey, fontSize: 12.5),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '${item.isIncome ? '+' : '-'}₹${item.amount.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: item.isIncome ? AppTheme.primary : AppTheme.danger,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: SoftButton(
        text: 'Add Entry',
        icon: Icons.add_rounded,
        onPressed: () => _showAddDialog(context),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final titleController = TextEditingController();
    final amountController = TextEditingController();
    bool isIncome = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: const Text('Add Entry'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  prefixText: '₹ ',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
              const SizedBox(height: 10),
              SwitchListTile(
                title: Text(isIncome ? 'Income' : 'Expense'),
                value: isIncome,
                activeColor: AppTheme.primary,
                onChanged: (val) => setState(() => isIncome = val),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            SoftButton(
              text: 'Save',
              onPressed: () {
                if (titleController.text.isNotEmpty && amountController.text.isNotEmpty) {
                  Provider.of<ExpenseProvider>(context, listen: false).addExpense(
                    Expense(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      title: titleController.text.trim(),
                      amount: double.tryParse(amountController.text) ?? 0,
                      date: DateTime.now(),
                      isIncome: isIncome,
                      category: isIncome ? 'Income' : 'Expense',
                    ),
                  );
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}