import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Import the ffi package
import 'package:path/path.dart'; // Import the path package

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._();

  // Get the database instance
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_database.db');
    print("Database path: $path"); // Log the database path
    
    final db = await openDatabase(
      path,
      onCreate: (db, version) async {
        print("Creating database and table...");

        // Create users table
        await db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, fullName TEXT, email TEXT, birthDate TEXT, phoneNumber TEXT, password TEXT)',
        );
        
        // Insert admin user data if not exists
        final adminExists = await doesEmailExist('admin@gmail.com');
        if (!adminExists) {
          await db.insert('users', {
            'fullName': 'Admin',
            'email': 'admin@gmail.com',
            'birthDate': '1990-01-01',
            'phoneNumber': '1234567890',
            'password': 'admin123',
          });
          print("Admin user inserted successfully.");
        } else {
          print("Admin user already exists.");
        }
      },
      version: 1,
    );
    return db;
  }

  // Insert user into the database
  Future<int> insertUser(Map<String, dynamic> user) async {
    try {
      final db = await database;
      print("Inserting user into the database: $user"); // Log user data
      final result = await db.insert('users', user);
      print("User inserted successfully with id: $result");
      return result;
    } catch (e) {
      print('Error inserting user: $e');
      return -1; // Return -1 on error
    }
  }

  // Method to get user by email
  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    try {
      final db = await database;
      // Query the database for a user with the specified email
      List<Map<String, dynamic>> result = await db.query(
        'users',
        where: 'email = ?',
        whereArgs: [email],
      );

      print("Query result for email $email: $result"); // Log the result of the query
      
      if (result.isNotEmpty) {
        return result.first; // Return the first matching result
      } else {
        return null; // Return null if no user is found
      }
    } catch (e) {
      print('Error fetching user by email: $e');
      return null; // Return null in case of error
    }
  }

  // Method to check if email already exists
  Future<bool> doesEmailExist(String email) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    print("Does email $email exist? ${result.isNotEmpty}"); // Log whether email exists
    return result.isNotEmpty;
  }

  // Method to check tables in the database (debugging)
  Future<void> checkTables() async {
    final db = await database;
    var result = await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table'");
    print("Tables in database: $result");
  }
}