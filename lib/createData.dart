import 'package:flutter/material.dart';
import 'package:learndatabase/database.dart';

class createData extends StatefulWidget {
  const createData({super.key});

  @override
  State<createData> createState() => _createDataState();
}

class _createDataState extends State<createData> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  TextEditingController namaController = TextEditingController();
  TextEditingController uangController = TextEditingController();
  TextEditingController keteranganController = TextEditingController();

  @override
  void initState() {
    databaseInstance.database();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('create Data')),
      body: Center(
        child: Column(
          children: [
            Text('nama'),
            TextField(
              controller: namaController,
            ),
            Text('jumlah uang'),
            TextField(
              controller: uangController,
            ),
            Text('keterangan'),
            TextField(
              controller: keteranganController,
            ),
            ElevatedButton(
                onPressed: () async {
                  await databaseInstance.insert({
                    'nama': namaController.text,
                    'jumlah_Uang': uangController.text,
                    'keterangan': keteranganController.text,
                    'created_at': DateTime.now().toString(),
                    'updated_at': DateTime.now().toString(),
                  });
                  await databaseInstance.getDatabasePath();
                  Navigator.pop(context);
                },
                child: Text('submit')),
            ElevatedButton(
                onPressed: () async {
                  // Panggil metode deleteDatabaseFile untuk menghapus database
                  await databaseInstance.deleteDatabaseFile();
                  // Keluar dari halaman saat database dihapus
                  Navigator.pop(context);
                },
                child: Text('delete Database')),
            ElevatedButton(
                onPressed: () async {
                  // Panggil metode deleteDatabaseFile untuk menghapus database
                  await databaseInstance.deleteAndRecreateDatabase();
                  // Keluar dari halaman saat database dihapus
                  Navigator.pop(context);
                },
                child: Text('create Database'))
          ],
        ),
      ),
    );
  }
}
