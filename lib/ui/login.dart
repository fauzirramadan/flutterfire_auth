import 'package:flutter/material.dart';
import 'package:flutterfire_auth/auth/auth.dart';
import 'package:flutterfire_auth/ui/register.dart';
import 'package:flutterfire_auth/utils/const.dart';
import 'package:flutterfire_auth/utils/loading_view.dart';
import 'package:flutterfire_auth/utils/navigator_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void dispose() {
    emailC.dispose();
    passwordC.dispose();
    super.dispose();
  }

  void login() async {
    setState(() {
      isLoading = true;
    });
    await Auth.loginUser(context, emailC.text, passwordC.text);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: keyForm,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 60.0, right: 20, left: 20),
            child: Column(
              children: [
                const Text(
                  "L O G I N",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: emailC,
                  validator: (value) {
                    return value!.isEmpty ? "Tidak boleh kosong" : null;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12)),
                      suffixIcon: const Icon(Icons.email_rounded),
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: "Email"),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: true,
                  controller: passwordC,
                  validator: (value) {
                    return value!.isEmpty ? "Tidak boleh kosong" : null;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: defaultShape),
                      suffixIcon: const Icon(Icons.security_rounded),
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: "Password"),
                ),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: () {
                    bool isValid = keyForm.currentState!.validate();
                    if (isValid) {
                      login();
                    }
                  },
                  shape: RoundedRectangleBorder(borderRadius: defaultShape),
                  height: 50,
                  color: Colors.blueGrey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isLoading ? const LoadingView() : const SizedBox(),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "L O G I N",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    navigatePush(context, const RegisterScreen());
                  },
                  child: const Text(
                    "Belum punya akun? daftar disini",
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
