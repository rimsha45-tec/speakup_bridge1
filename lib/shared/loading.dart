import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
 class Loading extends StatelessWidget{
  const Loading({super.key});

   @override
 Widget build(BuildContext context){
     return Container(
       child: Center(
         child: SpinKitChasingDots(
       color: Colors.brown[100],
       size: 50.0,
     ),
     ),
     );
   }
 }
