import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';

import '../authentication/login_screen.dart';
import '../database/database_service.dart';

class CarAddScreen extends StatefulWidget {
  @override
  State<CarAddScreen> createState() => _CarAddScreenState();
}

class _CarAddScreenState extends State<CarAddScreen> {
  var _carTitle = TextEditingController();
  var _carDescription = TextEditingController();
  var _carYear = TextEditingController();
  var _carAddress = TextEditingController();
  var _carPrice = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isImageAdd = false;
  XFile? _image;
  bool _visible = false;
  String dropdownValue = 'City Car';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambahkan Mobil'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, left: 16, right: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 1),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextFormField(
                  controller: _carTitle,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    hintText: 'Nama Mobil',
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nama Mobil tidak boleh kosong';
                    } else {
                      return null;
                    }
                  },
                ),
              ),

              Container(
                margin: const EdgeInsets.only(top: 10, left: 16, right: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 1),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextFormField(
                  controller: _carDescription,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    hintText: 'Deskripsi Mobil',
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Deskripsi Mobil tidak boleh kosong';
                    } else {
                      return null;
                    }
                  },
                ),
              ),

              Container(
                margin: const EdgeInsets.only(top: 10, left: 16, right: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 1),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextFormField(
                  controller: _carYear,
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    hintText: 'Tahun Pembelian Mobil',
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Tahun Pembelian Mobil tidak boleh kosong';
                    } else {
                      return null;
                    }
                  },
                ),
              ),

              Container(
                margin: const EdgeInsets.only(top: 10, left: 16, right: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 1),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextFormField(
                  controller: _carPrice,
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    hintText: 'Harga sewa Mobil / 1 hari',
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Harga sewa Mobil / 1 hari, tidak boleh kosong';
                    } else {
                      return null;
                    }
                  },
                ),
              ),

              Container(
                margin: const EdgeInsets.only(top: 10, left: 16, right: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 1),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextFormField(
                  controller: _carAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    hintText: 'Alamat Lokasi',
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Alamat Lokasi tidak boleh kosong';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.blue),
                underline: Container(
                  height: 2,
                  color: Colors.blue,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>['City Car', 'Commercial', 'Luxury']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 100,
                margin: EdgeInsets.only(
                  top: 16,
                  left: 16,
                ),
                width: 120,
                color: Colors.white,
                child: Row(
                  children: [
                    (!isImageAdd)
                        ? GestureDetector(
                            onTap: () async {
                              _image = await DatabaseService.getImageGallery();
                              if (_image == null) {
                                setState(() {
                                  toast("Gagal ambil foto");
                                });
                              } else {
                                setState(() {
                                  isImageAdd = true;
                                  toast('Berhasil menambah foto');
                                });
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DottedBorder(
                                color: Colors.grey,
                                strokeWidth: 1,
                                dashPattern: [6, 6],
                                child: Container(
                                  child: Center(
                                    child: Text("* Tambah Foto"),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.file(
                              File(
                                _image!.path,
                              ),
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            ),
                          )
                  ],
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
                height: 50,
              ),

              /// TOMBOL LOGIN
              InkWell(
                onTap: () async {
                  /// CEK APAKAH KOLOM KOLOM SUDAH TERISI SEMUA
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _visible = true;
                    });

                    String? url = (_image != null)
                        ? await DatabaseService.uploadImageReport(_image!)
                        : null;

                    DatabaseService.uploadCar(
                      _carTitle.text,
                      _carAddress.text,
                      _carPrice.text,
                      _carYear.text,
                      _carDescription.text,
                      (url != null) ? url : '',
                      dropdownValue,
                    );

                    setState(() {
                      _visible = false;
                      _carTitle.text = "";
                      _carDescription.text = "";
                      _carYear.text = "";
                      _carPrice.text = "";
                      _carAddress.text = "";
                      _image = null;
                      isImageAdd = false;
                    });

                    setState(() {
                      _visible = false;
                    });
                  } else if (_image == null) {
                    toast('Mohon tambahkan gambar mobil.');
                  }
                },
                child: SizedBox(
                  width: 200,
                  height: 50,
                  child: Container(
                    child: Center(
                      child: const Text(
                        'Kirim',
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
            ],
          ),
        ),
      ),
    );
  }
}
