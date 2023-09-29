import 'package:flutter/material.dart';
import 'package:learndatabase/database.dart';
import 'package:learndatabase/login.dart'; // Sesuaikan dengan lokasi file DatabaseInstance

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  TextEditingController namaController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: namaController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            ElevatedButton(
              onPressed: () async {
                await register();
                print('klik register');
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> register() async {
    // Melakukan operasi pendaftaran ke dalam database
    await databaseInstance.insertLogin({
      'nama': namaController.text,
      'password': passwordController.text,
      'created_at': DateTime.now().toString(),
      'updated_at': DateTime.now().toString(),
    });

    // Menampilkan pesan sukses (dapat disesuaikan)
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Registrasi Berhasil'),
          content: Text('Pengguna berhasil terdaftar!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => Login()),
                );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );

    // Anda dapat menambahkan logika lainnya seperti navigasi ke halaman lain, dll.
  }
}
