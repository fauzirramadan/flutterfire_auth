import 'package:flutter/material.dart';
import 'package:flutterfire_auth/controller/add_data.dart';
import 'package:flutterfire_auth/utils/const.dart';

import '../utils/custom_textfield.dart';

class AddDataForm extends StatefulWidget {
  const AddDataForm({super.key});

  @override
  State<AddDataForm> createState() => _AddDataFormState();
}

class _AddDataFormState extends State<AddDataForm> {
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blueGrey[200],
      appBar: AppBar(
        title: const Text("ADD YOUR FOOD"),
        centerTitle: true,
      ),
      body: Form(
        key: keyForm,
        child: Container(
          margin: const EdgeInsets.all(50),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.6,
          child: Card(
            color: Colors.grey[200],
            shape: RoundedRectangleBorder(borderRadius: defaultShape),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  MyFormField(
                    title: "Food Name",
                    controller: AddDataController.foopdNameC,
                    inputType: TextInputType.name,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyFormField(
                    title: "Price",
                    controller: AddDataController.priceC,
                    inputType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyFormField(
                    title: "Stock",
                    controller: AddDataController.stockC,
                    inputType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(borderRadius: defaultShape),
                    onPressed: () {
                      bool isValid = keyForm.currentState!.validate();
                      if (isValid) {
                        AddDataController.addFood(
                            AddDataController.foopdNameC.text,
                            AddDataController.priceC.text,
                            AddDataController.stockC.text,
                            context);
                      }
                    },
                    color: Colors.blueGrey,
                    height: 50,
                    minWidth: 200,
                    child: const Text(
                      "ADD FOOD",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
