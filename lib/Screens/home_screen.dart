import 'package:fire_base/Screens/AddScreen.dart';
import 'package:fire_base/Screens/Splash_screen.dart';
import 'package:fire_base/Utils/Utils.dart';
import 'package:fire_base/auth/saveUserUID.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseAuth auth = FirebaseAuth.instance;

  final database = FirebaseDatabase.instance.ref(UserUID.token);

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
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: database.onValue,
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                 return Center(child:CircularProgressIndicator(),);
                }else{
                  Map<dynamic,dynamic> map =snapshot.data!.snapshot.value as dynamic;
                  List<dynamic> list =[];
                  list.clear();
                  list=map.values.toList();
                  return ListView.builder(
                    itemCount:snapshot.data?.snapshot.children.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(list[index]['title']),
                        subtitle:Text(list[index]["description"]),
                      );
                    },
                  );
                }


              },
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
              query: database,
              itemBuilder: (context, snapshot, animation, index) {
                return Card(
                  child: ListTile(
                    title: Text(snapshot.child('title').value.toString()),
                    subtitle: Text(
                      snapshot.child("description").value.toString(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
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
