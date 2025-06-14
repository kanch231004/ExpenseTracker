import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expense_list.dart';

void main() {
  runApp(const ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const ExpenseListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
