import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rental_mobil/homepage/home_screen.dart';

import 'authentication/login_screen.dart';

/// main program untuk memulai aplikasi
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// cek apakah pengguna sudah login sebelumnya atau belum, jika sudah langsung masuk ke homepage, jika belum masuk ke login
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const LoginScreen(),
      );
    }
  }
}
