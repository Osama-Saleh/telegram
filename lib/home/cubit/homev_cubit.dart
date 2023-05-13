// ignore_for_file: depend_on_referenced_packages, unnecessary_import, avoid_print

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:telegram/Module/message_model.dart';
import 'package:telegram/components/const.dart';

part 'homev_state.dart';

class HomevCubit extends Cubit<HomevState> {
  HomevCubit() : super(HomevInitial());

  static HomevCubit get(context) => BlocProvider.of(context);

  //*==============================================================
  //*      get messages from firebase to message model
  //*==============================================================
  List<MessageModel>? messages;
  Future<void> getMessage({
    String? receiverId,
  }) async {
    print("hahahah");
    FirebaseFirestore.instance
        .collection('users')
        .doc(MyConst.uidUser)
        .collection("Chats")
        .doc(receiverId)
        .collection("Messages")
        .orderBy("dateTime")
        .snapshots()
        .listen((event) {
      messages = [];
      print("lalala");
      for (var element in event.docs) {
        messages!.add(MessageModel.fromJson(element.data()));
      }
      emit(GetMessageSuccessState());
      print("GetMessageSuccessState");
    });
  }
}
