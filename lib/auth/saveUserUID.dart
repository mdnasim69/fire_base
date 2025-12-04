import 'package:shared_preferences/shared_preferences.dart';

class UserUID {
  static String? token;
 static saveData(String uid) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
   await preferences.setString('uid', uid);
    token = uid;
  }

   static Future<void> getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? uid =preferences.getString('uid');
    token=uid;
  }

  static ClearData()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

}
