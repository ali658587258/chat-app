import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../models/message.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  static ChatCubit get(context)=>BlocProvider.of(context);
  TextEditingController messageController =TextEditingController();

  void sendMessage({
    required String reciverId,
    required String dateTime,
    required String text,
    required String senderUId,
  })
  {
    MassageModel massageModel = MassageModel(
      dateTime: dateTime,
      senderId: senderUId,
      reciverId: reciverId,
      text: text,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(reciverId)
        .collection('chat')
        .doc(senderUId)
        .collection('messages')
        .add(massageModel.toMap())
        .then((value) {
      emit(SendMassgageSuccsessState());
    }).catchError((error){
      emit(SendMassgageErrorState());

    });


    FirebaseFirestore.instance
        .collection('users')
        .doc(senderUId)
        .collection('chat')
        .doc(reciverId)
        .collection('massages')
        .add(massageModel.toMap())
        .then((value) {
          emit(SendMassgageSuccsessState());
    }).catchError((error){
      emit(SendMassgageErrorState());
    });
  }

  List<MassageModel> massagesList = [];
  receiveMessages({required String? senderId, required String? reciverId})
  {
    FirebaseFirestore.instance
        .collection('users')
        .doc(senderId)
        .collection('chat')
        .doc(reciverId)
        .collection('massages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      massagesList = [];
      event.docs.forEach((element) {
        massagesList.add(MassageModel.fromJson(element.data()));
      });
      emit(ReceiveMessageSuccessState());
    });
  }



}
