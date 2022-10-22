import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utils/my_snackbar.dart';

class GetDataController {
  // firestore instance
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // get data function
  static Stream<QuerySnapshot<Object?>> getData() {
    CollectionReference dataFood = firestore.collection("food");
    return dataFood.snapshots();
  }

  static Future<void> deleteData(String id, BuildContext context) async {
    CollectionReference food = firestore.collection("food");
    return await food.doc(id).delete().then((value) {
      log("Food Deleted");
      ScaffoldMessenger.of(context)
          .showSnackBar(mySnackbar("Food berhasil dihapus", Colors.green));
    }).catchError((error) {
      log("Failed to delete food: $error");
      ScaffoldMessenger.of(context)
          .showSnackBar(mySnackbar("Food gagal dihapus", Colors.green));
    });
  }
}
