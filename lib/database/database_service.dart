import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../authentication/login_screen.dart';

class DatabaseService {
  static Future<XFile?> getImageGallery() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (image != null) {
      return image;
    } else {
      return null;
    }
  }

  static uploadImageReport(XFile imageFile) async {
    String filename = basename(imageFile.path);

    FirebaseStorage storage = FirebaseStorage.instance;
    final Reference reference = storage.ref().child('product/$filename');
    await reference.putFile(File(imageFile.path));

    String downloadUrl = await reference.getDownloadURL();
    if (downloadUrl != null) {
      return downloadUrl;
    } else {
      return null;
    }
  }

  static void uploadCar(String title, String address, String price, String year,
      String description, String image, String category) {
    try {
      var timeInMillis = DateTime.now().millisecondsSinceEpoch;
      FirebaseFirestore.instance
          .collection('car')
          .doc(timeInMillis.toString())
          .set({
        'uid': timeInMillis.toString(),
        'title': title,
        'address': address,
        'price': price,
        'year': year,
        'description': description,
        'category': category,
        'image': image,
      });
      toast('Berhasil menambahkan Mobil');
    } catch (error) {
      toast(
          'Gagal menambahkan Mobil, silahkan cek koneksi anda dan coba lagi nanti');
    }
  }

  static Future<void> rentCar(
    String title,
    String description,
    String string,
    String year,
    String address,
    String image,
    String category,
    String uid,
    String startDate,
    String finishDate,
  ) async {
    try {
      var timeInMillis = DateTime.now().millisecondsSinceEpoch;
      await FirebaseFirestore.instance
          .collection('transaction')
          .doc(timeInMillis.toString())
          .set({
        'uid': timeInMillis.toString(),
        "userId": uid,
        'title': title,
        'address': address,
        'price': string,
        'year': year,
        'description': description,
        'category': category,
        'image': image,
        'startDate': startDate,
        'finishDate': finishDate,
        'status': "Sedang Dirental"
      });
      toast('Berhasil merental mobil');
    } catch (error) {
      toast(
          'Gagal merental mobil, silahkan cek koneksi anda dan coba lagi nanti');
    }
  }

  static finishRent(String uid, String status) {
    try {
      FirebaseFirestore.instance.collection('transaction').doc(uid).update({
        'status': status,
      });
      toast('Berhasil menyelesaikan rental mobil!, status laporan menjadi Selesai');
    } catch (error) {
      toast('Gagal menyelesaikan rental mobil!, silahkan periksa koneksi internet anda');
    }
  }

  static deleteCar(String uid) {
    try {
      FirebaseFirestore
          .instance
          .collection('car')
          .doc(uid)
          .delete();
      toast('Berhasil menghapus mobil ini!');
    } catch (error) {
      toast('Gagal menghapus mobil ini!');
    }
  }
}
