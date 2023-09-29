import 'package:flutter/material.dart';
import 'package:learndatabase/database.dart';

import 'package:learndatabase/model_database/userModel.dart'; // Sesuaikan dengan lokasi file DatabaseInstance

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    String username =
        'username'; // Ganti dengan nama pengguna yang sedang login
    userModel? user = await DatabaseInstance().getUserByName(username);

    if (user != null) {
      setState(() {
        _nameController.text = user.name ?? '';
        // Jika ada lebih banyak data pengguna yang ingin dimuat, tambahkan di sini
      });
    }
  }

  void _saveProfile() {
    // Implementasi fungsi ini tetap sama
    // Dalam implementasi penuh, pastikan untuk memeriksa apakah _nameController.text telah berubah
    // Jika ya, pertimbangkan untuk memperbarui data pengguna di database
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                      'assets/profile.png'), // Ganti dengan path gambar profil Anda
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: _oldPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password Lama'),
            ),
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password Baru'),
            ),
            ElevatedButton(
              onPressed: () {
                _saveProfile();
              },
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
