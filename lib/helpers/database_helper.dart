import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_database.db');
    print("Database path: $path");

    final db = await openDatabase(
      path,
      onCreate: (db, version) async {
        print("Creating database and table...");

        await db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, fullName TEXT, email TEXT UNIQUE, birthDate TEXT, phoneNumber TEXT, password TEXT)',
        );
      },
      version: 1,
    );
    print("Database opened successfully.");
    return db;
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    try {
      final db = await database;
      print("Attempting to insert user: ${user['email']}");
      final result = await db.insert('users', user, conflictAlgorithm: ConflictAlgorithm.ignore);
      if (result > 0) {
        print("User inserted successfully with id: $result");
      } else {
        print("User insertion failed or ignored (e.g., duplicate email). Result: $result");
      }
      return result;
    } catch (e) {
      print('Error inserting user: $e');
      return -1;
    }
  }

  Future<Map<String, dynamic>?> getUserById(int id) async {
    try {
      final db = await database;
      print("Attempting to get user by ID: $id");
      List<Map<String, dynamic>> result = await db.query(
        'users',
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      );

      print("Query result for ID $id: $result");

      if (result.isNotEmpty) {
        return result.first;
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching user by ID: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    try {
      final db = await database;
      print("Attempting to get user by email: $email");
      List<Map<String, dynamic>> result = await db.query(
        'users',
        where: 'email = ?',
        whereArgs: [email],
        limit: 1,
      );

      print("Query result for email $email: $result");

      if (result.isNotEmpty) {
        return result.first;
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching user by email: $e');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    try {
      final db = await database;
      print("Attempting to get all users.");
      List<Map<String, dynamic>> result = await db.query('users');
      print("GetAllUsers result count: ${result.length}");
      return result;
    } catch (e) {
      print('Error fetching all users: $e');
      return [];
    }
  }

  Future<bool> doesEmailExist(String email, {Database? dbInstance}) async {
    final db = dbInstance ?? await database;
    print("Checking if email exists: $email");
    List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );
    bool exists = result.isNotEmpty;
    print("Does email $email exist? $exists");
    return exists;
  }

  Future<int> updateUser(String email, Map<String, dynamic> values) async {
    try {
      final db = await database;
      print("Attempting to update user with email: $email with values: $values");
      final result = await db.update(
        'users',
        values,
        where: 'email = ?',
        whereArgs: [email],
      );
      print("User with email $email updated successfully. Rows affected: $result");
      return result;
    } catch (e) {
      print('Error updating user with email $email: $e');
      return 0;
    }
  }

  Future<int> deleteUserById(int id) async {
    try {
      final db = await database;
      print("Attempting to delete user with ID: $id");
      final result = await db.delete(
        'users',
        where: 'id = ?',
        whereArgs: [id],
      );
      print("User with ID $id deleted successfully. Rows affected: $result");
      return result;
    } catch (e) {
      print('Error deleting user with ID $id: $e');
      return 0;
    }
  }

  Future<int> deleteUserByEmail(String email) async {
    try {
      final db = await database;
      print("Attempting to delete user with email: $email");
      final result = await db.delete(
        'users',
        where: 'email = ?',
        whereArgs: [email],
      );
      print("User with email $email deleted successfully. Rows affected: $result");
      return result;
    } catch (e) {
      print('Error deleting user with email $email: $e');
      return 0;
    }
  }

  Future<void> checkTables() async {
    final db = await database;
    var result = await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table'");
    print("Tables in database: $result");
  }

  Future<void> close() async {
    final db = await database;
    db.close();
    _database = null;
    print("Database closed.");
  }
}