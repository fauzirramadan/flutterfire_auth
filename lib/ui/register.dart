import 'package:flutter/material.dart';

import '../auth/auth.dart';
import '../utils/const.dart';
import '../utils/loading_view.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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

  void register() async {
    setState(() {
      isLoading = true;
    });
    await Auth.registerUser(context, emailC.text, passwordC.text);
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
                  "R E G I S T E R",
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
                      register();
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
                        "R E G I S T E R",
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
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Sudah punya akun? masuk disini",
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
