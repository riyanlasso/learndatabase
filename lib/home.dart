// import 'package:belajar2/tambahPemasukan.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:learndatabase/createData.dart';
import 'package:learndatabase/database.dart';
import 'package:learndatabase/detailCashFlow.dart';

import 'package:learndatabase/pengeluaranUang.dart';
import 'package:learndatabase/profile.dart';

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
  DatabaseInstance? databaseInstance;
  double pemasukanBulanIni = 0.0;
  double pengeluaranBulanIni = 0.0;
  // double pemasukanBulanIni = 1000.0;
  // double pengeluaranBulanIni = 500.0;

  @override
  void initState() {
    super.initState();
    databaseInstance = DatabaseInstance();
    updateTotal();
  }

  Future<void> updateTotal() async {
    final totalPemasukan = await databaseInstance!.getTotalPemasukan();
    final totalPengeluaran = await databaseInstance!.getTotalPengeluaran();

    setState(() {
      pemasukanBulanIni = totalPemasukan;
      pengeluaranBulanIni = totalPengeluaran;
    });
  }

  Future _refresh() async {
    setState(() {
      updateTotal();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
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
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  children: [
                    Text('Total Pemasukan: $pemasukanBulanIni'),
                    Text('Total Pengeluaran: $pengeluaranBulanIni'),
                  ],
                ),
              ),

              // Teks Pemasukan dan Pengeluaran Bulan Ini
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  children: [],
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
                            return createData();
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
                        Navigator.push(context, MaterialPageRoute(
                          builder: (builder) {
                            return pengeluaranUang();
                          },
                        ));
                      },
                      icon: Icon(Icons.remove),
                      label: Text('Tambah Pengeluaran'),
                    ),
                    // Button detail cash flow
                    ElevatedButton.icon(
                      onPressed: () {
                        // Aksi ketika tombol detail cash flow ditekan
                        Navigator.push(context, MaterialPageRoute(
                          builder: (builder) {
                            return detailcashFlow();
                          },
                        ));
                      },
                      icon: Icon(Icons.description),
                      label: Text('Detail Cash Flow'),
                    ),
                    // Button pengaturan
                    ElevatedButton.icon(
                      onPressed: () {
                        // Aksi ketika tombol pengaturan ditekan
                        Navigator.push(context, MaterialPageRoute(
                          builder: (builder) {
                            return ProfilePage();
                          },
                        ));
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
      ),
    );
  }
}
