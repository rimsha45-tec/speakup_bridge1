import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constants/colors/colors.dart';
import '../../widgtes/medium_text.dart';
import '../../widgtes/my_custom_button.dart';

class ScreenChapter01SentenceCheck extends StatelessWidget {
  const ScreenChapter01SentenceCheck({Key? key}) : super(key: key);

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
        child: Container(
          padding: EdgeInsets.all(5),
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
          
                SizedBox(
                  height: 20,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Our AI is Checking...... "),
                            SizedBox(
                              width: 40,
                            ),
                            Image.asset("assets/icons/loadingicon.png")
                          ],
                        )
                    ),
          
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                  Text("It's on the shelf just above your head."),
                  SizedBox(
                    width: 12,
                  ),
                  Image.asset("assets/images/profilepic.png"),
                  ],
                ),
                SizedBox(
                  height: 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.computer),
                    SizedBox(
                      width: 12,
                    ),
                  Text("Congrats 100% correct"),
          
          
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.4,
                ),
          
          
                MyCustomButton(
                  text: "Mark as Complete",
                  buttonColor: Colors.green,
                  loading: false, onTap: (){
                  Get.to(ScreenChapter01SentenceCheck());
          
                },

                )
              ]
          ),
        ),
      ),
    );
  }
}
