// // // ignore_for_file: avoid_print

// // ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, sized_box_for_whitespace

// // import 'package:audioplayers/audioplayers.dart';
// import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sizer/sizer.dart';
// import 'package:telegram/Module/user_model_fire.dart';
// import 'package:telegram/chatting/cubit/chatting_cubit.dart';
// import 'package:telegram/chatting/widgets/my_message.dart';
// import 'package:telegram/chatting/widgets/receive_message.dart';
// import 'package:telegram/components/app_colors.dart';
// import 'package:telegram/components/const.dart';
// import 'package:telegram/components/widgets/my_icon_button.dart';
// import 'package:telegram/components/widgets/my_text.dart';
// import 'package:telegram/home/home_view.dart';
// // import 'package:flutter_sound/flutter_sound.dart';

// class Test extends StatefulWidget {
//   const Test({super.key,this.model});
//   final UserModelFire? model;

//   @override
//   State<Test> createState() => _TestState();
// }

// class _TestState extends State<Test> {
//    TextEditingController messageController = TextEditingController();
//   ScrollController scrollController = ScrollController();
//   var formKey = GlobalKey<FormState>();
//   bool isMice = false;
//   String? hintText = "Message";
//   int? num = 0;
//   //!==============================================
//   // FlutterSoundRecorder? myRecord;
//   // final audioPlayer = AssetsAudioPlayer();
//   // String? filePath;
//   // bool? play = false;
//   // String? recordText = "00:00:00";

//   // void startIt() async {
//   //   filePath = "/sdcard/Download/temp.wav";
//   //   myRecord = FlutterSoundRecorder();
//   //   // await myRecord!
//   // }
//   @override
//   void initState() {
//     super.initState();
//     ChattingCubit.get(context).initRecorder();
//     // if (ChattingCubit.get(context).messages == null) {
//     //   Future.delayed(const Duration(milliseconds: 500), () {
//     //     scrollController.animateTo(scrollController.position.maxScrollExtent,
//     //         duration: const Duration(milliseconds: 100), curve: Curves.easeIn);
//     //   });
//     // }
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     // dispose();
//   }

//   // @override
//   // void dispose() {
//   //   ChattingCubit.get(context).recorder.closeRecorder();
//   //   print("record closed");
//   //   // messageController.dispose();
//   //   super.dispose();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     var cubit = ChattingCubit.get(context);
//     return Builder(
//       builder: (context) {
//         //!-----------------------------------------
//         cubit.getMessage(receiverId: widget.model!.token);
//         return BlocConsumer<ChattingCubit, ChattingState>(
//           listener: (context, state) {
//             if (state is SendMessageSuccessState) {
//               cubit.secondTime = 0;
//               cubit.minutesTime = 0;
//               cubit.hintText = "Message";
//             }
//           },
//           builder: (context, state) {
//             return Scaffold(
//                 backgroundColor: AppColor.lightGreen,
//                 // appBar: AppBar(
//                 //   backgroundColor: AppColor.darkBlue,
//                 //   centerTitle: false,
//                 //   toolbarHeight: 10.h,
//                 //   title: Row(
//                 //     children: [
//                 //       Container(
//                 //         height: 12.h,
//                 //         width: 12.w,
//                 //         clipBehavior: Clip.antiAlias,
//                 //         decoration: const BoxDecoration(
//                 //           color: Colors.blue,
//                 //           shape: BoxShape.circle,
//                 //         ),
//                 //         child: widget.model!.image == null
//                 //             ? Center(
//                 //                 child: MyText(
//                 //                 text:
//                 //                     "${widget.model!.name![0].toUpperCase()}${widget.model!.name![1].toUpperCase()}",
//                 //                 color: AppColor.white,
//                 //                 fontSize: 12.sp,
//                 //               ))
//                 //             : Image(
//                 //                 image: NetworkImage(
//                 //                   "${widget.model!.image}",
//                 //                 ),
//                 //                 fit: BoxFit.cover,
//                 //               ),
//                 //       ),
//                 //       SizedBox(
//                 //         width: 3.w,
//                 //       ),
//                 //       MyText(
//                 //         text: "${widget.model!.name}",
//                 //         fontSize: 15.sp,
//                 //       ),
//                 //     ],
//                 //   ),
//                 //   leading: MyIconButton(
//                 //     onPressed: () {
//                 //       // SchedulerBinding.instance.addPostFrameCallback((_) {
//                 //       //   Navigator.pushReplacement(
//                 //       //     context,
//                 //       //     MaterialPageRoute(
//                 //       //       builder: (__) => const HomeView(),
//                 //       //     ));
//                 //       // });
//                 //       // Navigator.pushReplacementNamed(context, "/homeView");

