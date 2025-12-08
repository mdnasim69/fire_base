import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base/Screens/firestore_database_post_screeen.dart';
import 'package:fire_base/auth/saveUserUID.dart';
import 'package:flutter/material.dart';

class ViewScreen extends StatefulWidget {
  const ViewScreen({super.key});

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  final firestore = FirebaseFirestore.instance.collection(
    UserUID.token.toString(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          StreamBuilder(
            stream: firestore.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.error != null) {
                return Center(child: Text("something went wrong"));
              }
                return Expanded(
                  child: ListView.builder(
                    itemCount:snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data!.docs[index]['title']),
                        subtitle:Text(snapshot.data!.docs[index]['description']),
                        onTap:(){},
                      );
                    },
                  ),
                );
            },
          ),
        ],
      ),
      appBar: AppBar(backgroundColor: Colors.green),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PostScreen()),
          );
        },
      ),
    );
  }
}
