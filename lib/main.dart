import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_auth/auth/auth.dart';
import 'package:flutterfire_auth/ui/home.dart';
import 'package:flutterfire_auth/ui/login.dart';
import 'package:flutterfire_auth/utils/loading_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: Auth.streamAuthStatus,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            log(snapshot.data.toString());
            return MaterialApp(
              title: 'Flutterfire Auth',
              theme: ThemeData(
                primarySwatch: Colors.blueGrey,
              ),
              home:
                  snapshot.data != null && snapshot.data!.emailVerified == true
                      ? const HomeScreen()
                      : const LoginScreen(),
            );
          }
          return const Center(
            child: LoadingView(),
          );
        });
  }
}
