import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rental_mobil/authentication/login_screen.dart';
import 'package:rental_mobil/homepage/car_add_screen.dart';
import 'package:rental_mobil/homepage/car_category_screen.dart';
import 'package:rental_mobil/homepage/return_car_screen.dart';
import 'package:rental_mobil/homepage/transaction_screen.dart';

import 'car_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isAdmin = false;

  _checkRole() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      String role = "" + value.get('role');
      if (role == "admin") {
        setState(() {
          isAdmin = true;
        });
      } else {
        setState(() {
          isAdmin = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _checkRole();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selamat Datang di Rental Mobil'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            height: 70,
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                )),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        child: Icon(
                          Icons.home_outlined,
                          color: Colors.white,
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        child: Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Route route = MaterialPageRoute(
                              builder: (context) => const TransactionScreen());
                          Navigator.push(context, route);
                        },
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      InkWell(
                        child: Icon(
                          Icons.assignment_return_outlined,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Route route = MaterialPageRoute(
                              builder: (context) => const ReturnCarScreen());
                          Navigator.push(context, route);
                        },
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      InkWell(
                        child: Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                              (Route<dynamic> route) => false);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 85,
              left: 16,
              right: 16,
              bottom: 80,
            ),
            padding: EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: Colors.purple[100],
                borderRadius: BorderRadius.circular(16)),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(
              top: 100,
            ),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 32, right: 16),
                  width: 180,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                        )),
                  ),
                ),
                FloatingActionButton(
                  onPressed: () => {},
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.black,
                  ),
                  backgroundColor: Colors.white,
                ),
                SizedBox(
                  width: 16,
                ),
                FloatingActionButton(
                  onPressed: () => {},
                  child: Icon(
                    Icons.notifications_active_outlined,
                    color: Colors.black,
                  ),
                  backgroundColor: Colors.white,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 170,
              left: 32,
              right: 32,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                'https://images.unsplash.com/photo-1565043666747-69f6646db940?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
                fit: BoxFit.fill,
                height: 150,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 330, left: 32, right: 32),
            child: Text(
              'Kategori',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 360, left: 16, right: 16),
            child: Row(
              children: [
                Flexible(
                  child: GestureDetector(
                    onTap: (){
                      Route route = MaterialPageRoute(
                          builder: (context) =>  CarCategoryScreen(
                              category: 'City Car'
                          ));
                      Navigator.push(context, route);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      height: 35,
                      color: Colors.white,
                      child: Row(
                        children: [Icon(Icons.car_rental), Text('CITYCAR')],
                      ),
                    ),
                  ),
                  flex: 1,
                ),
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      Route route = MaterialPageRoute(
                          builder: (context) =>  CarCategoryScreen(
                              category: 'Commercial'
                          ));
                      Navigator.push(context, route);
                    },
                    child: Container(
                      height: 35,
                      child: Row(
                        children: [Icon(Icons.car_rental), Text('COMMERCIAL')],
                      ),
                      color: Colors.white,
                    ),
                  ),
                  flex: 1,
                ),
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      Route route = MaterialPageRoute(
                          builder: (context) => CarCategoryScreen(
                            category: 'Luxury'
                          ));
                      Navigator.push(context, route);
                    },
                    child: Container(
                      height: 35,
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [Icon(Icons.car_rental), Text('LUXURY')],
                      ),
                      color: Colors.white,
                    ),
                  ),
                  flex: 1,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 420, left: 32),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('car')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return (snapshot.data!.size > 0)
                      ? DataCarList(
                    document: snapshot.data!.docs,
                  )
                      : _emptyData();
                } else {
                  return _emptyData();
                }
              },
            ),
          ),
          (isAdmin)
              ? Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  Route route = MaterialPageRoute(
                      builder: (context) => CarAddScreen());
                  Navigator.push(context, route);
                },
              ),
            ),
          )
              : Container(),
        ],
      ),
    );
  }
  Widget _emptyData() {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 30, bottom: 100),
          child: Text(
            'Tidak Ada Mobil\nTersedia',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
