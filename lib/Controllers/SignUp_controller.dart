import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpController extends GetxController {
  bool Loading = false;
  String? error;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> SignUp(String email, String password) async {
    Loading = true;
    update();
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ).then((v){});
      Loading = false;
      update();
      return true;
    } catch (e) {
      error = e.toString();
      Loading = false;
      update();
      return false;
    }
  }
}
