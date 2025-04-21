import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';
import 'package:speakup_bridge/views/screens/screen_chapter_01_lesson_01_screen_04.dart';
import 'package:speakup_bridge/views/screens/screen_view_examples.dart';

import '../../constants/colors/colors.dart';
import '../../widgtes/medium_text.dart';
import '../../widgtes/my_custom_button.dart';

class ScreenChapter01Lesson01Screen03 extends StatelessWidget {
  const ScreenChapter01Lesson01Screen03({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Learn Daily Vocabulary "),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
          Get.back();
        },),
      ),
      body: SingleChildScrollView(
        child: Column(
            children: [
              Container(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("2/12", style: TextStyle(color: appPrimaryColor)),
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/diamonds.png", height: 15,),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                "600k", style: TextStyle(color: appPrimaryColor),)
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      ProgressBar(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        value: 0.2,
                        //specify only one: color or gradient
                        //color:Colors.red,
                        color: appPrimaryColor,
                        backgroundColor: Colors.grey.shade300,
                      ),
                      SizedBox(
                        height: 43,
                      ),
                      Row(
                        children: [
                          Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Image.asset("assets/images/volume-high.png")),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  MediumText(text: "Accomplish"),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(Icons.volume_down,color: appPrimaryColor,),
                                ],
                              ),
                              Text("to finish something successfully or "),
                              Text("to achieve something"),
                            ],
                          ),
                          
                        ],)
                    ],
                  )
              ),
              SizedBox(
                height: 70,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: MediumText(text: "Pronunciation:")),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Icon(Icons.volume_down,color: appPrimaryColor,),
                      Text("UK:  /əˈbʌv/"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.volume_down,color: appPrimaryColor,),
                      Text("US:  /əˈbʌv/"),
                    ],
                  ),


                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.2,
              ),
              GestureDetector(
                onTap: (){
                  //Get.to(ScreenViewExamples());
                },
                child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(12),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("View Examples and Practice"),
                        Icon(Icons.remove_red_eye,color: appPrimaryColor,)
                      ],
                    )
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.1,
              ),
              MyCustomButton(text: "Continue", loading: false, onTap: (){
                Get.to(ScreenChapter01Lesson01Screen04());

              },

              )
            ]
        ),
      ),
    );
  }
}
