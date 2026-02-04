import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/employee.dart';

/// SQLite database helper for employee management
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  /// Get database instance
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// Initialize database
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'xyz_inc_employees.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  /// Create database tables
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE employees (
        id INTEGER PRIMARY KEY,
        first_name TEXT NOT NULL,
        last_name TEXT NOT NULL,
        designation TEXT NOT NULL,
        level INTEGER NOT NULL,
        productivity_score REAL NOT NULL,
        current_salary TEXT NOT NULL,
        employment_status INTEGER NOT NULL,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
        updated_at TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // Create index for faster queries
    await db.execute('''
      CREATE INDEX idx_designation ON employees(designation)
    ''');

    await db.execute('''
      CREATE INDEX idx_level ON employees(level)
    ''');

    await db.execute('''
      CREATE INDEX idx_name ON employees(first_name, last_name)
    ''');
  }

  /// Handle database upgrades
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle future schema changes
  }

  /// Insert or update employee
  Future<int> insertEmployee(Employee employee) async {
    final db = await database;
    return await db.insert(
      'employees',
      employee.toDatabase(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Insert multiple employees
  Future<void> insertEmployees(List<Employee> employees) async {
    final db = await database;
    final batch = db.batch();

    for (final employee in employees) {
      batch.insert(
        'employees',
        employee.toDatabase(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  /// Get all employees
  Future<List<Employee>> getAllEmployees() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'employees',
      orderBy: 'first_name ASC',
    );

    return maps.map((map) => Employee.fromDatabase(map)).toList();
  }

  /// Get employee by ID
  Future<Employee?> getEmployeeById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'employees',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isEmpty) return null;
    return Employee.fromDatabase(maps.first);
  }

  /// Search employees by name
  Future<List<Employee>> searchEmployeesByName(String query) async {
    final db = await database;
    final searchQuery = '%$query%';

    final List<Map<String, dynamic>> maps = await db.query(
      'employees',
      where: 'first_name LIKE ? OR last_name LIKE ?',
      whereArgs: [searchQuery, searchQuery],
      orderBy: 'first_name ASC',
    );

    return maps.map((map) => Employee.fromDatabase(map)).toList();
  }

  /// Filter employees by designation
  Future<List<Employee>> filterByDesignation(String designation) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'employees',
      where: 'designation = ?',
      whereArgs: [designation],
      orderBy: 'first_name ASC',
    );

    return maps.map((map) => Employee.fromDatabase(map)).toList();
  }

  /// Filter employees by level
  Future<List<Employee>> filterByLevel(int level) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'employees',
      where: 'level = ?',
      whereArgs: [level],
      orderBy: 'first_name ASC',
    );

    return maps.map((map) => Employee.fromDatabase(map)).toList();
  }

  /// Get all unique designations
  Future<List<String>> getAllDesignations() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      'SELECT DISTINCT designation FROM employees ORDER BY designation ASC',
    );

    return maps.map((map) => map['designation'] as String).toList();
  }

  /// Get employee count
  Future<int> getEmployeeCount() async {
    final db = await database;
    final count = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM employees'),
    );
    return count ?? 0;
  }

  /// Update employee
  Future<int> updateEmployee(Employee employee) async {
    final db = await database;
    return await db.update(
      'employees',
      employee.toDatabase(),
      where: 'id = ?',
      whereArgs: [employee.id],
    );
  }

  /// Delete employee
  Future<int> deleteEmployee(int id) async {
    final db = await database;
    return await db.delete(
      'employees',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Delete all employees
  Future<int> deleteAllEmployees() async {
    final db = await database;
    return await db.delete('employees');
  }

  /// Close database
  Future<void> close() async {
    final db = await database;
    await db.close();
  }

  /// Clear database and reinitialize
  Future<void> clearAndReset() async {
    final db = await database;
    await db.delete('employees');
  }
}