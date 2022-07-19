import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rental_mobil/authentication/register_screen.dart';
import 'package:rental_mobil/homepage/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    bool _visible = false;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Icon(
              Icons.car_rental,
              size: 100,
              color: Colors.blue,
            ),
            const Text(
              'LOGIN',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Text(
              'Masukkan Nomor Handphone & Kata Sandi',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  /// KOLOM NOMOR HANDPHONE
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 16, right: 16),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 1),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextFormField(
                      controller: _emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email tidak boleh kosong';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),

                  /// KOLOM PASSWORD
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 16, right: 16),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 1),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: 'Kata Sandi',
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Kata Sandi tidak boleh kosong';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),

                  /// LOADING INDIKATOR
                  Visibility(
                    visible: _visible,
                    child: const SpinKitRipple(
                      color: Colors.blue,
                    ),
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  /// TOMBOL LOGIN
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: InkWell(
                      onTap: () async {
                        /// CEK APAKAH EMAIL DAN PASSWORD SUDAH TERISI DENGAN FORMAT YANG BENAR
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _visible = true;
                          });

                          /// CEK APAKAH Email DAN PASSWORD SUDAH TERDAFTAR / BELUM
                          bool shouldNavigate = await _signInHandler(
                            _emailController.text,
                            _passwordController.text,
                          );

                          if (shouldNavigate) {
                            setState(() {
                              _visible = false;
                            });

                            /// MASUK KE HOMEPAGE JIKA SUKSES LOGIN
                            Route route = MaterialPageRoute(
                                builder: (context) =>
                                const HomeScreen());
                            Navigator.pushReplacement(context, route);

                          } else {
                            setState(() {
                              _visible = false;
                            });
                          }
                        }
                      },
                      child: Container(
                          child: Center(
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(29),
                              color: Colors.blue,
                            ),
                         ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      Route route = MaterialPageRoute(
                          builder: (context) => const RegisterScreen());
                      Navigator.push(context, route);
                    },
                    splashColor: Colors.grey[200],
                    child: const Text(
                      'Saya Ingin Mendaftar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _signInHandler(String email, String password) async {
    try {
      (await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password))
          .user;

      return true;
    } catch (error) {
      toast(
          'Terdapat kendala ketika ingin login. Silahkan periksa kembali email & password, serta koneksi internet anda');
      return false;
    }
  }
}

void toast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0);
}