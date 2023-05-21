// ignore_for_file: must_be_immutable, avoid_unnecessary_containers, avoid_print

import 'dart:isolate';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
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
  // bool? isLoading;
  // bool? permissionReady;
  // String? localPath;
  // int? progress = 0;

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
    IsolateNameServer.registerPortWithName(
        port.sendPort, 'downloader_send_port');
    port.listen((dynamic data) {
      String? id = data[0];
      DownloadTaskStatus  status = data[1] ;
      int progress = data[2];
      if (status.toString() == "DownloadTaskStatus(3)" && progress == 100 && id != null) {
        print("Dowloaded Completed");
      }
      setState(() {});
    });
    FlutterDownloader.registerCallback(downloadCallback);
  }

  static void downloadCallback(id, status, progress) {
    SendPort? sendPort =
        IsolateNameServer.lookupPortByName("downloader_send_port");
    sendPort!.send([id, status, progress]);
  }

  // void bindBackgroundIsolated() {
  //   bool isSucces = IsolateNameServer.registerPortWithName(
  //       port.sendPort, 'downloader_send_port');
  //   port.listen(
  //     (dynamic data) {
  //       String id = data[0];
  //       DownloadTaskStatus status = data[1];
  //       int progress = data[2];
  //       FlutterDownloader.registerCallback(
  //           downloadCallback);

  //       setState(() {});
  //       // if (status == DownloadTaskStatus.complete) {
  //       // } else if (status == DownloadTaskStatus.running) {
  //       //   Progresshud.showWithStatus("%$progress Downloaded");
  //       // }
  //     },
  //     // onDone: () {
  //     //   checkIfDictionaryUnzipped(DBFilePath);
  //     // },
  //     // onError: (error) {},
  //   );
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   IsolateNameServer.removePortNameMapping('downloader_send_port');
  //   // recorder.closeRecorder();
  // }

  // downloadCallback(String id, DownloadTaskStatus status, int progress) {
  //   final SendPort? send =
  //       IsolateNameServer.lookupPortByName('downloader_send_port');
  //   send!.send([id, status, progress]);
  // }

  // void oncePlayRecord(bool isplayed) {
  //   isPlay = isplayed;
  //   setState(() {});
  // }

  Future download(String url) async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      final externalDir = await getExternalStorageDirectory();

      await FlutterDownloader.enqueue(
        url: url,
        savedDir: externalDir!.path,
        showNotification: true,
        openFileFromNotification: true,
      );
    } else {
      print('Permission Denied');
    }
  }

  // Future<void> openDocument(String? filePath) async {
  //   // await OpenDocument.openDocument(
  //   //     filePath: filePath!,
  //   //   );

  //   // await launchUrl(Uri.parse(
  //   //       "https://firebasestorage.googleapis.com/v0/b/telegram-da9d4.appspot.com/o/docs?alt=media&token=f4250f1b-cf3c-4272-96d0-505b21d3e0c2"));

  //   if (await canLaunchUrl(Uri.parse("$filePath"))) {
  //     await launchUrl(
  //       Uri.parse("$filePath"),
  //       mode: LaunchMode.externalApplication,
  //     );
  //   } else {
  //     throw 'Could not launch document';
  //   }
  // }

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
                      widget.messageModel!.docs != null
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
                                    print("${cubit.fileName}");

                                    // download(
                                    //     "https://eecs.csuohio.edu/~sschung/cis430/Coronel_PPT_Ch01.pdf");
                                    // download(
                                    //     "https://file-examples.com/storage/fea9880a616463cab9f1575/2017/04/file_example_MP4_480_1_5MG.mp4");
                                    download(
                                        "https://eecs.csuohio.edu/~sschung/cis430/Coronel_PPT_Ch01.pdf");
                                    // cubit.downloadFile(
                                    //     "https://eecs.csuohio.edu/~sschung/cis430/Coronel_PPT_Ch01.pdf");
                                    // openDocument(
                                    //     "${widget.messageModel!.docs}");
                                  },
                                  child: Row(children: [
                                    Icon(Icons.file_copy_outlined),
                                    SizedBox(
                                      width: 1.h,
                                    ),
                                    Expanded(
                                      child: MyText(
                                        text: "${widget.messageModel!.docs}",
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
