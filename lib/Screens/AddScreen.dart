import 'package:fire_base/Utils/Utils.dart';
import 'package:fire_base/auth/saveUserUID.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Addscreen extends StatefulWidget {
  const Addscreen({super.key});

  @override
  State<Addscreen> createState() => _AddscreenState();
}

class _AddscreenState extends State<Addscreen> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();
  final databaseRef = FirebaseDatabase.instance.ref(UserUID.token);

  RxInt loading = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(hintText: "title"),
              controller: titleController,
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(hintText: "description"),
              controller: descriptionController,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                loading.value = 1;
                String id = DateTime.now().millisecondsSinceEpoch.toString();
                databaseRef
                    .child(id)
                    .set({
                      'id': id,
                      'title': titleController.text.toString(),
                      "description": descriptionController.text.toString(),
                    })
                    .then((v) {
                      Utils.Message("added".toString(), context);
                      loading.value = 0;
                    })
                    .onError((e, t) {
                      Utils.Message(e.toString(), context, true);
                      loading.value = 0;
                    });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
                fixedSize: Size.fromWidth(double.maxFinite),
              ),
              child: Obx(() {
                return loading.value == 0
                    ? Text("Add")
                    : CircularProgressIndicator();
              }),
            ),
          ],
        ),
      ),
    );
  }
}
