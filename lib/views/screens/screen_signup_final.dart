import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speakup_bridge/views/screens/screen_user_home_page.dart';
import '../../services/auth.dart';
import '../../shared/loading.dart';
import '../../widgtes/my_input_feild2.dart';
import '../../widgtes/my_custom_button.dart';
import '../../widgtes/my_input_field3.dart';
import '../../widgtes/my_input_field4.dart';

class ScreenSignupFinal extends StatelessWidget {
  final isChecked = false.obs;
  final showPassword = false.obs;
  final showConfirmPassword = false.obs;
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final loading = false.obs;

  final fullName = ''.obs;
  final email = ''.obs;
  final password = ''.obs;
  final confirmPassword = ''.obs;
  final error = ''.obs;

  ScreenSignupFinal({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => loading.value
        ? const Loading()
        : Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
        title: const Text("Signup"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Image.asset("assets/images/learn at home1.png"),
              const SizedBox(height: 25),
              const Padding(
                padding: EdgeInsets.only(left: 25),
                child: Text(
                  "Welcome back to learn something new",
                  style:
                  TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 35),

              // Full Name Field
              MyInputField3(
                label: "Full Name",
                validator: (val) => val!.length < 3
                    ? 'Full Name must be at least 3 characters'
                    : null,
                onChange: (val) => fullName.value = val!,
                obscureText: false,
                initialValue: '',
              ),
              const SizedBox(height: 8),

              // Email Field
              MyInputField3(
                label: "Email",
                validator: (val) =>
                val!.isEmpty ? 'Enter an email' : null,
                onChange: (val) => email.value = val!,
                obscureText: false,
                initialValue: '',
              ),
              const SizedBox(height: 8),
              // Password Field
              Obx(
                    () => MyInputField4(
                  isPasswordField: true,
                  label: "Password",
                  suffix: IconButton(
                    icon: Icon(
                      showPassword.value ? Icons.visibility : Icons.visibility_off,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      showPassword.value = !showPassword.value;
                    },
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Password is required';
                    }
                    if (val.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                  onChange: (val) => password.value = val!,
                  obscureText: !showPassword.value,
                  initialValue: '', onChanged: (value) {  },
                ),
              ),

              const SizedBox(height: 8),

              // Confirm Password Field
              Obx(
                    () => MyInputField4(
                  isPasswordField: true,
                  label: "Confirm Password",
                  suffix: IconButton(
                    icon: Icon(
                      showConfirmPassword.value ? Icons.visibility : Icons.visibility_off,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      showConfirmPassword.value = !showConfirmPassword.value;
                    },
                  ),
                  validator: (val) {
                    if (val != password.value) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  onChange: (val) => confirmPassword.value = val!,
                  obscureText: !showConfirmPassword.value,
                  initialValue: '', onChanged: (value) {  },
                ),
              ),

              const SizedBox(height: 5),

              // Terms & Conditions Checkbox
              Row(
                children: [
                  Obx(() => Checkbox(
                    value: isChecked.value,
                    onChanged: (bool? value) {
                      isChecked.value = value ?? false;
                    },
                  )),
                  GestureDetector(
                    onTap: () {},
                    child: RichText(
                      text: const TextSpan(
                        text: "I understood the ",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        children: <TextSpan>[
                          TextSpan(
                            text: "terms & policy.",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Sign Up Button
              MyCustomButton(
                text: "Sign Up",
                width: 200,
                loading: loading.value,
                onTap: () async {
                  if (!isChecked.value) {
                    Get.snackbar(
                      "Terms & Policy",
                      "Please check the terms & policy to continue.",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  } else if (_formKey.currentState!.validate()) {
                    loading.value = true;

                    dynamic result = await _auth.signUpWithEmailAndPassword(
                      fullName.value,
                      email.value,
                      password.value,
                      confirmPassword.value,
                    );

                    loading.value = false;

                    if (result == null) {
                      error.value = 'Signup failed. Please try again.';
                      Get.snackbar(
                        "Sign Up Failed",
                        error.value,
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    } else {
                      Get.offAll(() => ScreenUserHomePage());
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}