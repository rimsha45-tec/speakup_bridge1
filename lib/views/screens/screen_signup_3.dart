import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speakup_bridge/views/screens/screen_signup_final.dart';
import '../../constants/colors/colors.dart';
import '../../widgtes/my_custom_button.dart';

class ScreenSignup3 extends StatefulWidget {
  const ScreenSignup3({Key? key}) : super(key: key);

  @override
  _ScreenSignup3State createState() => _ScreenSignup3State();
}

class _ScreenSignup3State extends State<ScreenSignup3> {
  // Variable to track the selected option
  String? selectedOption;

  // List of options
  final List<Map<String, String>> options = [
    {"title": "Friends/Family", "image": "assets/images/people.png"},
    {"title": "Facebook", "image": "assets/images/fb icon.png"},
    {"title": "Tiktok", "image": "assets/images/tiktok icon.png"},
    {"title": "Google", "image": "assets/images/google icon.png"},
    {"title": "Others", "image": "assets/images/others icon.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text(
                  "How do you hear about  ",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
                Text(
                  "us?",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
              ],
            ),
            const SizedBox(height: 26),
            // Display options
            ...options.map((option) {
              final isSelected = selectedOption == option["title"];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedOption = option["title"];
                  });
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: isSelected ? appPrimaryColor : Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                    color: isSelected ? appPrimaryColor.withOpacity(0.1) : Colors.white,
                  ),
                  child: ListTile(
                    leading: Image.asset(option["image"]!),
                    title: Text(
                      option["title"]!,
                      style: TextStyle(
                        color: appPrimaryColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    trailing: Icon(
                      isSelected ? Icons.check_circle : Icons.check_circle_outline,
                      color: isSelected ? appPrimaryColor : null,
                    ),
                  ),
                ),
              );
            }).toList(),
            const SizedBox(height: 80),
            // Continue button
            MyCustomButton(
              text: "Continue",
              width: 200,
              loading: false,
              onTap: () {
                if (selectedOption != null) {
                  Get.to(ScreenSignupFinal()); // Replace ScreenSignup3 with the correct next screen
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please select an option before continuing."),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
