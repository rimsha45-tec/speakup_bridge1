import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';
import 'package:speakup_bridge/views/screens/screen_chapter_01_lesson_01_screen10.dart';

import '../../constants/colors/colors.dart';
import '../../widgtes/medium_text.dart';
import '../../widgtes/my_custom_button.dart';

class ScreenChapter01Lesson01Screen9 extends StatelessWidget {
  const ScreenChapter01Lesson01Screen9({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complete Lesson  "),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
          Get.back();
        },),
      ),
      body: SingleChildScrollView(
        child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Image.asset("assets/images/congratulations.png"),
              SizedBox(
                height: 30,
              ),
              Text("CONGRATULATIONS",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600,color: appPrimaryColor),),
              SizedBox(
                height: 30,
              ),
              Text("     Cheers! You have \nsuccessfully complete your \n  level #1 of your Lesson #1 "),
              SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width*0.6,
                padding: EdgeInsets.symmetric(vertical: 6,horizontal: 20),
                decoration: BoxDecoration(
                  color: appPrimaryColor,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.repeat,color: Colors.white,),
                    Text("repeat wrong answer",style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.02,
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height*0.1,
              ),
              MyCustomButton(text: "Finish Lesson ",loading: false,onTap: (){
                Get.to(ScreenChapter01Lesson01Screen10());

              },
                buttonColor: Colors.grey,

              )
            ]
        ),
      ),
    );
  }
}
