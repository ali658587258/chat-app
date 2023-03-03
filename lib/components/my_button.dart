import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyButton extends StatelessWidget {
  final String text;
  final function;


  MyButton({required this.text,required this.function});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(onPressed: function,
          style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all(Colors.deepOrange),
              shape: MaterialStateProperty.all<
                  RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(18.0)
                  ),
              ),
          ),
            child: Text(text)
      ),
    );
  }
}
