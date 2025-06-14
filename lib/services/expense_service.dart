import '../models/expense.dart';

class ExpenseService {
  static final ExpenseService _instance = ExpenseService._internal();
  factory ExpenseService() => _instance;
  ExpenseService._internal();

  final List<Expense> _expenses = [];

  List<Expense> get expenses => List.unmodifiable(_expenses);

  void addExpense(Expense expense) {
    _expenses.insert(0, expense); // Add to beginning for newest first
  }

  void removeExpense(String id) {
    _expenses.removeWhere((expense) => expense.id == id);
  }

  double get totalAmount {
    return _expenses.fold(0, (sum, expense) => sum + expense.amount);
  }
}
