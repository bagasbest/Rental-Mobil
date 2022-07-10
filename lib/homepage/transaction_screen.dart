import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rental_mobil/homepage/transaction_list.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  String userId = "";

  _checkRole() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      userId = "" + value.get('uid');
      setState(() {});
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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Riwayat Rental Mobil'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
            ),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('transaction')
                  .where("userId", isEqualTo: userId)
                  .where("status", isEqualTo: "Sedang Dirental")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return (snapshot.data!.size > 0)
                      ? DataTransactionList(
                          document: snapshot.data!.docs,
                        )
                      : _emptyData();
                } else {
                  return _emptyData();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyData() {
    return Container(
      child: Center(
        child: Text(
          'Tidak Ada Transaksi\nTersedia',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }
}
