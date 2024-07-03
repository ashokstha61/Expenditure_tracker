import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category {
  food,
  entertainment,
  travel,
  other,
}

final formatter = DateFormat.yMd();

const categoryIcons = {
  Category.food: Icons.fastfood,
  Category.entertainment: Icons.sports,
  Category.travel: Icons.travel_explore,
  Category.other: Icons.games,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate => formatter.format(date);
}

class ExpenseData {
  ExpenseData({
    required this.category,
    required this.expenses,
  });

  ExpenseData.forCategory(List<Expense> allexpenses, this.category)
      : expenses = allexpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;
  double get totalAmount {
    double sum = 0;
    for (var expense in expenses) {
      sum += expense.amount; //sum=sum + expense.amount
    }
    return sum;
  }
}
