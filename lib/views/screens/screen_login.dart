import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speakup_bridge/constants/colors/colors.dart';
import 'package:speakup_bridge/views/screens/screen_forget.dart';
import 'package:speakup_bridge/views/screens/screen_signup.dart';
import 'package:speakup_bridge/views/screens/screen_user_home_page.dart';
import 'package:speakup_bridge/widgtes/medium_text.dart';
import 'package:speakup_bridge/widgtes/my_custom_button.dart';
import 'package:speakup_bridge/widgtes/my_input_feild2.dart';
import 'package:speakup_bridge/widgtes/small_text.dart';
import '../../Controller/controller_login.dart';
import '../../services/auth.dart';
import '../../shared/loading.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({Key? key}) : super(key: key);

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  bool isChecked = false;
  bool _obscurePassword = true;
  final AuthService _auth = AuthService();
  bool loading = false;
  String email = '';
  String password = '';
  String error = '';

  @override
  void initState() {
    super.initState();
    _loadUserCredentials();
  }

  // Load saved email and password from SharedPreferences
  Future<void> _loadUserCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email') ?? '';
      password = prefs.getString('password') ?? '';
      isChecked = prefs.getBool('isChecked') ?? false;
    });
  }

  // Save email and password to SharedPreferences
  Future<void> _saveUserCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    if (isChecked) {
      await prefs.setString('email', email);
      await prefs.setString('password', password);
      await prefs.setBool('isChecked', true);
    } else {
      await prefs.remove('email');
      await prefs.remove('password');
      await prefs.setBool('isChecked', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
             // Image.asset("assets/images/learn_at_home1.png"),
              const SizedBox(height: 25),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 25),
                child: const Text(
                  "Welcome back to learn something new",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 35),
              MyInputField2(
                prefix: Icon(Icons.email_outlined, color: Colors.grey.shade600),
                hint: "Email",
                obscureText: false,
                initialValue: email,
                onChange: (val) {
                  setState(() {
                    email = val!;
                  });
                },
                fillColor: Colors.grey.shade200, onChanged: (value) {  },
              ),
              MyInputField2(
                isPasswordField: true,
                obscureText: _obscurePassword,
                initialValue: password,
                onChange: (val) {
                  setState(() {
                    password = val!;
                  });
                },
                suffix: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                prefix: Icon(Icons.key, color: Colors.grey.shade600),
                hint: "Password",
                fillColor: Colors.grey.shade200, onChanged: (value) {  },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value ?? false;
                          });
                        },
                      ),
                      SmallText(text: "Remember me ", color: Colors.grey.shade800),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => const ScreenForget());
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(color: appPrimaryColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 35),
              MyCustomButton(
                text: "Login",
                width: 200,
                loading: loading,
                onTap: () async {
                  setState(() {
                    loading = true;
                  });

                  dynamic result = await _auth.signInWithEmailAndPassword(email, password);

                  if (result == null) {
                    setState(() {
                      loading = false;
                      error = 'Please enter a valid email or password';
                    });

                    Get.snackbar(
                      "Login Failed",
                      error,
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  } else {
                    await _saveUserCredentials();
                    Get.offAll(() =>  ScreenUserHomePage());
                  }
                },
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MediumText(text: "Don't have an account? "),
                  TextButton(
                    onPressed: () {
                      Get.to(() => const ScreenSignup());
                    },
                    child: MediumText(text: " Sign up", color: appPrimaryColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