//                 //       Navigator.pushReplacement(
//                 //           context,
//                 //           MaterialPageRoute(
//                 //             builder: (context) => const HomeView(),
//                 //           )).whenComplete(() {
//                 //         ChattingCubit.get(context).recorder.closeRecorder();
//                 //       });
//                 //     },
//                 //     icon: Icons.arrow_back,
//                 //   ),
//                 // ),
//                 body: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     //*=========================================================
//                     //*                   List of message
//                     //*=========================================================
//                     Expanded(
//                         // flex: 10,
//                         child: cubit.messages!.isEmpty
//                             ? Center(
//                                 child: MyText(
//                                   text: "Say Hello 👋",
//                                   fontSize: 20.sp,
//                                 ),
//                               )
//                             : ListView.separated(
//                                 controller: scrollController,
//                                 itemBuilder: (context, index) {
//                                   print("************");
//                                   print("index : $index");
//                                   print("************");
//                                   if (MyConst.uidUser ==
//                                       cubit.messages![index].senderId) {
//                                     //* My message

//                                     return MyMessage(
//                                       messageModel: cubit.messages![index],
//                                       // fileName: cubit.fileName![index],
//                                     );
//                                   }
//                                   return

//                                       //* receive message
//                                       ReceiveMessage(
//                                     messageModel: cubit.messages![index],
//                                   );
//                                 },
//                                 separatorBuilder: (context, index) => SizedBox(
//                                       height: 5.h,
//                                     ),
//                                 itemCount: ChattingCubit.get(context)
//                                     .messages!
//                                     .length)),
//                     //*========================================================
//                     //*                 input my message

//                     //*========================================================
//                     // Container(
//                     //   child: Text("${cubit.minutesTime}:${cubit.secondTime}"),
//                     // ),

