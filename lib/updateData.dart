import 'package:flutter/material.dart';
import 'package:learndatabase/database.dart';
import 'package:learndatabase/modelTabel.dart';

class updateData extends StatefulWidget {
  final ProductTabel? productTabel;
  const updateData({Key? key, this.productTabel}) : super(key: key);

  @override
  State<updateData> createState() => _updateDataState();
}

class _updateDataState extends State<updateData> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  TextEditingController namaController = TextEditingController();
  TextEditingController uangController = TextEditingController();
  TextEditingController keteranganController = TextEditingController();

  @override
  void initState() {
    databaseInstance.database();
    namaController.text = widget.productTabel!.name ?? '';
    uangController.text = widget.productTabel!.uang ?? '';
    keteranganController.text = widget.productTabel!.keterangan ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Data')),
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
                  await databaseInstance.update(widget.productTabel!.id!, {
                    'nama': namaController.text,
                    'jumlah_Uang': uangController.text,
                    'keterangan': keteranganController.text,
                    'updated_at': DateTime.now().toString(),
                  });
                  await databaseInstance.getDatabasePath();
                  Navigator.pop(context);
                },
                child: Text('submit')),
          ],
        ),
      ),
    );
  }
}
