import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rental_mobil/homepage/car_detail_screen.dart';

class DataCategoryList extends StatelessWidget {
  final List<DocumentSnapshot> document;

  DataCategoryList({required this.document});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: document.length,
      itemBuilder: (BuildContext context, int i) {
        String uid = document[i]['uid'].toString();
        String title = document[i]['title'].toString();
        String address = document[i]['address'].toString();
        String price = document[i]['price'].toString();
        String year = document[i]['year'].toString();
        String description = document[i]['description'].toString();
        String category = document[i]['category'].toString();
        String image = document[i]['image'].toString();
        final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');

        return GestureDetector(
          onTap: () {
            Route route = MaterialPageRoute(
              builder: (context) => CarDetailScreen(
                uid: uid,
                address: address,
                title: title,
                price: price,
                year: year,
                description: description,
                category: category,
                image: image,
              ),
            );
            Navigator.push(context, route);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    image,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16, left: 16, right: 16,),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    address,
                    style: TextStyle(color: Colors.white),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5)),
                ),
                Container(
                  margin: EdgeInsets.only(top: 150),
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${formatCurrency.format(int.parse(price))}",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 16,),
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            'Sewa',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
