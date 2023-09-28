import 'dart:io';

import 'package:learndatabase/modelTabel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseInstance {
  final String _namaDatabase = "BNSP.db";
  final int _databaseVersion = 1;

  //kolom tabel
  final String table = 'dataOrang';
  final String id = 'id';
  final String nama = 'nama';
  final String uang = 'jumlah_Uang';
  final String keterangan = 'keterangan';
  final String createdAt = 'created_at';
  final String updatedAt = 'updated_at';

  Database? _database;

  Future<Database> database() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _namaDatabase);
    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $table ($id INTEGER PRIMARY KEY,$nama TEXT NULL,$uang TEXT NULL,$keterangan TEXT NULL,$createdAt TEXT NULL,$updatedAt TEXT NULL)');

    // await db.execute('ALTER TABLE $table ADD COLUMN $keterangan TEXT NULL');
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
    final query = await _database!.insert(table, row);
    return query;
  }

  Future<int> update(int idparam, Map<String, dynamic> row) async {
    final query = await _database!
        .update(table, row, where: '$id = ?', whereArgs: [idparam]);
    return query;
  }

  Future delete(int idparam) async {
    await _database!.delete(table, where: '$id = ?', whereArgs: [idparam]);
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
}
