import 'package:flutter/material.dart';
import 'package:flutterfire_auth/controller/update_data.dart';

import '../utils/const.dart';
import '../utils/custom_textfield.dart';

class UpdateDataForm extends StatefulWidget {
  final String docId;
  final dynamic dataDocs;
  const UpdateDataForm(
      {super.key, required this.docId, required this.dataDocs});

  @override
  State<UpdateDataForm> createState() => _UpdateDataFormState();
}

class _UpdateDataFormState extends State<UpdateDataForm> {
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    UpdateDataController.foopdNameC.text = widget.dataDocs["name"];
    UpdateDataController.priceC.text = widget.dataDocs["price"];
    UpdateDataController.stockC.text = widget.dataDocs["stock"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blueGrey[200],
      appBar: AppBar(
        title: const Text("UPDATE YOUR FOOD"),
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
                    controller: UpdateDataController.foopdNameC,
                    inputType: TextInputType.name,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyFormField(
                    title: "Price",
                    controller: UpdateDataController.priceC,
                    inputType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyFormField(
                    title: "Stock",
                    controller: UpdateDataController.stockC,
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
                        UpdateDataController.updateFood(
                            widget.docId,
                            UpdateDataController.foopdNameC.text,
                            UpdateDataController.priceC.text,
                            UpdateDataController.stockC.text,
                            context);
                      }
                    },
                    color: Colors.blueGrey,
                    height: 50,
                    minWidth: 200,
                    child: const Text(
                      "UPDATE FOOD",
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
