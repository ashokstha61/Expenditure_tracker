import 'package:extenditure_app/widget/expances_list/expences_item.dart';
import 'package:flutter/material.dart';
import 'package:extenditure_app/model/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });
  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: ((ctx, index) {
        return Dismissible(
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.75),
            margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal,
            ),
          ),
          key: ValueKey(expenses[index]),
          child: ExpencesItem(expenses[index]),
          onDismissed: (direction) {
            onRemoveExpense(expenses[index]);
          },
        );
      }),
    );
  }
}
