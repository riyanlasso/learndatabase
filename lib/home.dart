// import 'package:belajar2/tambahPemasukan.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:learndatabase/detailCashFlow.dart';

class home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Contoh data pemasukan dan pengeluaran bulan ini
  double pemasukanBulanIni = 1000.0;
  double pengeluaranBulanIni = 500.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Grafik Pemasukan dan Pengeluaran
            AspectRatio(
              aspectRatio: 1.7,
              child: LineChart(
                LineChartData(
                    // Konfigurasi grafik disini
                    ),
              ),
            ),
            // Teks Pemasukan dan Pengeluaran Bulan Ini
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                children: [
                  Text(
                    'Pemasukan Bulan Ini: \$${pemasukanBulanIni.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    'Pengeluaran Bulan Ini: \$${pengeluaranBulanIni.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ),
            // Button-bar
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                children: [
                  // Button tambah pemasukan
                  ElevatedButton.icon(
                    onPressed: () {
                      // Aksi ketika tombol tambah pemasukan ditekan
                      Navigator.push(context, MaterialPageRoute(
                        builder: (builder) {
                          return detailcashFlow();
                        },
                      ));
                    },
                    icon: Icon(Icons.add),
                    label: Text('Tambah Pemasukan'),
                  ),
                  // Button tambah pengeluaran
                  ElevatedButton.icon(
                    onPressed: () {
                      // Aksi ketika tombol tambah pengeluaran ditekan
                    },
                    icon: Icon(Icons.remove),
                    label: Text('Tambah Pengeluaran'),
                  ),
                  // Button detail cash flow
                  ElevatedButton.icon(
                    onPressed: () {
                      // Aksi ketika tombol detail cash flow ditekan
                    },
                    icon: Icon(Icons.description),
                    label: Text('Detail Cash Flow'),
                  ),
                  // Button pengaturan
                  ElevatedButton.icon(
                    onPressed: () {
                      // Aksi ketika tombol pengaturan ditekan
                    },
                    icon: Icon(Icons.settings),
                    label: Text('Pengaturan'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
