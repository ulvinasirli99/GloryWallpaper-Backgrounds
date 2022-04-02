import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double? textSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  CustomText({
    Key? key,
    @required this.text,
    this.textSize,
    this.color,
    this.fontWeight,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: textSize,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}
