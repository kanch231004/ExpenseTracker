import 'package:flutter/material.dart';

class Expense {
  final String id;
  final String title;
  final double amount;
  final ExpenseCategory category;
  final DateTime date;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
  });
}

enum ExpenseCategory {
  food,
  transport,
  shopping,
  health,
  entertainment,
  bills,
  education,
  travel,
}

extension ExpenseCategoryExtension on ExpenseCategory {
  String get name {
    switch (this) {
      case ExpenseCategory.food:
        return 'Food';
      case ExpenseCategory.transport:
        return 'Transport';
      case ExpenseCategory.shopping:
        return 'Shopping';
      case ExpenseCategory.health:
        return 'Health';
      case ExpenseCategory.entertainment:
        return 'Entertainment';
      case ExpenseCategory.bills:
        return 'Bills';
      case ExpenseCategory.education:
        return 'Education';
      case ExpenseCategory.travel:
        return 'Travel';
    }
  }

  String get icon {
    switch (this) {
      case ExpenseCategory.food:
        return '🍽️';
      case ExpenseCategory.transport:
        return '🚗';
      case ExpenseCategory.shopping:
        return '🛍️';
      case ExpenseCategory.health:
        return '🏥';
      case ExpenseCategory.entertainment:
        return '🎬';
      case ExpenseCategory.bills:
        return '💡';
      case ExpenseCategory.education:
        return '📚';
      case ExpenseCategory.travel:
        return '✈️';
    }
  }

  Color get color {
    switch (this) {
      case ExpenseCategory.food:
        return const Color(0xFF10B981);
      case ExpenseCategory.transport:
        return const Color(0xFF3B82F6);
      case ExpenseCategory.shopping:
        return const Color(0xFFF59E0B);
      case ExpenseCategory.health:
        return const Color(0xFFEF4444);
      case ExpenseCategory.entertainment:
        return const Color(0xFFEF4444);
      case ExpenseCategory.bills:
        return const Color(0xFF8B5CF6);
      case ExpenseCategory.education:
        return const Color(0xFF06B6D4);
      case ExpenseCategory.travel:
        return const Color(0xFFF97316);
    }
  }
}