// ignore_for_file: unnecessary_brace_in_string_interps, await_only_futures, avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:telegram/Module/message_model.dart';
import 'package:telegram/components/const.dart';

part 'chatting_state.dart';

class ChattingCubit extends Cubit<ChattingState> {
  ChattingCubit() : super(ChattingInitial());

  static ChattingCubit get(context) => BlocProvider.of(context);

  bool isEmojiSelected = false;
  void selectEmoji() {
    isEmojiSelected = !isEmojiSelected;
    emit(PressEmojiState());
    print("PressEmojiState");
  }

  //*=============================================
  //?=======  save messages in firebase =========
  //*=============================================
  Future<void> sendMessage({
    String? receiverId,
    String? text,
    String? dateTime,
    String? image,
  }) async {
    emit(SendMessageLoadingState());
    print("SendMessageLoadingState");
    MessageModel messageModel = MessageModel(
      receiverId: receiverId,
      text: text,
      dateTime: dateTime,
      senderId: MyConst.uidUser,
      image: image,
    );
    //* my chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(MyConst.uidUser)
        .collection("Chats")
        .doc(receiverId)
        .collection("Messages")
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
      print("SendMessageSuccessState");
    }).catchError((onError) {
      emit(SendMessageErrorState());
      print("SendMessageErrorState");
    });
    //* receiver chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection("Chats")
        .doc(MyConst.uidUser)
        .collection("Messages")
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
      print("SendMessageSuccessState");
    }).catchError((onError) {
      emit(SendMessageErrorState());
      print("SendMessageErrorState");
    });
  }

  //*==============================================================
  //*      get messages from firebase to message model
  //*==============================================================
  List<MessageModel>? messages;
  Future<void> getMessage({
    String? receiverId,
  }) async {
    print("hahahah");
    await FirebaseFirestore.instance
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

//*=======================================================================
//*                      get image from device
//*=======================================================================
  File? selectImage;
  ImagePicker sendpicker = ImagePicker();

  Future setSelectImage({String? receiverId}) async {
    emit(SelectImageLoadingState());
    print("SelectImageLoadingState");
    final imagefile = await sendpicker.pickImage(source: ImageSource.gallery);

    if (imagefile != null) {
      selectImage = File(imagefile.path);
      print("image Path is : ${selectImage}");
      uploadImage(receiverId: receiverId);
      emit(SelectImageSuccessState());
      print("SelectImageSuccessState");
    } else {
      // print("Not Image Selected");
      emit(SelectImageErrorState());
      print("SelectImageErrorState");
    }
  }

//*=======================================================================
//*                       upload image
//*=======================================================================
  String? image;
  Future<void> uploadImage({String? receiverId}) async {
    emit(UploadImageLoadingState());
    print("UploadImageLoadingState");
    FirebaseStorage.instance
        .ref("images/${Uri.file(selectImage!.path).pathSegments.last}")
        .putFile(selectImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //? value => paht url
        print(value);
        // image = value;
        emit(UploadImageSuccessState());
        print("UploadImageSuccessState");
        // print(image);
        sendMessage(
          receiverId: receiverId,
          image: value,
          dateTime: DateTime.now().toString(),
        );
      }).catchError((onError) {
        emit(UploadImageErrorState());
        print("UploadImageErrorState : $onError");
      });
    }).catchError((onError) {
      emit(UploadImageErrorState());
      print("UploadImageErrorState : $onError");
    });
  }
}
