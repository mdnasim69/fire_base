import 'package:fire_base/Controllers/SignUp_controller.dart';
import 'package:fire_base/Utils/Utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // SignUpController signUpController = Get.put(SignUpController());

  @override
  void initState() {
    Get.put(SignUpController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text("SignUp Screen"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              const Text(
                "Create Account",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              EmailTextField(),
              const SizedBox(height: 20),
              PasswordTextField(),
              const SizedBox(height: 30),
              GetBuilder<SignUpController>(
                builder: (controller) {
                  return Visibility(
                    visible: controller.Loading == false,
                    replacement: CircularProgressIndicator(),
                    child: AuthButton(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          bool res = await controller.SignUp(
                            _emailController.text,
                            _passwordController.text,
                          );
                          if (!res) {
                            Utils.Message(
                              controller.error.toString(),
                              context,
                              true,
                            );
                          } else {

                            Utils.Message("SignUp success", context);
                            Navigator.pop(context);
                          }
                        }
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              OrDivider(),
              const SizedBox(height: 20),
              MobileWidget(
                onTap: () {
                  //TODO: on tap will be here
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
                  Navigator.pop(context);
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
          text: "Already have account !",
          style: const TextStyle(color: Colors.grey, fontSize: 16),
          children: [
            TextSpan(
              recognizer: TapGestureRecognizer()..onTap = onTap,
              text: "  SignIn",
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
        child: const Text("Sign Up", style: TextStyle(fontSize: 18)),
      ),
    );
  }

  TextFormField PasswordTextField() {
    return TextFormField(
      validator: (String? value) {
        if (value!.isEmpty) {
          return "enter your email";
        }
        return null;
      },
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  TextFormField EmailTextField() {
    return TextFormField(
      validator: (String? value) {
        if (value!.isEmpty) {
          return "enter your email";
        }
        return null;
      },
      controller: _emailController,

      decoration: InputDecoration(
        labelText: "email",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
