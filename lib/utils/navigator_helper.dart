import 'package:flutter/material.dart';

Future navigateRemoveUntil(BuildContext context, Widget page) async {
  return Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (_) => page), (route) => false);
}

Future navigatePush(BuildContext context, Widget page) async {
  return Navigator.push(context, MaterialPageRoute(builder: (_) => page));
}
