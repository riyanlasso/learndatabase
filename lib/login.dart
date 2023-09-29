// import 'package:learndatabase/home.dart';
// import 'package:flutter/material.dart';

// class login extends StatefulWidget {
//   const login({Key? key}) : super(key: key);
//   @override
//   State<login> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<login> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 0, top: 30),
//                 child: Image.asset(
//                   'assets/wallet.png',
//                   height: 170,
//                   fit: BoxFit
//                       .contain, // Sesuaikan tinggi gambar sesuai kebutuhan
//                 ),
//               ),
//               const Padding(
//                   padding: EdgeInsets.only(bottom: 0, top: 10),
//                   child: Text(
//                     'My Cash Book',
//                     style: TextStyle(
//                       fontSize: 30.0, // Ukuran font
//                       fontWeight: FontWeight.bold, // Ketebalan font
//                       fontStyle: FontStyle.italic,
//                     ),
//                   )),
//               const Padding(
//                 padding: EdgeInsets.only(top: 60),
//                 child: Form(
//                   child: Column(
//                     children: <Widget>[
//                       Padding(
//                         padding: EdgeInsets.only(left: 20, right: 20),
//                         child: TextField(
//                           // controller: emailController,
//                           textAlign: TextAlign.center,
//                           decoration: InputDecoration(
//                               border: OutlineInputBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(10.0))),
//                               hintText: 'masukkan username anda'),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(
//                           left: 20,
//                           right: 20,
//                         ),
//                         child: TextField(
//                           // controller: passwordController,
//                           textAlign: TextAlign.center,
//                           decoration: InputDecoration(
//                               border: OutlineInputBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(10.0))),
//                               hintText: 'masukkan password anda'),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               SizedBox(
//                 width: 350.0,
//                 height: 40.0,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     print('login click');
//                     Navigator.of(context).pushReplacement(
//                         MaterialPageRoute(builder: (_) => home()));
//                   },
//                   child: Text('LOGIN'),
//                 ),
//               ),
//               SizedBox(height: 10),
//               SizedBox(
//                 width: 350.0,
//                 height: 40.0,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     print('register click');
//                   },
//                   child: Text('REGISTER'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:learndatabase/home.dart';
import 'package:learndatabase/database.dart';
import 'package:learndatabase/register.dart'; // Import file database.dart

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 0, top: 30),
                child: Image.asset(
                  'assets/wallet.png',
                  height: 170,
                  fit: BoxFit.contain,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 0, top: 10),
                child: Text(
                  'My Cash Book',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 60),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          controller: usernameController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            hintText: 'Masukkan username anda',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: TextField(
                          controller: passwordController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            hintText: 'Masukkan password anda',
                          ),
                          obscureText: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 350.0,
                height: 40.0,
                child: ElevatedButton(
                  onPressed: () async {
                    // Periksa login
                    String username = usernameController.text;
                    String password = passwordController.text;

                    bool isValid =
                        await databaseInstance.isValidLogin(username, password);

                    if (isValid) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => home()),
                      );
                    } else {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => home()),
                      );
                      print('Login berhasil');
                    }
                  },
                  child: Text('LOGIN'),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 350.0,
                height: 40.0,
                child: ElevatedButton(
                  onPressed: () {
                    // Aksi ketika tombol register ditekan
                    print('Register click');
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => RegisterPage()),
                    );
                  },
                  child: Text('REGISTER'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
