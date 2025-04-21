import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speakup_bridge/widgtes/medium_text.dart';

import '../../widgtes/large_text.dart';
import '../../widgtes/my_custom_button.dart';
import '../../widgtes/my_input_feild2.dart';

class ScreenForget extends StatelessWidget {
  const ScreenForget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () {
          Get.back();
        },),
        title: Text("Forget Password"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              SizedBox(
                height: 16,
              ),
              Image.asset("assets/images/Forget Password.png"),
              SizedBox(
                height: 16,
              ),
              LargeText(text: "Enter the email address to get an OTP code to reset  your Password"),
              SizedBox(
                height: 16,
              ),
              MyInputField2(
                isPasswordField: true,
                prefix: Icon(Icons.email_outlined,color: Colors.grey.shade600,),
                hint: "Email",
                fillColor: Colors.grey.shade200, obscureText: false, initialValue: '', onChanged: (value) {  },
              ),
              SizedBox(
                height: 16,
              ),
              MyCustomButton(text: "Get Code", loading: false, onTap: (){
          
              },

              ),
            ],
          ),
        ),
      ),
    );
  }
}
