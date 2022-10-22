import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utils/my_snackbar.dart';

class AddDataController {
  static TextEditingController foopdNameC = TextEditingController();
  static TextEditingController priceC = TextEditingController();
  static TextEditingController stockC = TextEditingController();

  // firestore instance
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<void> addFood(
      String name, String price, String stock, BuildContext context) {
    CollectionReference dataFood = firestore.collection("food");
    return dataFood
        .add({'name': name, 'price': price, 'stock': stock}).then((value) {
      log("Food Added");
      // clear textfield
      foopdNameC.clear();
      priceC.clear();
      stockC.clear();
      // back to home
      Navigator.pop(context);
      // show snackbar
      ScaffoldMessenger.of(context)
          .showSnackBar(mySnackbar("Food berhasil ditambahkan", Colors.green));
    }).catchError((error) {
      log("Failed to add food: $error");
      ScaffoldMessenger.of(context)
          .showSnackBar(mySnackbar("Food gagal ditambahkan", Colors.red));
    });
  }
}
