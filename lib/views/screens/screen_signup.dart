import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speakup_bridge/views/screens/screen_signup_2.dart';
import '../../constants/colors/colors.dart';
import '../../widgtes/my_custom_button.dart';

class ScreenSignup extends StatefulWidget {
  const ScreenSignup({Key? key}) : super(key: key);

  @override
  _ScreenSignupState createState() => _ScreenSignupState();
}

class _ScreenSignupState extends State<ScreenSignup> {
  // Variable to track the selected option
  String? _selectedOption;

  // List of options
  final List<Map<String, String>> _options = [
    {"icon": "assets/images/suitecase 1.png", "title": "Boost my Career"},
    {"icon": "assets/images/jhaz 1.png", "title": "Prepare for Travel"},
    {"icon": "assets/images/fun 1.png", "title": "Just for Fun"},
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
              children: [
                Column(
                  children: const [
                    Text(
                      "Why are you learning ",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                    Text(
                      "English?",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                  ],
                ),
                Image.asset("assets/images/what 1.png"),
              ],
            ),
            const SizedBox(
              height: 26,
            ),
            // Display options
            ..._options.map((option) {
              final isSelected = _selectedOption == option["title"];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedOption = option["title"];
                  });
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: isSelected ? Colors.blue : Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                    color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.white,
                  ),
                  child: ListTile(
                    leading: Image.asset(option["icon"]!),
                    title: Text(option["title"]!),
                    trailing: Icon(
                      isSelected ? Icons.check_circle : Icons.check_circle_outline,
                      color: isSelected ? appPrimaryColor : null,
                    ),
                  ),
                ),
              );
            }).toList(),
            const SizedBox(
              height: 230,
            ),
            // Continue button
            MyCustomButton(
              text: "Continue",
              width: 200,
              loading: false,
              onTap: () {
                if (_selectedOption != null) {
                  Get.to(ScreenSignup2());
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
