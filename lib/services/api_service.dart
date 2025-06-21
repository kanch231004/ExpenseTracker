import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/expense.dart';

class ApiService {
  static const String baseUrl = 'https://pro-ant-largely.ngrok-free.app /api';
  static const Duration timeoutDuration = Duration(seconds: 10);

  // Get all expenses
  static Future<List<Expense>> getAllExpenses() async {
    try {
      print('📡 GET $baseUrl/expenses');

      final response = await http
          .get(
        Uri.parse('$baseUrl/expenses'),
        headers: {'Content-Type': 'application/json'},
      )
          .timeout(timeoutDuration);

      print('📡 Response status: ${response.statusCode}');
      print('📡 Response body: ${response.body}');

      if (response.statusCode  == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => _expenseFromJson(json)).toList();
      } else {
        throw HttpException('Failed to load expenses: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ API Error: $e');
      throw Exception('Error loading expenses: $e');
    }
  }

  // Add new expense
  static Future<Expense> addExpense(Expense expense) async {
    try {
      final payload = _expenseToJson(expense);
      print('📡 POST $baseUrl/expenses');
      print('📡 Payload: $payload');

      final response = await http
          .post(
        Uri.parse('$baseUrl/expenses'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      )
          .timeout(timeoutDuration);

      print('📡 Response status: ${response.statusCode}');
      print('📡 Response body: ${response.body}');

      if (response.statusCode == 201) {
        return _expenseFromJson(json.decode(response.body));
      } else {
        throw HttpException('Failed to add expense: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ API Error: $e');
      throw Exception('Error adding expense: $e');
    }
  }

  // Delete expense
  static Future<void> deleteExpense(String id) async {
    try {
      print('📡 DELETE $baseUrl/expenses/$id');

      final response = await http
          .delete(
        Uri.parse('$baseUrl/expenses/$id'),
        headers: {'Content-Type': 'application/json'},
      )
          .timeout(timeoutDuration);

      print('📡 Response status: ${response.statusCode}');

      if (response.statusCode != 200) {
        throw HttpException('Failed to delete expense: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ API Error: $e');
      throw Exception('Error deleting expense: $e');
    }
  }

  // Helper methods for JSON conversion
  static Map<String, dynamic> _expenseToJson(Expense expense) {
    return {
      'id': expense.id,
      'title': expense.title,
      'amount': expense.amount,
      'category': expense.category.name.toLowerCase(),
      'date': expense.date.toIso8601String(),
    };
  }

  static Expense _expenseFromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'].toString(),
      title: json['title'],
      amount: (json['amount'] as num).toDouble(),
      category: _getCategoryFromString(json['category']),
      date: DateTime.parse(json['date']),
    );
  }

  static ExpenseCategory _getCategoryFromString(String categoryString) {
    switch (categoryString.toLowerCase()) {
      case 'food':
        return ExpenseCategory.food;
      case 'transport':
        return ExpenseCategory.transport;
      case 'shopping':
        return ExpenseCategory.shopping;
      case 'health':
        return ExpenseCategory.health;
      case 'entertainment':
        return ExpenseCategory.entertainment;
      case 'bills':
        return ExpenseCategory.bills;
      case 'education':
        return ExpenseCategory.education;
      case 'travel':
        return ExpenseCategory.travel;
      default:
        return ExpenseCategory.food;
    }
  }
}