import 'package:flutter/material.dart';
import 'package:flutterfire_auth/auth/auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
              onPressed: () {
                Auth.logoutUser(context);
              },
              icon: const Icon(Icons.logout_rounded))
        ],
      ),
    );
  }
}
