import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speakup_bridge/constants/colors/colors.dart';
import '../../widgtes/my_custom_button.dart';
import 'screen_signup_3.dart';

class ScreenSignup2 extends StatefulWidget {
  const ScreenSignup2({Key? key}) : super(key: key);

  @override
  _ScreenSignup2State createState() => _ScreenSignup2State();
}

class _ScreenSignup2State extends State<ScreenSignup2> {
  // Variable to track the selected level
  String? _selectedLevel;

  // List of levels
  final List<Map<String, String>> _levels = [
    {"title": "Beginners", "subtitle": "Start learning from Scratch"},
    {"title": "Intermediate", "subtitle": "Answer some Questions, Ready?"},
    {"title": "Expert", "subtitle": "Answer some Questions, Ready?"},
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
                      "Please Select Level for ",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                    Text(
                      "your Learning?",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                  ],
                ),
                Image.asset("assets/images/what 1.png"),
              ],
            ),
            const SizedBox(height: 26),
            // Display levels
            ..._levels.map((level) {
              final isSelected = _selectedLevel == level["title"];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedLevel = level["title"];
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
                    title: Text(
                      level["title"]!,
                      style: TextStyle(
                        color: appPrimaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(level["subtitle"]!),
                    trailing: Icon(
                      isSelected ? Icons.check_circle : Icons.check_circle_outline,
                      color: isSelected ? appPrimaryColor : null,
                    ),
                  ),
                ),
              );
            }).toList(),
            const SizedBox(height: 230),
            // Continue button
            MyCustomButton(
              text: "Continue",
              width: 200,
              loading: false,
              onTap: () {
                if (_selectedLevel != null) {
                  Get.to(ScreenSignup3());
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please select a level before continuing."),
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

