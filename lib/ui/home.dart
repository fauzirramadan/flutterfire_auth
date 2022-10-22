import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_auth/auth/auth.dart';
import 'package:flutterfire_auth/controller/get_data.dart';
import 'package:flutterfire_auth/ui/add_data_form.dart';
import 'package:flutterfire_auth/ui/update_data_form.dart';
import 'package:flutterfire_auth/utils/const.dart';
import 'package:flutterfire_auth/utils/loading_view.dart';
import 'package:flutterfire_auth/utils/my_alert.dart';
import 'package:flutterfire_auth/utils/navigator_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MyAlertDialog alert = MyAlertDialog();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
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
      body: StreamBuilder<QuerySnapshot<Object?>>(
          stream: GetDataController.getData(),
          builder: (context, snapshot) {
            final data = snapshot.data?.docs;
            if (snapshot.hasError) {
              return const Center(
                child: Text("ERROR WHEN GETTING DATA"),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingView();
            }
            if (snapshot.data!.size == 0) {
              return const Center(
                child: Text(
                  "NO DATA",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              );
            }
            return ListView.builder(
                itemCount: data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: defaultShape),
                      color: Colors.grey[200],
                      child: ListTile(
                        leading: IconButton(
                          onPressed: () {
                            navigatePush(
                                context,
                                UpdateDataForm(
                                  docId: data[index].id,
                                  dataDocs: data[index],
                                ));
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        title: Text(data[index]["name"]),
                        subtitle: Text(data[index]["price"]),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(data[index]["stock"]),
                            IconButton(
                                onPressed: () {
                                  alert.myAlertDialog(
                                      context,
                                      "Apakah anda yakin ingin menghapus data ini?",
                                      TextButton(
                                          onPressed: () {
                                            GetDataController.deleteData(
                                                data[index].id, context);
                                            Navigator.pop(context);
                                          },
                                          child: const Text("YES")));
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ))
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: MaterialButton(
          textColor: Colors.white,
          onPressed: () {
            navigatePush(context, const AddDataForm());
          },
          shape: RoundedRectangleBorder(borderRadius: defaultShape),
          color: Colors.blueGrey,
          height: 50,
          child: const Text(
            "ADD FOOD",
          ),
        ),
      ),
    );
  }
}
