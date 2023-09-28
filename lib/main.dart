import 'package:learndatabase/splashscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Mainpage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Mainpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Scaffold(
        body: SplashScreen(),
        // StreamBuilder<User?>(
        //   stream: FirebaseAuth.instance.authStateChanges(),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       return const cleanhomecustomer();
        //     } else {
        //       return login();
        //     }
        //   },
        // ),
      );
}
