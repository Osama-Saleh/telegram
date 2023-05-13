// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables, prefer_is_empty, avoid_print, sized_box_for_whitespace

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
import 'package:telegram/widgets/my_icon_button.dart';
import 'package:telegram/widgets/my_text.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_sound/flutter_sound.dart';

class ChattingView extends StatefulWidget {
  ChattingView({super.key, this.model});
  final UserModelFire? model;

  @override
  State<ChattingView> createState() => _ChattingState();
}

class _ChattingState extends State<ChattingView> {
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  var formKey = GlobalKey<FormState>();
  bool isMice = false;
  //!==============================================
  FlutterSoundRecorder? myRecord;
  final audioPlayer = AssetsAudioPlayer();
  String? filePath;
  bool? play = false;
  String? recordText = "00:00:00";

  void startIt() async {
    filePath = "/sdcard/Download/temp.wav";
    myRecord = FlutterSoundRecorder();
    // await myRecord.openRecorder();
  }
  // @override
  // void initState() {
  //   super.initState();
  //   if (ChattingCubit.get(context).messages == null) {
  //     Future.delayed(const Duration(milliseconds: 500), () {
  //       scrollController.animateTo(scrollController.position.maxScrollExtent,
  //           duration: const Duration(milliseconds: 100), curve: Curves.easeIn);
  //     });
  //   }
  // }
  // @override
  // void dispose() {
  //   messageController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var cubit = ChattingCubit.get(context);
    return Builder(
      builder: (context) {
        //!-----------------------------------------
        cubit.getMessage(receiverId: widget.model!.token);
        return BlocConsumer<ChattingCubit, ChattingState>(
          listener: (context, state) {},
          builder: (context, state) {
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
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeView(),
                          ));
                    },
                    icon: Icons.arrow_back,
                  ),
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //*=========================================================
                    //*                   List of message
                    //*=========================================================
                    Expanded(
                        // flex: 10,
                        child: cubit.messages!.isEmpty
                            ? Center(
                                child: MyText(
                                  text: "Say Hello 👋",
                                  fontSize: 20.sp,
                                ),
                              )
                            : ListView.separated(
                                controller: scrollController,
                                itemBuilder: (context, index) {
                                  if (MyConst.uidUser ==
                                      cubit.messages![index].senderId) {
                                    //* My message
                                    return MyMessage(
                                      messageModel: cubit.messages![index],
                                    );
                                  }
                                  return

                                      //* receive message
                                      ReceiveMessage(
                                    messageModel: cubit.messages![index],
                                  );
                                },
                                separatorBuilder: (context, index) => SizedBox(
                                      height: 5.h,
                                    ),
                                itemCount: ChattingCubit.get(context)
                                    .messages!
                                    .length)),
                    //*========================================================
                    //*                 input my message
                    //*========================================================
                    Form(
                      key: formKey,
                      child: Container(
                        color: AppColor.white,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                  controller: messageController,
                                  minLines: 1,
                                  maxLines: 5,
                                  onTap: () {
                                    setState(() {
                                      cubit.isEmojiSelected = false;
                                    });
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      messageController.text;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(fontSize: 15.sp),
                                    hintText: "Message",
                                    hintStyle: TextStyle(fontSize: 15.sp),
                                    prefixIcon: IconButton(
                                        onPressed: () {
                                          cubit.selectEmoji();

                                          //*===========================================
                                          //* hide keyboardType when click in emoji icon
                                          //*===========================================
                                          SystemChannels.textInput
                                              .invokeMethod("TextInput.hide");
                                          print(
                                              "isEmoji ${cubit.isEmojiSelected}");
                                        },
                                        icon: const Icon(
                                            Icons.emoji_emotions_outlined)),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(3.h),
                                  ),
                                  keyboardType: TextInputType.multiline),
                            ),
                            MyIconButton(
                              onPressed: messageController.text.trim().isEmpty
                                  ? null
                                  : () {
                                      print(
                                          "messageController : ${messageController.text}");
                                      cubit
                                          .sendMessage(
                                              receiverId: widget.model!.token,
                                              dateTime:
                                                  DateTime.now().toString(),
                                              text: messageController.text,
                                              image:
                                                  cubit.selectImage.toString())
                                          .whenComplete(() {
                                        if (cubit.messages != null) {
                                          Future.delayed(
                                            const Duration(milliseconds: 1000),
                                            () {
                                              scrollController.animateTo(
                                                  scrollController
                                                      .position.maxScrollExtent,
                                                  duration: const Duration(
                                                      milliseconds: 100),
                                                  curve: Curves.easeIn);
                                            },
                                          );
                                          print("MaxScroll");
                                        }
                                        messageController.text = " ";
                                      });
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

                            InkWell(
                              onLongPress: () async {
                                if (isMice) {
                                  print("long");
                                } else {
                                  cubit.setSelectImage(
                                      receiverId: widget.model!.token);
                                }
                              },
                              child: MyIconButton(
                                onPressed: () {
                                  setState(() {
                                    isMice = !isMice;
                                  });
                                },
                                icon: isMice
                                    ? Icons.mic_none_rounded
                                    : Icons.image_outlined,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    //*
                    if (cubit.isEmojiSelected == true)
                      Expanded(
                        child: Container(
                          height: 50.h,
                          width: double.infinity,
                          child: EmojiPicker(
                            textEditingController: messageController,
                            onEmojiSelected: (category, emoji) {
                              setState(() {
                                messageController;
                              });
                            },
                          ),
                        ),
                      )
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
                ));
          },
        );
      },
    );
  }
}
