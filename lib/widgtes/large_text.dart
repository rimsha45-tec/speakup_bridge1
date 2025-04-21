import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LargeText extends StatelessWidget {
  String text;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        decoration: TextDecoration.none,
        fontWeight: FontWeight.w600,
        fontSize: 17.sp,
        fontFamily: 'Poppins',
        color: color ?? Color(0xff1B1B1B),
      ),
      textAlign: TextAlign.center,
    );
  }

  LargeText({required this.text, this.color});
}