//                     Form(
//                       key: formKey,
//                       child: Container(
//                         color: AppColor.white,
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: TextFormField(
//                                   controller: messageController,
//                                   minLines: 1,
//                                   maxLines: 5,
//                                   onTap: () {
//                                     setState(() {
//                                       cubit.isEmojiSelected = false;
//                                     });
//                                   },
//                                   onChanged: (value) {
//                                     setState(() {
//                                       messageController.text;
//                                     });
//                                   },
//                                   decoration: InputDecoration(
//                                     labelStyle: TextStyle(fontSize: 15.sp),
//                                     hintText: cubit.isChangeHintText
//                                         ? "${cubit.minutesTime}:${cubit.secondTime}"
//                                         : "Message",
//                                     hintStyle: TextStyle(fontSize: 15.sp),
//                                     prefixIcon: IconButton(
//                                         onPressed: () {
//                                           //!========================================== send voice
//                                           if (cubit.isChangeHintText == true) {
//                                             // cubit
//                                             //     .stop(
//                                             //         receiverId:
//                                             //             widget.model!.token)
//                                             //     .whenComplete(() {
//                                             //   cubit.isChangeHintText = false;
//                                             //   cubit.hintText = "Message";
//                                             //   print("cubit.changeHintText");
//                                             // });
//                                           } else {
//                                             cubit.selectEmoji();
//                                           }

//                                           //*===========================================
//                                           //* hide keyboardType when click in emoji icon
//                                           //*===========================================
//                                           SystemChannels.textInput
//                                               .invokeMethod("TextInput.hide");
//                                           // print(
//                                           //     "isEmoji ${cubit.isEmojiSelected}");
//                                         },
//                                         icon: cubit.isChangeHintText
//                                             ? const Icon(Icons.close)
//                                             : const Icon(
//                                                 Icons.emoji_emotions_outlined)),
//                                     border: InputBorder.none,
//                                     contentPadding: EdgeInsets.all(3.h),
//                                   ),
//                                   keyboardType: TextInputType.multiline),
//                             ),
//                             MyIconButton(
//                               onPressed: (messageController.text
//                                           .trim()
//                                           .isEmpty &&
//                                       cubit.secondTime! == 0)
//                                   ? null
//                                   : () {
//                                       print(
//                                           "messageController : ${messageController.text}");
//                                       if (cubit.isChangeHintText == true) {
//                                         cubit
//                                             .stop(
//                                                 receiverId: widget.model!.token)
//                                             .whenComplete(() {
//                                           cubit.isChangeHintText = false;
//                                           cubit.hintText = "Message";
//                                           print("cubit.changeHintText");
//                                         });
//                                       } else {
//                                         cubit
//                                             .sendMessage(
//                                           receiverId: widget.model!.token,
//                                           dateTime: DateTime.now().toString(),
//                                           text: messageController.text,
//                                           // image: cubit.selectImage.toString(),
//                                           // record: cubit.audioUrl,
//                                         )
//                                             .whenComplete(() {
//                                           if (cubit.messages != null) {
//                                             Future.delayed(
//                                               const Duration(
//                                                   milliseconds: 1000),
//                                               () {
//                                                 scrollController.animateTo(
//                                                     scrollController.position
//                                                         .maxScrollExtent,
//                                                     duration: const Duration(
//                                                         milliseconds: 100),
//                                                     curve: Curves.easeIn);
//                                               },
//                                             );
//                                             print("MaxScroll");
//                                             // print("MaxScroll ${cubit.messages![0].record}");
//                                           }
//                                           messageController.text = " ";
//                                           cubit.secondTime = 0;
//                                           cubit.minutesTime = 0;
//                                         });
//                                       }
//                                     },
//                               icon: Icons.send,
//                             ),
//                             // MyElevatedButton(
//                             //   onPressed: () {
//                             //     cubit.setSelectImage(
//                             //         receiverId: widget.model!.token);
//                             //   },

//                             // ),
//                             // ElevatedButton(onPressed: (){}, child: Icon(Icons.image_outlined)),
//                             MyIconButton(
//                                 onPressed: () {
//                                   cubit.selectDocuments(
//                                       receiverId: widget.model!.token);
//                                 },
//                                 icon: Icons.attach_file_sharp),
//                             InkWell(
//                               onLongPress: () async {
//                                 if (isMice == true) {
//                                   cubit.record().whenComplete(() {
//                                     print("Recorder");
//                                     cubit.timeRecord();
//                                     //!----------------------------------------------;
//                                   });
//                                   print("long");
//                                   setState(() {});
//                                   // cubit.hintText = "${cubit.minutesTime} : ${cubit.secondTime}";
//                                   cubit.isChangeHintText = true;
//                                   print("${cubit.isRecorderReady}");
//                                 } else {
//                                   cubit.setSelectImage(
//                                       receiverId: widget.model!.token);
//                                 }
//                               },
//                               child: MyIconButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     isMice = !isMice;
//                                   });
//                                 },
//                                 icon: isMice
//                                     ? Icons.mic_none_rounded
//                                     : Icons.image_outlined,
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                     //*
//                     if (cubit.isEmojiSelected == true)
//                       Expanded(
//                         child: Container(
//                           height: 50.h,
//                           width: double.infinity,
//                           child: EmojiPicker(
//                             textEditingController: messageController,
//                             onEmojiSelected: (category, emoji) {
//                               setState(() {
//                                 messageController;
//                               });
//                             },
//                           ),
//                         ),
//                       )
//                     // Container(
//                     //   height: 10.h,
//                     //   width: double.infinity,
//                     //   color: AppColor.white,
//                     //   padding: EdgeInsets.only(left: 2.h, right: 2.h),
//                     //   child: Row(
//                     //     children: [
//                     //       MyIconButton(
//                     //         onPressed: () {},
//                     //         icon: Icons.emoji_emotions_outlined,
//                     //       ),
//                     //       SizedBox(
//                     //         width: 3.w,
//                     //       ),
//                     //       Expanded(
//                     //         child: TextFormField(
//                     //           controller: messageController,
//                     //           keyboardType: TextInputType.multiline,
//                     //           minLines: 1,
//                     //           maxLines: 5,
//                     //           onChanged: (value) {
//                     //             setState(() {});
//                     //             messageController.text = value.toString();
//                     //             print(value);
//                     //           },

//                     //           decoration: InputDecoration(
//                     //             // labelText: labelText,
//                     //             labelStyle: TextStyle(fontSize: 15.sp),
//                     //             hintText: "Message",
//                     //             hintStyle: TextStyle(fontSize: 15.sp),

//                     //             border: InputBorder.none,
//                     //             contentPadding: EdgeInsets.all(3.h),
//                     //           ),

//                     //         ),
//                     //         //  MyTextFormField(
//                     //         //     controller: messageController,
//                     //         //     hintText: "Message",
//                     //         //     border: InputBorder.none),
//                     //       ),
//                     //       MyIconButton(
//                     //         onPressed: () {
//                     //           cubit.sendMessage(
//                     //               receiverId: widget.model!.token,
//                     //               dateTime: DateTime.now().toString(),
//                     //               text: messageController.text);
//                     //         },
//                     //         icon: Icons.send,
//                     //       ),
//                     //       // SizedBox(width: 5.w,),
//                     //       MyIconButton(
//                     //         onPressed: () {},
//                     //         icon: Icons.mic_none_rounded,
//                     //       )
//                     //     ],
//                     //   ),
//                     // )
//                   ],
//                 ));
//           },
//         );
//       },
//     );
//   }
// }

// // import 'dart:math';

// // import 'package:flutter/material.dart';
// // import 'package:flutter_sound/public/flutter_sound_recorder.dart';
// // import 'package:permission_handler/permission_handler.dart';

// // ************************************************

// // you need to this 2 packages

// // flutter_sound: ^9.2.13
// // permission_handler: ^10.2.0

// // you need to add this permissions in your mainfest file
// //
// // <uses-permission android:name="android.permission.RECORD_AUDIO"/>
// // <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>

// // ****************************************************
// // class Test extends StatefulWidget {
// //   const Test({Key? key}) : super(key: key);

// //   @override
// //   State<Test> createState() => _TestState();
// // }

// // class _TestState extends State<Test> {
// //   final record = FlutterSoundRecorder();
// //   bool isRecorerReady = false;
// //   bool isRecording = false;

// //   @override
// //   void initState() {
// //     checkPermission();
// //     super.initState();
// //   }

// //   Future checkPermission() async {
// //     if (!await Permission.microphone.isGranted) {
// //       PermissionStatus status = await Permission.microphone.request();
// //       if (status != PermissionStatus.granted) {
// //         throw 'Microphone permission is required for this feature';
// //       }
// //     }
// //     await record.openRecorder();

// //     record.setSubscriptionDuration(const Duration(milliseconds: 500));

// //     setState(() {
// //       isRecorerReady = true;
// //     });
// //   }

// //   startVoiceRecording() async {
// //     if (!isRecorerReady) return;
// //     await record.startRecorder(
// //         toFile: '${Random().nextInt(999999)}${DateTime.now().microsecond}');
// //     if (record.isRecording) {
// //       setState(() {
// //         isRecording = true;
// //       });
// //     }
// //   }

// //   cancelVoiceRecording() async {
// //     await record.stopRecorder();
// //     if (record.isStopped) {
// //       setState(() {
// //         isRecording = false;
// //       });
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: [
// //         ElevatedButton(
// //             onPressed: () {
// //               if (isRecording) {
// //                 startVoiceRecording();
// //               } else {
// //                 cancelVoiceRecording();
// //               }
// //             },
// //             child: Text(isRecording ? 'stop recording' : 'start recording ')),
// //       ],
// //     );
// //   }
// // }
