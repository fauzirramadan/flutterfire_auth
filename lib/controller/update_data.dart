import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utils/my_snackbar.dart';

class UpdateDataController {
  static TextEditingController foopdNameC = TextEditingController();
  static TextEditingController priceC = TextEditingController();
  static TextEditingController stockC = TextEditingController();

  // firestore instance
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<void> updateFood(String id, String foodName, String price,
      String stock, BuildContext context) {
    CollectionReference dataFood = firestore.collection("food");
    return dataFood.doc(id).update(
        {'name': foodName, 'price': price, 'stock': stock}).then((value) {
      log("Food updated");
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(mySnackbar("Food berhasil diupdate", Colors.green));
    }).catchError((error) {
      log(error.toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(mySnackbar("Food gagal diupdate", Colors.red));
    });
  }
}
