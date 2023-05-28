// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables, prefer_is_empty, avoid_print, sized_box_for_whitespace

import 'dart:async';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:telegram/Module/user_model_fire.dart';
import 'package:telegram/chatting/cubit/chatting_cubit.dart';
import 'package:telegram/chatting/widgets/my_message.dart';
import 'package:telegram/chatting/widgets/receive_message.dart';
import 'package:telegram/components/app_colors.dart';
import 'package:telegram/components/const.dart';
import 'package:telegram/home/home_view.dart';
import 'package:telegram/components/widgets/my_icon_button.dart';
import 'package:telegram/components/widgets/my_text.dart';

class ChattingView extends StatefulWidget {
  ChattingView({super.key, this.model});
  final UserModelFire? model;

  @override
  State<ChattingView> createState() => _ChattingState();
}

class _ChattingState extends State<ChattingView> {
  // TextEditingController messageController = TextEditingController();
  // ScrollController scrollController = ScrollController();
  // var formKey = GlobalKey<FormState>();
  // bool isMice = false;
  // String? hintText = "Message";
  // int? num = 0;
  //!==============================================
  // FlutterSoundRecorder? myRecord;
  // final audioPlayer = AssetsAudioPlayer();
  // String? filePath;
  // bool? play = false;
  // String? recordText = "00:00:00";

