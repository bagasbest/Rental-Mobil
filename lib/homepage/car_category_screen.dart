import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rental_mobil/homepage/car_category_list.dart';
import 'package:rental_mobil/homepage/car_list.dart';

class CarCategoryScreen extends StatefulWidget {
  final String category;

  CarCategoryScreen({required this.category});

  @override
  State<CarCategoryScreen> createState() => _CarCategoryScreenState();
}

class _CarCategoryScreenState extends State<CarCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(widget.category),
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
                  .collection('car')
                  .where('category', isEqualTo: widget.category)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return (snapshot.data!.size > 0)
                      ? DataCategoryList(
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
          'Tidak Ada Mobil\nTersedia',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }
}
