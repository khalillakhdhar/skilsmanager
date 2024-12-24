import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/skill.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._();
  static Database? _database;

  DatabaseService._();

  factory DatabaseService() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('skills.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE skills(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT,
        level TEXT NOT NULL

      )
    ''');
  }

  Future<int> insertSkill(Skill skill) async {
    final db = await database;
    return await db.insert('skills', skill.toMap());
  }

  Future<List<Skill>> fetchSkills() async {
    final db = await database;
    final maps = await db.query('skills');
    return maps.map((map) => Skill.fromMap(map)).toList();
  }

  Future<int> updateSkill(Skill skill) async {
    final db = await database;
    return await db.update(
      'skills',
      skill.toMap(),
      where: 'id = ?',
      whereArgs: [skill.id],
    );
  }

  Future<int> deleteSkill(int id) async {
    final db = await database;
    return await db.delete(
      'skills',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
