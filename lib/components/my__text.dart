import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class MyText extends StatelessWidget {
  String text;
  var fontSize;
  FontWeight? fontWeight;
  MyText({required this.text, this.fontSize, this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.black87,
          fontSize: fontSize ?? 18.sp,
          fontWeight: fontWeight ?? FontWeight.normal),
    );
  }
}
