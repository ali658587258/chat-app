part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}
class SendMassgageSuccsessState extends ChatState {}
class SendMassgageErrorState extends ChatState{}


class ReceiveMessageSuccessState extends ChatState {}

