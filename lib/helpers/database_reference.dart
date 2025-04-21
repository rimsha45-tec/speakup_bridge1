import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DbReference{
  String image_url = "https://phito.be/wp-content/uploads/2020/01/placeholder.png";

  var uid=FirebaseAuth.instance.currentUser?.uid;
  var dUser=FirebaseAuth.instance.currentUser!;
  var userRef = FirebaseFirestore.instance.collection("users");
  var jobRef = FirebaseFirestore.instance.collection("Jobs");
  var callRef = FirebaseFirestore.instance.collection("CallBacks");
  var cvRef = FirebaseFirestore.instance.collection("CVs");
  var feedRef = FirebaseFirestore.instance.collection("FeedBack");

}