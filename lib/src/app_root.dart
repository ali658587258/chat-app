import 'package:chat/blocs/chat_bloc/chat_cubit.dart';
import 'package:chat/blocs/login_bloc/login_cubit.dart';
import 'package:chat/blocs/register_bloc/register_cubit.dart';
import 'package:chat/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppRoot extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
        builder: (context,child){
          return MaterialApp(
            home: LoginScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
    );
  }
}
