import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BudgetDatabase{
  static final BudgetDatabase instance = BudgetDatabase._internal();

  static Database? _database;
  BudgetDatabase._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    try {
      final databasePath = await getDatabasesPath();
      final path = join(databasePath, "budget.db");
      return await openDatabase(
        path,
        version: 2,
        onCreate: _createDatabase,
      );
    }catch(e){
      print("INIT DB ERROR :: ${e}");
      throw e;
    }
  }

  Future<void> _createDatabase(Database db, int version) async {
    // Categories Table
    await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      )
    ''');

    // Expenses Table
    await db.execute('''
      CREATE TABLE expenses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        categoryId INTEGER NOT NULL,
        amount REAL NOT NULL,
        date TEXT NOT NULL,
        note TEXT,
        FOREIGN KEY (categoryId) REFERENCES categories (id)
      )
    ''');

    // Budget Table
    await db.execute('''
      CREATE TABLE budget (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL,
        amount REAL NOT NULL,
        remaining REAL NOT NULL
      )
    ''');

    // Insert dummy data
    await _insertDummyData(db);

  }

  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
    }
  }

  // CRUD Operations
  Future<int> addCategory(String name) async {
    final db = await BudgetDatabase.instance.database;
    return await db.insert('categories', {'name': name});
  }

  Future<void> addExpense(int categoryId, double amount, String date, String note) async {
    final db = await BudgetDatabase.instance.database;
    await db.transaction((txn) async {
      await txn.insert('expenses', {
        'categoryId': categoryId,
        'amount': amount,
        'date': date,
        'note': note,
      });

      await txn.rawUpdate('''
      UPDATE budget
      SET remaining = remaining - ?
      WHERE id = 1
    ''', [amount]);
    });

  }

  Future<List<Map<String, dynamic>>> getExpenses() async {
    final db = await BudgetDatabase.instance.database;
    return await db.rawQuery('''
    SELECT expenses.id, expenses.amount, expenses.date, expenses.note,
           categories.name AS categoryName
    FROM expenses
    INNER JOIN categories ON expenses.categoryId = categories.id
  ''');
  }

  Future<List<Map<String, dynamic>>> getExpensesByCategory(int categoryId) async {
    final db = await BudgetDatabase.instance.database;
    return await db.query(
      'expenses',
      where: 'categoryId = ?',
      whereArgs: [categoryId],
    );
  }

  Future<List<Map<String, dynamic>>> getAllBudgets() async {
    final db = await BudgetDatabase.instance.database;
    return await db.query('budget');
  }

  Future<List<Map<String, dynamic>>> getAllCategories() async{
    final db = await BudgetDatabase.instance.database;
    return await db.query('categories');
  }

  Future<double> getTotalExpenses() async {
    final db = await BudgetDatabase.instance.database;
    final result = await db.rawQuery('SELECT SUM(amount) as total FROM expenses');
    if (result.isNotEmpty && result.first['total'] != null) {
      return result.first['total'] as double;
    }
    return 0.0;
  }

  Future<List<Map<String, dynamic>>> getTotalExpensesByCategory() async {
    final db = await BudgetDatabase.instance.database;

    final result = await db.rawQuery('''
    SELECT 
      categories.name AS categoryName, 
      SUM(expenses.amount) AS totalAmount
    FROM expenses
    INNER JOIN categories ON expenses.categoryId = categories.id
    GROUP BY expenses.categoryId
  ''');

    return result;
  }

  Future<void> _insertDummyData(Database db) async {
    final dummyCategories = [
      {'name': 'Food & Beverage'},
      {'name': 'Transport & Fuel'},
      {'name': 'Clothing'},
      {'name': 'Entertainment'},
      {'name': 'Transaction Fees'},
    ];

    for (var category in dummyCategories) {
      await db.insert('categories', category);
    }

    await db.insert('budget', {
      'date': DateTime.now().toIso8601String(),
      'amount': 300000.0,
      'remaining' : 300000.0,
    },);
  }

}