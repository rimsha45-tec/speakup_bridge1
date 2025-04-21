import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:speakup_bridge/views/screens/screen_login.dart';

import '../../constants/colors/colors.dart';
import '../../widgtes/large_text.dart';
import '../../widgtes/medium_text.dart';
import '../../widgtes/my_custom_button.dart';
import '../../widgtes/small_text.dart';

class ScreenBoarding extends StatelessWidget {
  const ScreenBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageController _controller = PageController();
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(padding: EdgeInsets.all(5),
              child: TextButton(child: Text("Skip",style: TextStyle(color: Colors.grey,fontSize:18 ),),
                onPressed: () {
                Get.to(ScreenLogin());
                },))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              children: [
                Container(child: Image.asset("assets/images/learn-language.png"),),
                Container(child: Image.asset("assets/images/learn-language2.png"),),
                Container(child: Image.asset("assets/images/learn-language3.png"),),
              ],
            ),
          ),
          SizedBox(height: 16),
          SmoothPageIndicator(
            controller: _controller,
            count: 3,
            effect: WormEffect(
              dotHeight: 12,
              dotWidth: 12,
              spacing: 8,
              dotColor: Colors.grey,
              activeDotColor: appPrimaryColor,
            ),
          ),
          SizedBox(height: 16),
          LargeText(text: "Confidence in your words"),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: SmallText(text: "With conversation-based learning, you'll be talking from lesson one")),
          SizedBox(height: 40),
          MyCustomButton(text: "Continue", loading: false, onTap: (){

          },

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MediumText(text: "Already a user? "),
              TextButton(onPressed: () {
                Get.to(ScreenLogin());
              },
              child: MediumText(text: " Login",color: appPrimaryColor,)),
            ],

          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}
