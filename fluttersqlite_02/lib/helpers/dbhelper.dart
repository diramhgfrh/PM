import 'package:fluttersqlite_02/models/contact.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  static Database? _database;

  // inisialisasi beberapa variabel yang dibutuhkan
  final String tableName = 'tableKontak';
  final String columnId = 'id';
  final String columnName = 'name';
  final String columnMobileNo = 'mobileNo';
  final String columnEmail = 'email';

  DbHelper._internal();
  factory DbHelper() => _instance;

// cek database
  Future<Database?> get _db async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDb();
    return _database;
  }

  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'kontak2.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

//membuat tabel dan field-fieldnya
  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, "
        "$columnName TEXT,"
        "$columnMobileNo TEXT,"
        "$columnEmail TEXT)";
    await db.execute(sql);
  }

//insert ke database
  Future<int?> saveKontak(Contact kontak) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, kontak.toMap());
  }

//read database
  Future<List?> getAllKontak() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName, columns: [
      columnId,
      columnName,
      columnMobileNo,
      columnEmail,
    ]);
    return result.toList();
  }

//update database
  Future<int?> updateKontak(Contact kontak) async {
    var dbClient = await _db;
    return await dbClient!.update(tableName, kontak.toMap(),
        where: '$columnId = ?', whereArgs: [kontak.id]);
  }

//hapus database
  Future<int?> deleteKontak(int id) async {
    var dbClient = await _db;
    return await dbClient!
        .delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
