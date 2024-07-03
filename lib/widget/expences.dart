import 'package:extenditure_app/widget/chart/chart.dart';
import 'package:extenditure_app/widget/expances_list/expenses_list.dart';
import 'package:extenditure_app/model/expense.dart';
import 'package:extenditure_app/widget/new_expence.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _regExpenses = [
    Expense(
      title: 'Food hahaha',
      amount: 99.99,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'pokhara',
      amount: 9000.00,
      date: DateTime.now(),
      category: Category.travel,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _regExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _regExpenses.indexOf(expense);
    setState(
      () {
        _regExpenses.remove(expense);
      },
    );
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text('Expense removed'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _regExpenses.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: Text('No expenses yet'),
    );
    if (_regExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _regExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense traker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _regExpenses),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
