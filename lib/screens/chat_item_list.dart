import 'package:chat/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../blocs/get_all_users/cubit/get_all_users_cubit.dart';
import '../components/chat_item.dart';
import '../core/utils/app_navigator.dart';

class ChatItemLsitScreen extends StatelessWidget {
  String? uId;
  String? uIdLogin;
  ChatItemLsitScreen({this.uId, this.uIdLogin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                AppNavigator.navigateToNewScreen(context, RegisterScreen(), true);
              },
              icon: Icon(Icons.logout)),
        ],
        backgroundColor: Colors.deepOrange,
        title: Text(
          'Kalemny'.toUpperCase(),
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) =>
            GetAllUsersCubit()..getAllUseres(uId: uId, uIdlogin: uIdLogin),
        child: BlocConsumer<GetAllUsersCubit, GetAllUsersState>(
          listener: (context, state) {
            if (state is GetAllUsersLoadingState) {
              Center(child: CircularProgressIndicator());
            }
          },
          builder: (context, state) {
            var cubit = GetAllUsersCubit.get(context);
            return cubit.userslist?.length != null
                ? ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ChatItem(
                        registerUId: uId,
                        senderUId: uIdLogin,
                        reciverUId: cubit.userslist?[index].uId,
                        email: cubit.userslist?[index].email ?? '',
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 20.h,
                      );
                    },
                    itemCount: cubit.userslist?.length ?? 0)
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
