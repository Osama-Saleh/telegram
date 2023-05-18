// ignore_for_file: must_be_immutable, avoid_unnecessary_containers, avoid_print

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_document/open_document.dart';
// import 'package:open_document/open_document.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sizer/sizer.dart';
import 'package:telegram/Module/message_model.dart';
import 'package:telegram/chatting/cubit/chatting_cubit.dart';
import 'package:telegram/components/widgets/my_text.dart';
import 'package:telegram/controller/local_storage/hive.dart';
import 'package:url_launcher/url_launcher.dart';

class MyMessage extends StatefulWidget {
  MyMessage({super.key, this.messageModel});
  MessageModel? messageModel;

  @override
  State<MyMessage> createState() => _MyMessageState();
}

class _MyMessageState extends State<MyMessage> {
  final audioPlayer = AudioPlayer();

  bool isPlay = false;

  Duration duration = Duration.zero;

  Duration position = Duration.zero;

  String formatTime(int seconds) {
    return "${Duration(seconds: seconds)}".split(".")[0].padLeft(8, "0");
  }

  @override
  void initState() {
    super.initState();
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlay = state == PlayerState.playing;
      });
    });
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   // recorder.closeRecorder();
  // }

  void oncePlayRecord(bool isplayed) {
    isPlay = isplayed;
    setState(() {});
  }

  Future<void> openDocument(String? filePath) async {
    // await OpenDocument.openDocument(
    //     filePath: filePath!,
    //   );

    // await launchUrl(Uri.parse(
    //       "https://firebasestorage.googleapis.com/v0/b/telegram-da9d4.appspot.com/o/docs?alt=media&token=f4250f1b-cf3c-4272-96d0-505b21d3e0c2"));

    if (await canLaunchUrl(Uri.parse(
        "https://firebasestorage.googleapis.com/v0/b/telegram-da9d4.appspot.com/o/docs?alt=media&token=f4250f1b-cf3c-4272-96d0-505b21d3e0c2"))) {
      await launchUrl(
        Uri.parse(
            "https://firebasestorage.googleapis.com/v0/b/telegram-da9d4.appspot.com/o/docs?alt=media&token=f4250f1b-cf3c-4272-96d0-505b21d3e0c2"),
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch document';
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChattingCubit, ChattingState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Align(
              alignment: AlignmentDirectional.topEnd,
              child: widget.messageModel!.text != null ||
                      widget.messageModel!.docs != null
                  //* spicail to text
                  ? Container(
                      margin: EdgeInsets.only(left: 30.h),
                      decoration: BoxDecoration(
                          color: Colors.green[300]!.withOpacity(.5),
                          borderRadius: const BorderRadiusDirectional.only(
                              bottomEnd: Radius.circular(10),
                              topStart: Radius.circular(10),
                              bottomStart: Radius.circular(10))),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: widget.messageModel!.text == null
                              ? InkWell(
                                  onTap: () async {
                                    print("Clicked");
                                    
                                    // openDocument(
                                    //     "${widget.messageModel!.docs}");
                                  },
                                  child: MyText(
                                    text: "${widget.messageModel!.docs}",
                                    fontSize: 15.sp,
                                  ),
                                )
                              : MyText(
                                  text: "${widget.messageModel!.text}",
                                  fontSize: 15.sp,
                                )
                          // : Image(image: NetworkImage("${messageModel!.image}"),fit: BoxFit.cover,)
                          ),
                    )

                  //* spicail to image
                  : widget.messageModel!.image != null
                      ? Container(
                          width: 40.h,
                          height: 40.w,
                          decoration: BoxDecoration(
                              color: Colors.green[300]!.withOpacity(.5),
                              borderRadius: const BorderRadiusDirectional.only(
                                  bottomEnd: Radius.circular(10),
                                  topStart: Radius.circular(10),
                                  bottomStart: Radius.circular(10))),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  // Dialog(
                                  //   child: Container(
                                  //     width: 200,
                                  //     height: 200,
                                  //     decoration: BoxDecoration(
                                  //         image: DecorationImage(
                                  //             image: ExactAssetImage(
                                  //                 'assets/tamas.jpg'),
                                  //             fit: BoxFit.cover)),
                                  //   ),
                                  // );
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          // decoration: BoxDecoration(
                                          // color: Colors.amber,
                                          //     image: DecorationImage(
                                          //   image: NetworkImage(
                                          //       "${widget.messageModel!.image}"),
                                          //   fit: BoxFit.fill,
                                          // )),
                                          child: PhotoView(
                                            imageProvider: NetworkImage(
                                              "${widget.messageModel!.image}",
                                            ),
                                          )
                                          // child: Dialog(
                                          //   child: Container(
                                          //     child: PhotoView(
                                          //     imageProvider: NetworkImage(

                                          //       "${widget.messageModel!.image}",

                                          //     ),
                                          //   ),
                                          //   ),
                                          //   // child: PhotoView(
                                          //   //   imageProvider: NetworkImage(
                                          //   //     "${widget.messageModel!.image}",

                                          //   //   ),
                                          //   // ),
                                          // ),
                                          );
                                    },
                                  );
                                  print("object");
                                },
                                child: Image(
                                  image: NetworkImage(
                                      "${widget.messageModel!.image}"),
                                  fit: BoxFit.cover,
                                ),
                              )),
                        )
                      //* spicail to record message
                      : Container(
                          width: 60.w,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.green[300]!.withOpacity(.5),
                              borderRadius: const BorderRadiusDirectional.only(
                                  bottomEnd: Radius.circular(10),
                                  topStart: Radius.circular(10),
                                  bottomStart: Radius.circular(10))),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      String? uri =
                                          // "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3";
                                          "${widget.messageModel!.record}";
                                      setState(() {
                                        isPlay = !isPlay;
                                        // widget.messageModel.onceRecordPlaying = true;
                                      });
                                      if (isPlay == false) {
                                        audioPlayer.pause();
                                      } else {
                                        audioPlayer.play(UrlSource(uri));
                                      }
                                      print(isPlay);
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.green[700],
                                      child: isPlay
                                          ? const Icon(Icons.pause)
                                          : const Icon(Icons.play_arrow),
                                    ),
                                  ),
                                  Expanded(
                                    child: Slider(
                                      min: 0,
                                      max: duration.inSeconds.toDouble(),
                                      value: position.inSeconds.toDouble(),
                                      thumbColor: Colors.green,
                                      activeColor: Colors.green[900],
                                      onChanged: (value) {
                                        final position =
                                            Duration(seconds: value.toInt());
                                        audioPlayer.seek(position);
                                        audioPlayer.resume();
                                      },
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  // Text(formatTime(position.inSeconds)),
                                  Spacer(),
                                  Text(formatTime(
                                      (duration - position).inSeconds)),
                                ],
                              ),
                            ],
                          ),
                        )),
        );
      },
    );
  }
}
