// ignore_for_file: unnecessary_brace_in_string_interps, await_only_futures, avoid_print

import 'dart:async';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
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
  Future<void> sendMessage(
      {String? receiverId,
      String? text,
      String? dateTime,
      String? image,
      String? record,
      String? docs}) async {
    emit(SendMessageLoadingState());
    print("SendMessageLoadingState");
    MessageModel messageModel = MessageModel(
      receiverId: receiverId,
      text: text,
      dateTime: dateTime,
      senderId: MyConst.uidUser,
      image: image,
      record: record,
      docs: docs,
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
      // print("messages ${messages![13].onceRecordPlaying}");
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

  //*===========================================================================
  //*                          record
  //*===========================================================================
  final recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;
  bool isChangeHintText = false;
  String? hintText = "Message";
  // String? recordFile;

  Future initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw "Microphone Permission not granted";
    }
    await recorder.openRecorder();
    isRecorderReady = true;
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  Future record() async {
    if (!isRecorderReady) return;
    await recorder.startRecorder(toFile: "audio${DateTime.now().millisecond}");
    // isRecorderReady = false;
    emit(RecordMessageSuccessState());
    print("RecordMessageSuccessState");
  }

  File? audioFile;
  Future stop({
    String? receiverId,
  }) async {
    //* Uri.file(selectImage!.path).pathSegments.last}
    if (!isRecorderReady) return;
    final path = await recorder.stopRecorder();
    audioFile = File(path!);
    print("audioFile $audioFile");
    voiceSave(receiverId: receiverId);
    // uploadAudio(path, receiverId!);
  }

  //*===========================================================================
  //*                          time Record
  //*===========================================================================

  int? secondTime = 0;
  int? minutesTime = 0;
  int timeRecord() {
    Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        secondTime = secondTime! + 1;
        emit(TimeRecordChangeState());

        if (secondTime == 10) {
          minutesTime = minutesTime! + 1;
          secondTime = 0;
          print("60 seconds");
          emit(TimeRecordChangeState());
        }
        if (isChangeHintText == false) timer.cancel();
      },
    );
    print("TimeRecordChangeState");
    return secondTime!;
  }

  //*===========================================================================
  //*                      play record sound
  //*===========================================================================
  bool showPlay = false;

  AssetsAudioPlayer player = AssetsAudioPlayer();
  Future initplayer({String? path}) async {
    player.open(Audio("$path"), autoStart: false, showNotification: true);
    showPlay = !showPlay;
    emit(PlayRecordState());
    print("PlayRecordState");
  }
//!============================================================================
//!     save recorod sound another way
  // final Reference storageReference =
  //     FirebaseStorage.instance.ref().child('audio');
//* from GPT
// Upload audio file to Firebase Storage
  // var downloadURL;
  // Future<void> uploadAudio(String path, String receiverId) async {
  //   final file = File(path);
  //   final uploadTask =
  //       storageReference.child('${DateTime.now()}.mp3').putFile(file,
  //       //! May be use it or not
  //       SettableMetadata(contentType: 'audio/wav')
  //       );
  //   final snapshot = await uploadTask.whenComplete(() {
  //     // sendMessage(
  //     //   dateTime: DateTime.now().toString(),
  //     //   receiverId: receiverId,
  //     //   record: path
  //     // );
  //     emit(UploadRecordSuccessState());
  //     print("UploadRecordSuccessState");
  //   });

  //   if (snapshot.state == TaskState.success) {
  //     downloadURL = await snapshot.ref.getDownloadURL().whenComplete(() {
  //       print("downloadURL $downloadURL");
  //       // sendMessage(
  //       //   dateTime: DateTime.now().toString(),
  //       //   receiverId: receiverId,
  //       //   record: downloadURL,
  //       // );
  //     });
  //     // return downloadURL;
  //   } else {
  //     throw 'Audio upload failed';
  //   }
  // }
//!============================================================================

  String? audioUrl;
  Future<void> voiceSave({String? receiverId}) async {
    emit(UploadRecordLoadingState());
    print("UploadRecordLoadingState");

    FirebaseStorage.instance
        .ref("records/${Uri.file(audioFile!.path).pathSegments.last}.mp3")
        .putFile(audioFile!, SettableMetadata(contentType: 'audio/wav'))
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //? value => paht url
        print("value url  ${value}");

        emit(UploadRecordSuccessState());
        print("UploadRecordSuccessState");
        audioUrl = "${value}.mp3";
        sendMessage(
          receiverId: receiverId,
          record: audioUrl,
          dateTime: DateTime.now().toString(),
        );
      }).catchError((onError) {
        emit(UploadRecordErrorState());
        print("UploadRecordErrorState : $onError");
      });
    }).catchError((onError) {
      emit(UploadRecordErrorState());
      print("UploadRecordErrorState : $onError");
    });
  }

  //*=======================================================================
  //*                      send docs <pdf,word,files>
  //*=======================================================================

  String? filePath;
  String? fileName;
  Future selectDocuments({String? receiverId}) async {
    emit(SelectDocumentsLoadingState());
    print("SelectDocumentsLoadingState");
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile? file = result.files.first;
      // String fileName = file.name;
      print("name file ${result.names.first}");
      fileName = result.names.first;
      // PlatformFile file = result.files.first;
      // String fileName = file.name;
      filePath = file.path;
      // Continue with the upload process
    } else {
      // User canceled the file selection
    }

    // File finalRsult = result as File;
    print("filePath $filePath");
    FirebaseStorage.instance
        .ref("docs/$fileName")
        .putFile(File(filePath!))
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //? value => paht url
        print("value url  ${value}");
        // print(object);
        sendMessage(
          receiverId: receiverId,
          docs: value,
          dateTime: DateTime.now().toString(),
        );
        emit(SelectDocumentsSuccessState());
        print("SelectDocumentsSuccessState");
      }).catchError((onError) {
        emit(SelectDocumentsErrorState());
        print("SelectDocumentsErrorState : $onError");
      });
    }).catchError((onError) {
      emit(SelectDocumentsErrorState());
      print("SelectDocumentsErrorState : $onError");
    });
  }
}
