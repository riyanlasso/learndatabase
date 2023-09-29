import 'package:flutter/material.dart';
import 'package:learndatabase/createData.dart';
import 'package:learndatabase/database.dart';
import 'package:learndatabase/model_database/modelTabel.dart';
import 'package:learndatabase/updateData.dart';

class detailcashFlow extends StatefulWidget {
  @override
  State<detailcashFlow> createState() => _detailcashFlowState();
}

class _detailcashFlowState extends State<detailcashFlow> {
  DatabaseInstance? databaseInstance;
  Future _refresh() async {
    setState(() {});
  }

  Future initDatabase() async {
    await databaseInstance!.database();
    setState(() {});
  }

  Future delete(int id) async {
    await databaseInstance!.delete(id);
    setState(() {});
  }

  @override
  void initState() {
    databaseInstance = DatabaseInstance();
    initDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Coba Database SQFLITE"),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (builder) {
                        return createData();
                      },
                    )).then((value) {
                      setState(() {});
                    });
                  },
                  icon: const Icon(Icons.add))
            ],
            backgroundColor: Color.fromARGB(255, 166, 163, 255)),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: databaseInstance != null
              ? FutureBuilder<List<ProductTabel>>(
                  future: databaseInstance!.all(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.length == 0) {
                        return Center(child: Text('DATA MASIH KOSONG'));
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          print(snapshot.data![index].status);
                          bool isStatus1 = snapshot.data![index].status == '1';
                          return Padding(
                            padding: EdgeInsets.all(13),
                            child: ListTile(
                              title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(snapshot.data![index].uang ?? '')
                                  ]),
                              subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        snapshot.data![index].keterangan ?? ''),
                                    Text(snapshot.data![index].tanggal ?? ''),
                                  ]),
                              leading: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  PopupMenuButton<String>(
                                    onSelected: (value) {
                                      if (value == 'delete') {
                                        delete(snapshot.data![index].id!);
                                      } else if (value == 'edit') {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (builder) {
                                            return updateData(
                                              productTabel:
                                                  snapshot.data![index],
                                            );
                                          },
                                        )).then((value) {
                                          setState(() {});
                                        });
                                      }
                                    },
                                    itemBuilder: (context) => [
                                      const PopupMenuItem(
                                        value: 'delete',
                                        child: ListTile(
                                          leading: Icon(Icons.delete),
                                          title: Text('Delete'),
                                        ),
                                      ),
                                      const PopupMenuItem(
                                        value: 'edit',
                                        child: ListTile(
                                          leading: Icon(Icons.edit),
                                          title: Text('Edit'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: SizedBox(
                                width: 50,
                                child: isStatus1
                                    ? Image.asset(
                                        'assets/left_arrow.png',
                                        width: 37, // Sesuaikan lebar gambar
                                        height: 37, // Sesuaikan tinggi gambar
                                      )
                                    : Image.asset(
                                        'assets/right_arrow.png',
                                        width: 37, // Sesuaikan lebar gambar
                                        height: 37, // Sesuaikan tinggi gambar
                                      ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                          child: CircularProgressIndicator(
                              color: Color.fromARGB(255, 0, 0, 0)));
                    }
                  },
                )
              : Center(
                  child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 0, 0, 0))),
        ));
  }
}
