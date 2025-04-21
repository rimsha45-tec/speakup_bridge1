import 'package:flutter/cupertino.dart';

class CustomImage2 extends StatelessWidget {
  final String name;
  final double height;

  const CustomImage2({Key? key, required this.name, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/$name.jpeg', // Adjusted to .jpeg instead of .png
      height: height,
    );
  }
}
