import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';
import 'package:speakup_bridge/views/screens/screen_chapter_01_lesson_01_screen_06.dart';

import '../../constants/colors/colors.dart';
import '../../widgtes/medium_text.dart';
import '../../widgtes/my_custom_button.dart';

class ScreenChapter01Lesson01Screen05 extends StatelessWidget {
  const ScreenChapter01Lesson01Screen05({Key? key}) : super(key: key);

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
                          Text("5/12", style: TextStyle(color: appPrimaryColor)),
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
                        value: 0.5,
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
                                  Text( "Choose the write Meaning "),

                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  MediumText(text: "Achievement"),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(Icons.volume_down,color: appPrimaryColor,),
                                ],
                              ),
                            ]
                          ),

                        ],)
                    ],
                  )
              ),

              SizedBox(
                height: 70,
              ),
              Container(
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: ListTile(
                  leading: Text("something very good and difficult that you \nhave succeeded in doing",style: TextStyle(color: Colors.green),),
                  trailing: Icon(Icons.check_circle,color: Colors.green,),
                ),
              ),
              Container(
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: ListTile(
                  leading: Text("to finish something successfully or \nto achieve something",style: TextStyle(color: Colors.black),),
                  trailing: Icon(Icons.radio_button_unchecked_rounded,color: Colors.black,),
                ),
              ),
              Container(
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: ListTile(
                  leading: Text("something very good and difficult that you \nhave succeeded in doing",style: TextStyle(color: Colors.black),),
                  trailing: Icon(Icons.radio_button_unchecked_rounded,color: Colors.black,),
                ),
              ),
              Container(
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: ListTile(
                  leading: Text("in or to a higher position than \nsomething else",style: TextStyle(color: Colors.black),),
                  trailing: Icon(Icons.radio_button_unchecked_rounded,color: Colors.black,),
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height*0.07,
              ),
              MyCustomButton(text: "Continue",loading: false,onTap: (){
                Get.to(ScreenChapter01Lesson01Screen06());

              },

              )
            ]
        ),
      ),
    );
  }
}
