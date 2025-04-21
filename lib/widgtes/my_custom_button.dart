import 'package:flutter/material.dart';

class MyCustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool loading;
  final bool isRound;
  final double? width;
  final double? height;
  final EdgeInsets? margin;
  final Color? buttonColor;
  final Color? textColor;

  const MyCustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    required this.loading,
    this.isRound = false,
    this.width,
    this.height = 50,
    this.margin,
    this.buttonColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      margin: margin ?? const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor ?? Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isRound ? 30 : 10),
          ),
        ),
        onPressed: loading ? null : onTap,
        child: loading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
