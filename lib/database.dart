import 'dart:io';

import 'package:learndatabase/model_database/modelTabel.dart';
import 'package:learndatabase/model_database/userModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseInstance {
  final String _namaDatabase = "BNSP.db";
  final int _databaseVersion = 1;

  //kolom tabel
  final String table = 'dataOrang';
  final String tableLogin = 'loginData';
  final String nama = 'nama';
  final String password = 'password';

  final String id = 'id';
  final String tanggal = 'tanggal';
  final String uang = 'jumlah_Uang';
  final String keterangan = 'keterangan';
  final String status = 'status';
  final String createdAt = 'created_at';
  final String updatedAt = 'updated_at';

  Database? _database;

  Future<Database> database() async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    if (_database == null) {
      // Handle error, contoh:
      throw Exception("Gagal menginisialisasi database");
    }

    return _database!;
  }

  Future<Database?> _initDatabase() async {
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, _namaDatabase);

      return await openDatabase(path,
          version: _databaseVersion, onCreate: _onCreate);
    } catch (e) {
      // Handle error, contoh:
      print("Error inisialisasi database: $e");
      return null;
    }
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $table ($id INTEGER PRIMARY KEY,$tanggal TEXT NULL,$uang TEXT NULL,$keterangan TEXT NULL,$status TEXT NULL,$createdAt TEXT NULL,$updatedAt TEXT NULL)');
    await db.execute(
        'CREATE TABLE $tableLogin ($id INTEGER PRIMARY KEY,$nama TEXT NULL,$password TEXT NULL,$createdAt TEXT NULL,$updatedAt TEXT NULL)');
    // await db.execute('ALTER TABLE $table ADD COLUMN $status INTEGER NULL');
  }

  Future<bool> isValidLogin(String username, String password) async {
    final db = await database();
    final result = await db.rawQuery(
        'SELECT * FROM $tableLogin WHERE $nama = ? AND $password = ?',
        [username, password]);

    return result.isNotEmpty;
  }

  Future<List<ProductTabel>> all() async {
    final db =
        await database(); // Pastikan bahwa database sudah diinisialisasi.
    final data = await db.query(table);
    List<ProductTabel> result =
        data.map((e) => ProductTabel.fromJson(e)).toList();
    print(result);
    return result;
  }

  Future<int> insert(Map<String, dynamic> row) async {
    final db = await database();
    final query = await db.insert(table, row);
    return query;
  }

  Future<int> insertLogin(Map<String, dynamic> row) async {
    final db = await database();
    final query = await db.insert(tableLogin, row);
    return query;
  }

  Future<int> update(int idparam, Map<String, dynamic> row) async {
    final query = await _database!
        .update(table, row, where: '$id = ?', whereArgs: [idparam]);
    return query;
  }

  Future delete(int idparam) async {
    await _database!.delete(table, where: '$id = ?', whereArgs: [idparam]);
    print('hapus data $id');
  }

  Future<void> deleteDatabaseFile() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(documentsDirectory.path,
        'BNSP.db'); // Sesuaikan dengan nama database Anda

    File dbFile = File(dbPath);
    if (await dbFile.exists()) {
      await dbFile.delete();
      print('Database deleted successfully.');
    } else {
      print('Database file not found.');
    }
  }

  Future<void> deleteAndRecreateDatabase() async {
    // Hapus database dari direktori aplikasi
    await deleteDatabaseFile();

    // Inisialisasi ulang database
    _database = await _initDatabase();

    // Selanjutnya, Anda dapat menjalankan kode lain yang diperlukan setelah menghapus dan membuat ulang database.
    // Contoh: Membuat tabel kembali jika diperlukan
    await _onCreate(_database!, _databaseVersion);
  }

  Future<void> getDatabasePath() async {
    String dbPath = await getDatabasesPath();
    print('Database path: $dbPath');
  }

  Future<double> getTotalPemasukan() async {
    final db = await database();
    final result =
        await db.rawQuery('SELECT SUM($uang) FROM $table WHERE $status = 1');
    double total = Sqflite.firstIntValue(result)?.toDouble() ?? 0.0;
    return total;
  }

  Future<double> getTotalPengeluaran() async {
    final db = await database();
    final result =
        await db.rawQuery('SELECT SUM($uang) FROM $table WHERE $status = 2');
    double total = Sqflite.firstIntValue(result)?.toDouble() ?? 0.0;
    return total;
  }

  Future<userModel?> getUserByName(String name) async {
    final db = await database();
    final result =
        await db.query(tableLogin, where: '$nama = ?', whereArgs: [name]);

    if (result.isNotEmpty) {
      return userModel.fromJson(result.first);
    } else {
      return null;
    }
  }
}
