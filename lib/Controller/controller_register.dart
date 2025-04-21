// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:speakup_bridge/Models/user.dart' as model;
// import '../helpers/database_reference.dart';
// import '../helpers/firebase_utils.dart';
//
// class ControllerRegister extends GetxController {
//   RxBool signUpLoading = false.obs;
//   RxBool imageLoading = false.obs;
//   TextEditingController emailController = TextEditingController();
//   TextEditingController nameController = TextEditingController();
//   TextEditingController phoneNumberController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   RxString imagePath= "".obs;
//
//   Future<String> userRegister() async {
//     String response = "";
//     String firstName = nameController.text;
//     String phoneNumber = phoneNumberController.text;
//     String email = emailController.text;
//     String password = passwordController.text;
//     signUpLoading.value = true;
//     if (email.isNotEmpty &&
//         firstName.isNotEmpty &&
//         password.isNotEmpty&&
//         phoneNumber.isNotEmpty) {
//       await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(email: email, password: password)
//           .then((userCredential) async {
//         print("User Register Successfully");
//         print(userCredential);
//         var uid = userCredential.user!.uid;
//         var user = model.User(
//           id: uid,
//           name: firstName,
//           notificationToken: "",
//           timeStamp: DateTime.now().microsecondsSinceEpoch,
//           imageUrl: "",
//           birthGender: selectGender.value,
//           phoneNumber: country_code.value+phoneNumber,
//           dob: selectedDate.value.millisecondsSinceEpoch,
//         );
//         await DbReference().userRef.doc(uid).set(user.toMap()).then((value) async {
//           response = "success";
//           await FirebaseAuth.instance.currentUser?.updateDisplayName(firstName);
//
//           signUpLoading.value = false;
//         }).catchError((error) {
//           response = error.toString();
//           signUpLoading.value = false;
//         });
//       });
//     } else {
//       response = "All Fields Required";
//       signUpLoading.value = false;
//     }
//
//     return response;
//   }
//
//   //Select County Code
//   RxString country_code = "+47".obs;
//
//   //Select gender
//   RxString selectGender = "Male".obs;
//
//   //Date picker
//   Rx<DateTime> selectedDate = DateTime.now().obs;
//
//   Future<void> pickDate(context) async {
//     final DateTime? picked = await showDatePicker(
//         context: context,
//         initialDate: selectedDate.value,
//         firstDate: DateTime(1900),
//         lastDate: DateTime(2101));
//     if (picked != null && picked != selectedDate) selectedDate.value = picked;
//     update();
//   }
//   Future<String> uploadImage()async{
//     String response="";
//     imageLoading.value = true;
//     var url =
//     await FirebaseUtils.uploadImage(imagePath.value, "Users/${FirebaseAuth.instance.currentUser!.uid}").catchError((error) {
//       response = error.toString();
//       imageLoading.value = false;
//     });
//     await FirebaseAuth.instance.currentUser?.updatePhotoURL(url);
//
//     await DbReference().userRef.doc(FirebaseAuth.instance.currentUser!.uid).update({"imageUrl":url}).then((value) {
//       response="success";
//       imageLoading.value = false;
//
//     }
//     ).catchError((e){
//       response=e.toString();
//       imageLoading.value = false;
//
//     });
//     return response;
//
//   }
//
// }
