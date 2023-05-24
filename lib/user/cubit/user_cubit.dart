// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls, await_only_futures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/Module/message_model.dart';
import 'package:telegram/Module/user_model_fire.dart';
import 'package:telegram/components/const.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  static UserCubit get(context) => BlocProvider.of(context);

  //*=============================================
  //?========= Get All user in application =======
  //*=============================================

  List<UserModelFire>? countUsers;
  Future getAllUser() async {
    emit(GetAllUserLoadingState());
    print("GetAllUserLoadingState");
    countUsers = [];
    var value = await FirebaseFirestore.instance.collection('users').get();
    value.docs.forEach((element) {
      print(" element ${element.data()}");
      if (element.data()["token"] != MyConst.uidUser) {
        countUsers!.add(UserModelFire.fromJson(element.data()));
        emit(GetAllUserSuccessState());
        print("GetAllUserSuccessState");
      }
    });
    print("countUsers : ${countUsers!.length}");
  }

// //*==============================================================
//   //*      get messages from firebase to message model
//   //*==============================================================
//   List<MessageModel>? messages;
//   Future<void> getMessage({
//     String? receiverId,
//   }) async {
//     print("osos");
//     await FirebaseFirestore.instance
//         .collection('users')
//         .doc(MyConst.uidUser)
//         .collection("Chats")
//         .doc(receiverId)
//         .collection("Messages")
//         .orderBy("dateTime")
//         .snapshots()
//         .listen((event) {
//       messages = [];
//       print("lalala");
//       event.docs.forEach((element) {
//         messages!.add(MessageModel.fromJson(element.data()));
//       });
//       print("messages ${messages!.length}");
//       emit(GetMessageSuccessState());
//       print("GetMessageSuccessState");
//     });
  // }
}
