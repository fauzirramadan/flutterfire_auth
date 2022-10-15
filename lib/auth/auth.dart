// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_auth/ui/home.dart';
import 'package:flutterfire_auth/ui/login.dart';
import 'package:flutterfire_auth/utils/my_alert.dart';
import 'package:flutterfire_auth/utils/my_snackbar.dart';
import 'package:flutterfire_auth/utils/navigator_helper.dart';

class Auth {
  // Firebase instance
  static FirebaseAuth auth = FirebaseAuth.instance;

  // my alert
  static MyAlertDialog alert = MyAlertDialog();

  // Stream user status
  static Stream<User?> get streamAuthStatus => auth.authStateChanges();

  //regiter
  static Future<void> registerUser(
      BuildContext context, String email, String password) async {
    try {
      UserCredential myUser = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // send email verifikasi
      await myUser.user!.sendEmailVerification();
      // show alert dialog
      alert.myAlertDialog(
          context,
          "Email verifikasi sudah dikirim ke $email",
          TextButton(
              onPressed: () {
                // show snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                    mySnackbar("Register berhasil", Colors.green));
                // go to home
                navigateRemoveUntil(context, const LoginScreen());
              },
              child: const Text("Ok, saya cek dulu")));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
        ScaffoldMessenger.of(context)
            .showSnackBar(mySnackbar("Password lemah", Colors.red));
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
        ScaffoldMessenger.of(context)
            .showSnackBar(mySnackbar("Email sudah digunakan", Colors.red));
      } else {
        log(e.toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(mySnackbar(e.toString(), Colors.red));
      }
    }
  }

  // login
  static Future<void> loginUser(
      BuildContext context, String email, String password) async {
    try {
      UserCredential myUser = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (myUser.user!.emailVerified) {
        // show snackbar
        ScaffoldMessenger.of(context)
            .showSnackBar(mySnackbar("Login berhasil", Colors.green));
        // go to home
        navigateRemoveUntil(context, const HomeScreen());
      } else {
        alert.myAlertDialog(
            context,
            "Email belum diverifikasi, coba cek email kamu dulu",
            TextButton(
                onPressed: () async {
                  await myUser.user!.sendEmailVerification();
                  // back
                  Navigator.pop(context);
                  // show snackbar
                  ScaffoldMessenger.of(context).showSnackBar(mySnackbar(
                      "Email verifikasi berhasil dikirimkan", Colors.green));
                },
                child: const Text("Kirim email verifikasi lagi")));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
        ScaffoldMessenger.of(context)
            .showSnackBar(mySnackbar("User tidak ditemukan", Colors.red));
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
        ScaffoldMessenger.of(context)
            .showSnackBar(mySnackbar("Passwordnya salah", Colors.red));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(mySnackbar(e.toString(), Colors.red));
      }
    }
  }

  // logout
  static Future<void> logoutUser(BuildContext context) async {
    await auth.signOut();
    // go to login
    navigateRemoveUntil(context, const LoginScreen());
  }
}
