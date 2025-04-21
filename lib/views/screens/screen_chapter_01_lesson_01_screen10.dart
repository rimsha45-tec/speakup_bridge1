import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speakup_bridge/views/screens/screeb_chat.dart';
import '../../widgtes/my_custom_button.dart';

class ScreenChapter01Lesson01Screen10 extends StatefulWidget {
  @override
  _ScreenChapter01Lesson01Screen10State createState() => _ScreenChapter01Lesson01Screen10State();
}

class _ScreenChapter01Lesson01Screen10State extends State<ScreenChapter01Lesson01Screen10> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Learn English",
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Avatar Image (Top Section)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset(
              "assets/images/avatar.png",
              height: 180,
              fit: BoxFit.contain,
            ),
          ),

          SizedBox(height: 30),

          /// Text Instruction
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Press Continue to chat with our chatbot and improve your English.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),
            ),
          ),

          SizedBox(height: 40),

          /// **Continue Button**
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: MyCustomButton(
              text: "Continue",
              loading: false,
              onTap: () {
                Get.to(EnglishLearningChatbot());
              },
            ),
          ),
        ],
      ),
    );
  }
}
