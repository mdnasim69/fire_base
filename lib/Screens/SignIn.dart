import 'package:fire_base/Screens/SignUp_screen.dart';
import 'package:fire_base/Screens/home_screen.dart';
import 'package:fire_base/Utils/Utils.dart';
import 'package:fire_base/auth/saveUserUID.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text("Login Screen"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              const Text(
                "Login Account",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              EmailTextField(),
              const SizedBox(height: 20),
              PasswordTextField(),
              const SizedBox(height: 30),
              AuthButton(
                onTap: () {
                  auth
                      .signInWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text,
                  ).then((v)  async {
                    await UserUID.saveData(v.user!.uid);
                    print('nasim nasim nasim nasim naism////////////');
                    print(v.user!.uid);
                    print(UserUID.token.toString());
                    Utils.Message("success", context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  })
                      .onError((e, t) {
                    Utils.Message(e.toString(), context, true);
                  });
                },
              ),
              const SizedBox(height: 30),
              OrDivider(),
              const SizedBox(height: 20),
              MobileWidget(
                onTap: () {
                  //TODO: on tap will be here
                  print("ok");
                },
              ),
              SizedBox(height: 30),
              // Google Sign In Button
              GoogleWidget(
                onTap: () {
                  print("ok");
                },
              ),
              SizedBox(height: 30),
              GoToSiginIN(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Align GoToSiginIN({onTap}) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: RichText(
        text: TextSpan(
          text: "Don't have account !",
          style: const TextStyle(color: Colors.grey, fontSize: 16),
          children: [
            TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = onTap,
              text: "  Sign up",
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox GoogleWidget({onTap}) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 13),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/2048px-Google_%22G%22_logo.svg.png",
              height: 24,
            ),
            const SizedBox(width: 12),
            const Text(" with Google", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  InkWell MobileWidget({onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.phone_android, size: 24),
            const SizedBox(width: 12),
            const Text(
              " with Phone",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Row OrDivider() {
    return Row(
      children: const [
        Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text("OR"),
        ),
        Expanded(child: Divider()),
      ],
    );
  }

  SizedBox AuthButton({required onTap}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.greenAccent,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text("Sign In", style: TextStyle(fontSize: 18)),
      ),
    );
  }

  TextField PasswordTextField() {
    return TextField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  TextField EmailTextField() {
    return TextField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: "email",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