  // void startIt() async {
  //   filePath = "/sdcard/Download/temp.wav";
  //   myRecord = FlutterSoundRecorder();
  //   // await myRecord!
  // }
  @override
  void initState() {
    super.initState();
    ChattingCubit.get(context).initRecorder();
    ChattingCubit.get(context).getMessage(receiverId: widget.model!.token);
    // if (ChattingCubit.get(context).messages == null) {
    //   Future.delayed(const Duration(milliseconds: 500), () {
    //     scrollController.animateTo(scrollController.position.maxScrollExtent,
    //         duration: const Duration(milliseconds: 100), curve: Curves.easeIn);
    //   });
    // }
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   // dispose();
  // }

  // @override
  // void dispose() {
  //   ChattingCubit.get(context).recorder.closeRecorder();
  //   print("record closed");
  //   // messageController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // var cubit = ChattingCubit.get(context);
    return Scaffold(
        backgroundColor: AppColor.lightGreen,
        appBar: AppBar(
          backgroundColor: AppColor.darkBlue,
          centerTitle: false,
          toolbarHeight: 10.h,
          title: Row(
            children: [
              Container(
                height: 12.h,
                width: 12.w,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: widget.model!.image == null
                    ? Center(
                        child: MyText(
                        text:
                            "${widget.model!.name![0].toUpperCase()}${widget.model!.name![1].toUpperCase()}",
                        color: AppColor.white,
                        fontSize: 12.sp,
                      ))
                    : Image(
                        image: NetworkImage(
                          "${widget.model!.image}",
                        ),
                        fit: BoxFit.cover,
                      ),
              ),
              SizedBox(
                width: 3.w,
              ),
              MyText(
                text: "${widget.model!.name}",
                fontSize: 15.sp,
              ),
            ],
          ),
          leading: MyIconButton(
            onPressed: () {
              // SchedulerBinding.instance.addPostFrameCallback((_) {
              //   Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //       builder: (__) => const HomeView(),
              //     ));
              // });
              // Navigator.pushReplacementNamed(context, "/homeView");

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeView(),
                  )).whenComplete(() {
                ChattingCubit.get(context).recorder.closeRecorder();
              });
            },
            icon: Icons.arrow_back,
          ),
        ),
        body: BlocConsumer<ChattingCubit, ChattingState>(
          listener: (context, state) {
            if (state is UploadRecordSuccessState || state is SendMessageLoadingState) {
              ChattingCubit.get(context).messageController.text = "";

              ChattingCubit.get(context).secondTime = 0;
              ChattingCubit.get(context).minutesTime = 0;
            }
          },
          builder: (context, state) {
            if (state is SendMessageSuccessState) {
              ChattingCubit.get(context)
                  .getMessage(receiverId: widget.model!.token);
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //*=========================================================
                //*                   List of message
                //*=========================================================

                Expanded(
                    child: ChattingCubit.get(context).messages!.isEmpty
                        ? Center(
                            child: MyText(
                              text: "Say Hello 👋",
                              fontSize: 20.sp,
                            ),
                          )
                        : ListView.separated(
                            controller: ChattingCubit.get(context).scrollController,
                            itemBuilder: (context, index) {
                              if (MyConst.uidUser ==
                                  ChattingCubit.get(context)
                                      .messages![index]
                                      .senderId) {
                                //* My message

                                return MyMessage(
                                  messageModel: ChattingCubit.get(context)
                                      .messages![index],
                                  index: index,
                                  // fileName: cubit.fileName![index],
                                );
                              }
                              return

                                  //* receive message
                                  ReceiveMessage(
                                messageModel:
                                    ChattingCubit.get(context).messages![index],
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 5.h,
                                ),
                            itemCount:
                                ChattingCubit.get(context).messages!.length)),
                //*========================================================
                //*                 input my message

                //*========================================================
                // Container(
                //   child: Text("${cubit.minutesTime}:${cubit.secondTime}"),
                // ),

                Form(
                  key: ChattingCubit.get(context).formKey,
                  child: Container(
                      color: AppColor.white,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                    controller: ChattingCubit.get(context)
                                        .messageController,
                                    minLines: 1,
                                    maxLines: 5,
                                    onTap: () {
                                      ChattingCubit.get(context)
                                          .isEmojiSelected = false;

                                      print("emoji");
                                    },
                                    onChanged: (value) {
                                      ChattingCubit.get(context)
                                          .textEditController();
                                      // setState(() {
                                      //   messageController.text;
                                      // });
                                    },
                                    decoration: InputDecoration(
                                      labelStyle: TextStyle(fontSize: 15.sp),
                                      hintText: ChattingCubit.get(context)
                                              .isChangeHintText
                                          ? "${ChattingCubit.get(context).minutesTime}:${ChattingCubit.get(context).secondTime}"
                                          : "Message",
                                      hintStyle: TextStyle(fontSize: 15.sp),
                                      prefixIcon: IconButton(
                                          onPressed: () {
                                            //!========================================== send voice
                                            if (ChattingCubit.get(context)
                                                    .isChangeHintText ==
                                                true) {
                                              // cubit
                                              //     .stop(
                                              //         receiverId:
                                              //             widget.model!.token)
                                              //     .whenComplete(() {
                                              //   cubit.isChangeHintText = false;
                                              //   cubit.hintText = "Message";
                                              //   print("cubit.changeHintText");
                                              // });
                                            } else {
                                              ChattingCubit.get(context)
                                                  .selectEmoji();
                                            }

                                            //*===========================================
                                            //* hide keyboardType when click in emoji icon
                                            //*===========================================
                                            SystemChannels.textInput
                                                .invokeMethod("TextInput.hide");
                                            // print(
                                            //     "isEmoji ${cubit.isEmojiSelected}");
                                          },
                                          icon: ChattingCubit.get(context)
                                                  .isChangeHintText
                                              ? const Icon(Icons.close)
                                              : const Icon(Icons
                                                  .emoji_emotions_outlined)),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(3.h),
                                    ),
                                    keyboardType: TextInputType.multiline),
                              ),
                              MyIconButton(
                                onPressed: (ChattingCubit.get(context)
                                            .messageController
                                            .text
                                            .trim()
                                            .isEmpty &&
                                        ChattingCubit.get(context)
                                                .secondTime! ==
                                            0)
                                    ? null
                                    : () {
                                        print(
                                            "messageController : ${ChattingCubit.get(context).messageController.text}");
                                        if (ChattingCubit.get(context)
                                                .isChangeHintText ==
                                            true) {
                                          ChattingCubit.get(context)
                                              .stop(
                                                  receiverId:
                                                      widget.model!.token)
                                              .whenComplete(() {
                                            ChattingCubit.get(context)
                                                .isChangeHintText = false;
                                            ChattingCubit.get(context)
                                                .hintText = "Message";
                                            print("cubit.changeHintText");
                                          });
                                        } else {
                                          ChattingCubit.get(context)
                                              .sendMessage(
                                            receiverId: widget.model!.token,
                                            dateTime: DateTime.now().toString(),
                                            text: ChattingCubit.get(context)
                                                .messageController
                                                .text,
                                            // image: cubit.selectImage.toString(),
                                            // record: cubit.audioUrl,
                                          )
                                              .whenComplete(() {
                                            ChattingCubit.get(context)
                                                .getMessage(
                                                    receiverId:
                                                        widget.model!.token)
                                                .whenComplete(() {
                                              if (ChattingCubit.get(context)
                                                      .messages !=
                                                  null) {
                                                Future.delayed(
                                                  const Duration(
                                                      milliseconds: 1000),
                                                  () {
                                                    ChattingCubit.get(context).scrollController.animateTo(
                                                        ChattingCubit.get(context).scrollController
                                                            .position
                                                            .maxScrollExtent,
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    100),
                                                        curve: Curves.easeIn);
                                                  },
                                                );
                                                print("MaxScroll");
                                                // print("MaxScroll ${cubit.messages![0].record}");
                                              }
                                              // ChattingCubit.get(context)
                                              //     .messageController
                                              //     .text = "";

                                              // ChattingCubit.get(context)
                                              //     .secondTime = 0;
                                              // ChattingCubit.get(context)
                                              //     .minutesTime = 0;
                                            });
                                          });
                                          //     .whenComplete(() {
                                          //   if (ChattingCubit.get(context)
                                          //           .messages !=
                                          //       null) {
                                          //     Future.delayed(
                                          //       const Duration(
                                          //           milliseconds: 1000),
                                          //       () {
                                          //         scrollController.animateTo(
                                          //             scrollController.position
                                          //                 .maxScrollExtent,
                                          //             duration: const Duration(
                                          //                 milliseconds: 100),
                                          //             curve: Curves.easeIn);
                                          //       },
                                          //     );
                                          //     print("MaxScroll");
                                          //     // print("MaxScroll ${cubit.messages![0].record}");
                                          //   }
                                          //   messageController.text = " ";
                                          //   ChattingCubit.get(context)
                                          //       .secondTime = 0;
                                          //   ChattingCubit.get(context)
                                          //       .minutesTime = 0;
                                          // });
                                        }
                                      },
                                icon: Icons.send,
                              ),
                              // MyElevatedButton(
                              //   onPressed: () {
                              //     cubit.setSelectImage(
                              //         receiverId: widget.model!.token);
                              //   },

                              // ),
                              // ElevatedButton(onPressed: (){}, child: Icon(Icons.image_outlined)),
                              MyIconButton(
                                  onPressed: () {
                                    ChattingCubit.get(context).selectDocuments(
                                        receiverId: widget.model!.token);
                                  },
                                  icon: Icons.attach_file_sharp),
                              InkWell(
                                onLongPress: () async {
                                  if (ChattingCubit.get(context).isMice ==
                                      true) {
                                    ChattingCubit.get(context)
                                        .record()
                                        .whenComplete(() {
                                      print("Recorder");
                                      ChattingCubit.get(context).timeRecord();
                                      //!----------------------------------------------;
                                    });
                                    print("long");
                                    // setState(() {});
                                    // cubit.hintText = "${cubit.minutesTime} : ${cubit.secondTime}";
                                    ChattingCubit.get(context)
                                        .isChangeHintText = true;
                                    print(
                                        "isRecorderReady : ${ChattingCubit.get(context).isRecorderReady}");
                                  } else {
                                    ChattingCubit.get(context).setSelectImage(
                                        receiverId: widget.model!.token);
                                  }
                                },
                                child: MyIconButton(
                                  onPressed: () {
                                    ChattingCubit.get(context).changeMice();
                                    // setState(() {
                                    //   isMice = !isMice;
                                    // });
                                  },
                                  icon: ChattingCubit.get(context).isMice
                                      ? Icons.mic_none_rounded
                                      : Icons.image_outlined,
                                ),
                              )
                            ],
                          ),
                          if (ChattingCubit.get(context).isEmojiSelected ==
                              true)
                            Container(
                              height: 30.h,
                              width: double.infinity,
                              child: EmojiPicker(
                                textEditingController:
                                    ChattingCubit.get(context)
                                        .messageController,
                                onEmojiSelected: (category, emoji) {
                                  ChattingCubit.get(context)
                                      .textEditController();
                                  // setState(() {
                                  //   messageController;
                                  // });
                                },
                              ),
                            )
                        ],
                      )),
                ),
                //*
                // if (cubit.isEmojiSelected == true)
                //   Expanded(
                //     child: Container(
                //       height: 50.h,
                //       width: double.infinity,
                //       child: EmojiPicker(
                //         textEditingController: messageController,
                //         onEmojiSelected: (category, emoji) {
                //           setState(() {
                //             messageController;
                //           });
                //         },
                //       ),
                //     ),
                //   )
                // Container(
                //   height: 10.h,
                //   width: double.infinity,
                //   color: AppColor.white,
                //   padding: EdgeInsets.only(left: 2.h, right: 2.h),
                //   child: Row(
                //     children: [
                //       MyIconButton(
                //         onPressed: () {},
                //         icon: Icons.emoji_emotions_outlined,
                //       ),
                //       SizedBox(
                //         width: 3.w,
                //       ),
                //       Expanded(
                //         child: TextFormField(
                //           controller: messageController,
                //           keyboardType: TextInputType.multiline,
                //           minLines: 1,
                //           maxLines: 5,
                //           onChanged: (value) {
                //             setState(() {});
                //             messageController.text = value.toString();
                //             print(value);
                //           },

                //           decoration: InputDecoration(
                //             // labelText: labelText,
                //             labelStyle: TextStyle(fontSize: 15.sp),
                //             hintText: "Message",
                //             hintStyle: TextStyle(fontSize: 15.sp),

                //             border: InputBorder.none,
                //             contentPadding: EdgeInsets.all(3.h),
                //           ),

                //         ),
                //         //  MyTextFormField(
                //         //     controller: messageController,
                //         //     hintText: "Message",
                //         //     border: InputBorder.none),
                //       ),
                //       MyIconButton(
                //         onPressed: () {
                //           cubit.sendMessage(
                //               receiverId: widget.model!.token,
                //               dateTime: DateTime.now().toString(),
                //               text: messageController.text);
                //         },
                //         icon: Icons.send,
                //       ),
                //       // SizedBox(width: 5.w,),
                //       MyIconButton(
                //         onPressed: () {},
                //         icon: Icons.mic_none_rounded,
                //       )
                //     ],
                //   ),
                // )
              ],
            );
          },
        ));
  }
}

// class NewWidget extends StatelessWidget {
//   const NewWidget({
//     super.key,
//     required this.cubit,
//   });

//   final ChattingCubit cubit;

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: cubit.recorder.onProgress,
//       builder: (context, snapshot) {
//         final duraton =
//             snapshot.hasData ? snapshot.data!.duration : Duration.zero;

//         String twoDigits(int n) => n.toString().padLeft(0);
//         final twoDigitsMinutes = twoDigits(duraton.inMinutes.remainder(60));
//         final twoDigitsSeconds = twoDigits(duraton.inSeconds.remainder(60));

//         return MyText(
//           text: "${twoDigitsMinutes} : $twoDigitsSeconds",
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//         );
//       },
//     );
//   }
// }
