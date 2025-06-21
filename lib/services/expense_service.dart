import '../models/expense.dart';
import 'api_service.dart';

class ExpenseService {
  static final ExpenseService _instance = ExpenseService._internal();
  factory ExpenseService() => _instance;
  ExpenseService._internal();

  List<Expense> _expenses = [];
  bool _isLoaded = false;

  List<Expense> get expenses => List.unmodifiable(_expenses);

  // Load expenses from server
  Future<void> loadExpenses() async {
    try {
      print('🔄 Loading expenses from server...');
      _expenses = await ApiService.getAllExpenses();
      _isLoaded = true;
      print('✅ Loaded ${_expenses.length} expenses from server');
    } catch (e) {
      print('❌ Failed to load expenses: $e');
      _expenses = [];
      _isLoaded = true;
      throw Exception('Failed to load expenses from server');
    }
  }

  // Add expense to server
  Future<void> addExpense(Expense expense) async {
    try {
      print('🔄 Saving expense to server...');
      final savedExpense = await ApiService.addExpense(expense);

      // Add to local list (for immediate UI update)
      _expenses.insert(0, savedExpense);

      print('✅ Expense saved to server: ${savedExpense.title}');
    } catch (e) {
      print('❌ Failed to save expense: $e');
      throw Exception('Failed to save expense to server');
    }
  }

  // Remove expense from server
  Future<void> removeExpense(String id) async {
    try {
      print('🔄 Deleting expense from server...');
      await ApiService.deleteExpense(id);

      // Remove from local list
      _expenses.removeWhere((expense) => expense.id == id);

      print('✅ Expense deleted from server');
    } catch (e) {
      print('❌ Failed to delete expense: $e');
      throw Exception('Failed to delete expense from server');
    }
  }

  // Get total amount
  double get totalAmount {
    return _expenses.fold(0, (sum, expense) => sum + expense.amount);
  }

  // Refresh data from server
  Future<void> refresh() async {
    print('🔄 Refreshing data from server...');
    _isLoaded = false;
    await loadExpenses();
  }
}