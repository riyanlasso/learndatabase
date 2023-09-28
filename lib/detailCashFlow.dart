import 'package:flutter/material.dart';
import 'package:learndatabase/createData.dart';
import 'package:learndatabase/database.dart';
import 'package:learndatabase/modelTabel.dart';
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
                          return ListTile(
                            title: Text(snapshot.data![index].uang ?? ''),
                            subtitle:
                                Text(snapshot.data![index].keterangan ?? ''),
                            leading: IconButton(
                                onPressed: () =>
                                    delete(snapshot.data![index].id!),
                                icon: Icon(Icons.delete)),
                            trailing: IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (builder) {
                                    return updateData(
                                      productTabel: snapshot.data![index],
                                    );
                                  },
                                )).then((value) {
                                  setState(() {});
                                });
                              },
                              icon: Icon(Icons.edit),
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
