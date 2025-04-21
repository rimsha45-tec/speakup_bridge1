import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';
import 'package:speakup_bridge/views/screens/screen_chapter_01_sentence_check.dart';
import 'package:speakup_bridge/widgtes/my_input_feild.dart';

import '../../constants/colors/colors.dart';
import '../../widgtes/medium_text.dart';
import '../../widgtes/my_custom_button.dart';

class ScreenViewExamples extends StatelessWidget {
  const ScreenViewExamples({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Examples and Practice "),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
          Get.back();
        },),
      ),
      body: SingleChildScrollView(
        child: Column(
            
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MediumText(text: "How we can use this word in daily life?",color: appPrimaryColor,),
                    Text("* There's a mirror above the sink."),
                    Text("* He waved the letter excitedly above his head."),
                    Text("* She's rented a room above a shop."),
                    Text("* Her name comes above mine on the list."),
                  ],
                ),
              ),
            
            
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
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
                          Text("Make a Sentence Using this word "),
                        ],
                      )
                  ),
                  Container(
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
                          Text("Skip"),
                        ],
                      )
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.4,
              ),
              Text("Our AI will check and assist you in your answer."),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                   fillColor: Colors.grey.shade300,
                    hintText: "Write Sentence..."
                  ),
                ),
              ),
            
            
              MyCustomButton(text: "Continue", loading: false, onTap: (){
                Get.to(ScreenChapter01SentenceCheck());
            
              },

              )
            ]
        ),
      ),
    );
  }
}
