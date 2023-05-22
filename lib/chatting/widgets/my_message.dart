// ignore_for_file: must_be_immutable, avoid_unnecessary_containers, avoid_print

import 'dart:isolate';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:open_filex/open_filex.dart';
// import 'package:open_filex/open_filex.dart';

// import 'package:open_document/open_document.dart';
// import 'package:open_document/open_document.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sizer/sizer.dart';
import 'package:telegram/Module/message_model.dart';
import 'package:telegram/chatting/cubit/chatting_cubit.dart';
import 'package:telegram/components/widgets/my_text.dart';
// import 'package:telegram/controller/local_storage/hive.dart';

class MyMessage extends StatefulWidget {
  MyMessage({
    super.key,
    this.messageModel,
  });
  MessageModel? messageModel;
  // String? fileName;

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

  ReceivePort port = ReceivePort();
  int progress = 0;
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
    //* chick folder staus (faild - completed - run -......)
    IsolateNameServer.registerPortWithName(
        port.sendPort, 'downloader_send_port');
        print("logprogress");
        
    port.listen((dynamic data) {
      String? id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
        print("Myprogress");
      setState(() {
        progress = data;
      });
      if (status.toString() == "DownloadTaskStatus(3)" &&
          progress == 100 &&
          id != null) {
        print("Dowloaded Completed");
      }
    });
    FlutterDownloader.registerCallback(downloadCallback);
  }

//* Call back to download file
  static void downloadCallback(id, status, progress) async {
    SendPort? sendPort =
        IsolateNameServer.lookupPortByName("downloader_send_port");

    sendPort!.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChattingCubit, ChattingState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ChattingCubit.get(context);
        return Padding(
          padding: EdgeInsets.only(right: 2.h, top: 2.h),
          child: Align(
              alignment: AlignmentDirectional.topEnd,
              child: widget.messageModel!.text != null ||
                      widget.messageModel!.docsUrl != null
                  //* spicail to text
                  ? Container(
                      margin: EdgeInsets.only(left: 25.h),
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
                                    // if (cubit.docsLocation[1] ==
                                    //     cubit.externalDir) {
                                    //   print("downloaded ");
                                    // } else {
                                    cubit.downloadDocuments(
                                        url: "${widget.messageModel!.docsUrl}",
                                        fileName:
                                            "${widget.messageModel!.docsName}");

                                    print("Download is done");

                                    // OpenFilex.open(
                                    //     "/storage/emulated/0/Android/data/com.example.telegram/files/Coronel_PPT_Ch01 (3).pdf");

                                    // }
                                  },
                                  child: Row(children: [
                                    Text("$progress"),
                                    // const Icon(Icons.file_copy_outlined),
                                    SizedBox(
                                      width: 1.h,
                                    ),
                                    Expanded(
                                      child: MyText(
                                        text:
                                            "${widget.messageModel!.docsName}",
                                        fontSize: 15.sp,
                                      ),
                                    )
                                  ]),
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
