import 'package:bloc/bloc.dart';
import 'package:chat/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';


part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context)=>BlocProvider.of(context);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  UserModel? usersModel;
  String? uId;
  userRegsiter(String email, String password) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      uId = value.user!.uid;
      print('uId register:$uId');
      userCreate(email: email, password: password, uId: uId!);
    }).catchError((error) {
      emit(RegisterErrorState(error));
      print('Error $error');
    });
  }
  userCreate(
      {required String email, required String password, required String uId}) {
    UserModel userModel = UserModel(email: email, password: password, uId: uId);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
      emit(CreateuserSuccses());
    }).catchError((error) {
      emit(CreateUserError());
      print('Error $error');
    });
  }
}
