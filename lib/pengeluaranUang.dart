import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learndatabase/database.dart';

class pengeluaranUang extends StatefulWidget {
  const pengeluaranUang({Key? key}) : super(key: key);

  @override
  State<pengeluaranUang> createState() => _pengeluaranUangState();
}

class _pengeluaranUangState extends State<pengeluaranUang> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  TextEditingController uangController = TextEditingController();
  TextEditingController keteranganController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    databaseInstance.database();
    dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pengeluaran Uang Data')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('Tambah Pengeluaran'),
            Text('Tanggal'),
            TextFormField(
              controller: dateController,
              onTap: () => _selectDate(context),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(Icons.date_range),
                  onPressed: () => _selectDate(context),
                ),
                border: OutlineInputBorder(),
              ),
            ),
            Text('Jumlah Uang'),
            TextField(
              controller: uangController,
            ),
            Text('Keterangan'),
            TextField(
              controller: keteranganController,
            ),
            ElevatedButton(
              onPressed: () async {
                await databaseInstance.insert({
                  'status': '2',
                  'jumlah_Uang': uangController.text,
                  'keterangan': keteranganController.text,
                  'tanggal': dateController.text,
                  'created_at': DateTime.now().toString(),
                  'updated_at': DateTime.now().toString(),
                });
                await databaseInstance.getDatabasePath();
                Navigator.pop(context);
              },
              child: Text('Submit'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedDate = DateTime(2021, 1, 1);
                  dateController.text =
                      DateFormat('yyyy-MM-dd').format(selectedDate);
                });
              },
              child: Text('Set Tanggal ke 01/01/2021'),
            ),
            ElevatedButton(
              onPressed: () async {
                await databaseInstance.deleteDatabaseFile();
                Navigator.pop(context);
              },
              child: Text('Delete Database'),
            ),
            ElevatedButton(
              onPressed: () async {
                await databaseInstance.deleteAndRecreateDatabase();
                Navigator.pop(context);
              },
              child: Text('Create Database'),
            ),
          ],
        ),
      ),
    );
  }
}
