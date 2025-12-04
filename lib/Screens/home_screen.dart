import 'package:fire_base/Screens/AddScreen.dart';
import 'package:fire_base/Screens/Splash_screen.dart';
import 'package:fire_base/Utils/Utils.dart';
import 'package:fire_base/auth/saveUserUID.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        actions: [
          IconButton(
            onPressed: () {
              auth
                  .signOut()
                  .then((v) {
                    UserUID.ClearData();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => SplashScreen()),
                      (predicate) => false,
                    );
                  })
                  .onError((e, t) {
                    Utils.Message(e.toString(), context, true);
                  });
            },
            icon: Icon(Icons.login_outlined),
          ),
        ],
        automaticallyImplyLeading: false,
        title: Text("Home  (${UserUID.token})"),
      ),
      body: Column(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Addscreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
