import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base/Utils/Utils.dart';
import 'package:fire_base/auth/saveUserUID.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  final firebaseFirestore = FirebaseFirestore.instance.collection(
    UserUID.token.toString(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("add"), backgroundColor: Colors.greenAccent),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
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
                Add();
                },
              style: ElevatedButton.styleFrom(
                fixedSize: Size.fromWidth(double.maxFinite),
                backgroundColor: Colors.lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text("add"),
            ),
          ],
        ),
      ),
    );
  }

  Add() {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    firebaseFirestore
        .doc(id)
        .set({
          'title': titleController.text,
          "description": descriptionController.text,
          'id': id,
        })
        .then((v) {
          Utils.Message('added', context);
        })
        .onError((e, t) {
          Utils.Message(e.toString(), context);
        });
  }
}
