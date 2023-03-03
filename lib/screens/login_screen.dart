import 'package:chat/components/my_button.dart';
import 'package:chat/components/my_text_field.dart';
import 'package:chat/screens/chat_screen.dart';
import 'package:chat/screens/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../blocs/login_bloc/login_cubit.dart';
import '../core/toast/toast_config.dart';
import '../core/utils/app_navigator.dart';
import '../enums/toast_state.dart';
import 'chat_item_list.dart';

class LoginScreen extends StatelessWidget {
  String? uIdLogin;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (create)=> LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginState>(listener: (context,state){
        if(state is LoginErrorState)
        {
          ToastConfig.showToast(msg: state.error.toString(),
              toastStates: ToastStates.Error);
        }
      },
          builder: (context,state){
            var cubit=LoginCubit.get(context);
            uIdLogin = cubit.uIdLogin;
            return Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0,
                      vertical: 40),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100.h,
                        ),
                        Text('Kalemny',style: TextStyle(fontSize: 36.sp,fontWeight: FontWeight.bold,color: Colors.deepOrange),),

                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Connect with your friends',style: TextStyle(fontSize: 13.sp,color: Colors.black45),)
                        ),
                        SizedBox(
                          height:
                          80.h,
                        ),
                        MyTextField(label: 'Email', iconData: Icons.email,controller: cubit.emailController,),
                        SizedBox(height: 30.h,),
                        MyTextField(label: 'Password', iconData: Icons.key,isPassword: true,controller: cubit.passwordController,),
                        SizedBox(height: 100.h,),
                        MyButton(text: 'Login', function: (){
                          cubit.login(cubit.emailController.text,
                              cubit.passwordController.text);
                          if (state is LoginSuccessState) {
                            ToastConfig.showToast(
                                msg: 'Wellcome To Chat',
                                toastStates: ToastStates.Success);
                            AppNavigator.navigateToNewScreen(context, ChatItemLsitScreen(
                              uIdLogin: uIdLogin,
                            ), true);
                          }
                        }),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Dont have an account?',style: TextStyle(color: Colors.grey[600]
                            )
                            ),
                            TextButton(onPressed: (){
                              AppNavigator.navigateToNewScreen(context, RegisterScreen(), false);
                            }, child: Text('Register !',style: TextStyle(color: Colors.deepOrange),))
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}
