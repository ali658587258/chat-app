import 'package:chat/blocs/chat_bloc/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components/my__text.dart';
import '../components/reciver_massage.dart';
import '../components/sender_massage.dart';

class ChatScreen extends StatelessWidget {
  String name;
  String? reciverId;
  String? registerUId;
  String? senderUId;
  ChatScreen(
      {required this.name,
        required this.reciverId,
        required this.registerUId,
        required this.senderUId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                  'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=1060&t=st=1671055612~exp=1671056212~hmac=d3c01128fbb8f2a834d4d588172c7efac29e513eef3974136b2c45c439548cff'),
            ),
            SizedBox(
              width: 20.w,
            ),
            MyText(
              text: name,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: BlocProvider(
          create: (context) => ChatCubit()
            ..receiveMessages(
                senderId: senderUId ?? registerUId, reciverId: reciverId),
          child: BlocConsumer<ChatCubit, ChatState>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = ChatCubit.get(context);
              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var massage = cubit.massagesList[index];
                          if (massage.reciverId == reciverId) {
                            return SenderMassage(
                              massage: massage.text!,
                            );
                          } else {
                            return ReciverMassage(
                              massage: massage.text!,
                            );
                          }
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 10.h,
                          );
                        },
                        itemCount: cubit.massagesList.length),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: TextFormField(
                            controller: cubit.messageController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                hintText: 'Enter your Massege here '),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            cubit.sendMessage(
                                senderUId: registerUId ?? senderUId!,
                                reciverId: reciverId!,
                                dateTime: DateTime.now().toString(),
                                text: cubit.messageController.text);
                            cubit.messageController.text = '';
                          },
                          icon: Icon(
                            Icons.send,
                          ))
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
