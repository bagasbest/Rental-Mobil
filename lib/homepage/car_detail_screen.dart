import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../database/database_service.dart';

class CarDetailScreen extends StatefulWidget {
  final String uid;
  final String address;
  final String title;
  final String price;
  final String year;
  final String description;
  final String category;
  final String image;

  CarDetailScreen({
    required this.uid,
    required this.address,
    required this.title,
    required this.price,
    required this.year,
    required this.description,
    required this.category,
    required this.image,
  });

  @override
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen> {
  final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');
  DateTime? _dateTime;
  String startDate = "Tanggal Mulai";
  String finishDate = "Tanggal Selesai";
  var startDateInMillis = 0;
  var finishDateInMillis = 0;
  var totalDayWithPrice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Detail Mobil'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: InkWell(
                child: Icon(Icons.delete),
                onTap: () async {
                  await DatabaseService.deleteCar(
                    widget.uid
                  );

                  Navigator.of(context).pop();

                },
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 10,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      16,
                    ),
                    child: Image.network(
                      widget.image,
                      fit: BoxFit.fill,
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Tahun Keluaran : ${widget.year}",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Kategori : ${widget.category}",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Alamat Lokasi : ${widget.address}",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Harga : ${formatCurrency.format(int.parse(widget.price))} / hari",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "${widget.description}",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2021),
                          lastDate: DateTime(2023),
                        ).then((date) {
                          //tambahkan setState dan panggil variabel _dateTime.
                          startDateInMillis = date!.millisecondsSinceEpoch;
                          var dt = DateTime.fromMillisecondsSinceEpoch(
                              startDateInMillis);
                          var d24 = DateFormat('dd MMM yyyy').format(dt);
                          startDate = d24;

                          if (finishDateInMillis >= startDateInMillis) {
                            var totalDay =
                                finishDateInMillis - startDateInMillis;
                            var dt =
                                DateTime.fromMillisecondsSinceEpoch(totalDay);
                            totalDayWithPrice =
                                int.parse(DateFormat('dd').format(dt)) *
                                    int.parse(widget.price);
                          }

                          setState(() {
                            _dateTime = date;
                          });
                        });
                      },
                      child: Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.blue,
                        ),
                        child: Center(
                            child: Text(
                          startDate,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        )),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2021),
                          lastDate: DateTime(2023),
                        ).then((date) {
                          //tambahkan setState dan panggil variabel _dateTime.
                          finishDateInMillis = date!.millisecondsSinceEpoch;
                          var dt = DateTime.fromMillisecondsSinceEpoch(
                              finishDateInMillis);
                          var d24 = DateFormat('dd MMM yyyy').format(dt);
                          finishDate = d24;

                          if (finishDateInMillis >= startDateInMillis) {
                            var totalDay =
                                finishDateInMillis - startDateInMillis;
                            var dt =
                                DateTime.fromMillisecondsSinceEpoch(totalDay);
                            totalDayWithPrice =
                                int.parse(DateFormat('dd').format(dt)) *
                                    int.parse(widget.price);
                          }

                          setState(() {
                            _dateTime = date;
                          });
                        });
                      },
                      child: Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.blue,
                        ),
                        child: Center(
                            child: Text(
                          finishDate,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        )),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Harga Rental: ${formatCurrency.format(int.parse(totalDayWithPrice.toString()))}",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () async {
                    String uid = FirebaseAuth.instance.currentUser!.uid;
                    if (totalDayWithPrice > 0) {
                      await DatabaseService.rentCar(
                        widget.title,
                        widget.description,
                        totalDayWithPrice.toString(),
                        widget.year,
                        widget.address,
                        widget.image,
                        widget.category,
                        uid,
                        startDate,
                        finishDate,
                      );

                      Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.blue,
                    ),
                    child: Center(
                        child: Text(
                      'Rental Mobil Ini',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
