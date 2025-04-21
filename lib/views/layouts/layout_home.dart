import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speakup_bridge/constants/colors/colors.dart';
import 'package:speakup_bridge/views/screens/screen_chapter_01.dart';

class LayoutHome extends StatelessWidget {
  const LayoutHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 70,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: appPrimaryColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                      Image.asset("assets/images/spanishflag.png"),
                      Image.asset("assets/images/streak.png"),
                      Image.asset("assets/images/diamonds.png"),
                      Image.asset("assets/images/save.png"),
                  ],
                ),
              ),
              Container(
              
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 8.0),
                      child: ListTile(
                        onTap: (){
                          Get.to(ScreenChapter01());
                        },
                        tileColor: appPrimaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        title: Text("CHAPTER #01",style: TextStyle(color: Colors.white),),
                        trailing: Icon(Icons.lock,color: Colors.white,),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 8.0),
                      child: ListTile(
                        onTap: (){
                          Get.to(ScreenChapter01());
                        },
                        tileColor: appPrimaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        title: Text("CHAPTER #02",style: TextStyle(color: Colors.white),),
                        trailing: Icon(Icons.lock,color: Colors.white,),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 8.0),
                      child: ListTile(
                        onTap: (){
                          Get.to(ScreenChapter01());
                        },
                        tileColor: appPrimaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        title: Text("CHAPTER #03",style: TextStyle(color: Colors.white),),
                        trailing: Icon(Icons.lock,color: Colors.white,),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 8.0),
                      child: ListTile(
                        onTap: (){
                          Get.to(ScreenChapter01());
                        },
                        tileColor: appPrimaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        title: Text("CHAPTER #04",style: TextStyle(color: Colors.white),),
                        trailing: Icon(Icons.lock,color: Colors.white,),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 8.0),
                      child: ListTile(
                        onTap: (){
                          Get.to(ScreenChapter01());
                        },
                        tileColor: appPrimaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        title: Text("CHAPTER #05",style: TextStyle(color: Colors.white),),
                        trailing: Icon(Icons.lock,color: Colors.white,),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 8.0),
                      child: ListTile(
                        onTap: (){
                          Get.to(ScreenChapter01());
                        },
                        tileColor: appPrimaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        title: Text("CHAPTER #06",style: TextStyle(color: Colors.white),),
                        trailing: Icon(Icons.lock,color: Colors.white,),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 8.0),
                      child: ListTile(
                        onTap: (){
                          Get.to(ScreenChapter01());
                        },
                        tileColor: appPrimaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        title: Text("CHAPTER #07",style: TextStyle(color: Colors.white),),
                        trailing: Icon(Icons.lock,color: Colors.white,),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 8.0),
                      child: ListTile(
                        onTap: (){
                          Get.to(ScreenChapter01());
                        },
                        tileColor: appPrimaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        title: Text("CHAPTER #08",style: TextStyle(color: Colors.white),),
                        trailing: Icon(Icons.lock,color: Colors.white,),
                      ),
                    ),
              
                  ],
                ),
              ),
          
            ],
          ),
        ),
      ),
    );
  }
}
