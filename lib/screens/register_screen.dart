import 'package:chat/components/my_button.dart';
import 'package:chat/components/my_text_field.dart';
import 'package:chat/screens/chat_item_list.dart';
import 'package:chat/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../blocs/register_bloc/register_cubit.dart';
import '../core/toast/toast_config.dart';
import '../core/utils/app_navigator.dart';
import '../enums/toast_state.dart';
import 'chat_screen.dart';

class RegisterScreen extends StatelessWidget {
  String? uId;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (create)=> RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterState>(
          listener: (context,state){
            if(state is CreateuserSuccses) {
              ToastConfig.showToast(msg: 'Welcome To the app', toastStates:ToastStates.Success );
            }
            if(state is CreateUserError)
            {
              ToastConfig.showToast(msg: state.toString(),
                  toastStates: ToastStates.Error);
            }
          },

          builder: (context,state){
            var cubit = RegisterCubit.get(context);
            uId = cubit.uId;
            return Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 40),
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
                            height: 80.h,
                          ),
                          MyTextField(label: 'Email', iconData: Icons.email,controller: cubit.emailController,),
                          SizedBox(height: 30.h,),
                          MyTextField(label: 'Password', iconData: Icons.key,isPassword: true,controller: cubit.passwordController,),
                          SizedBox(height: 100.h,),
                          MyButton(text: 'Registe', function: (){
                            cubit.userRegsiter(cubit.emailController.text,
                                cubit.passwordController.text);
                            if (state is CreateuserSuccses) {
                              AppNavigator.navigateToNewScreen(context,  ChatItemLsitScreen(
                                uId: cubit.uId,
                              ), true);
                            }
                          }
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Already have an account?',style: TextStyle(color: Colors.grey[600])
                              ),
                              TextButton(onPressed: (){
                                AppNavigator.navigateToNewScreen(context, LoginScreen(), false);
                              },
                                  child: Text('Login !',style: TextStyle(color: Colors.deepOrange),
                                  )
                              )
                            ],
                          )
                        ]
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
