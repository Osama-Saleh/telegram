// // ignore_for_file: avoid_print

// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:telegram/chatting/cubit/chatting_cubit.dart';
import 'package:telegram/components/widgets/my_text.dart';
import 'package:telegram/state_management/home_cubit.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;

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
  }

  Future stop() async {
    if (!isRecorderReady) return;
    final path = await recorder.stopRecorder();
    final audioFile = File(path!);
    print("recording $audioFile");
  }

  @override
  void initState() {
    super.initState();
    initRecorder();
  }

  @override
  void dispose() {
    super.dispose();
    recorder.closeRecorder();
  }

  int? num = 0;
  bool isPlay = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChattingCubit, ChattingState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // StreamBuilder(
              //   stream: recorder.onProgress,
              //   builder: (context, snapshot) {
              //     final duraton =
              //         snapshot.hasData ? snapshot.data!.duration : Duration.zero;

              //     String twoDigits(int n) => n.toString().padLeft(0);
              //     final twoDigitsMinutes =
              //         twoDigits(duraton.inMinutes.remainder(60));
              //     final twoDigitsSeconds =
              //         twoDigits(duraton.inSeconds.remainder(60));

              //     return MyText(
              //       text: "${twoDigitsMinutes} : $twoDigitsSeconds",
              //       fontSize: 20,
              //       fontWeight: FontWeight.bold,
              //     );
              //   },
              // ),
              ElevatedButton(
                  onPressed: () {
                    ChattingCubit.get(context)
                        .initplayer(
                            path:
                                "File: '/data/user/0/com.example.telegram/cache/audio237'")
                        .whenComplete(() {
                      if (ChattingCubit.get(context).showPlay == true) {
                        ChattingCubit.get(context).player.pause();
                      } else {
                        ChattingCubit.get(context).player.play();
                      }
                      print("played");
                    });
                  },
                  child: ChattingCubit.get(context).showPlay
                      ? const Icon(Icons.pause)
                      : const Icon(Icons.play_arrow)),
              // Text("$num"),
              // InkWell(
              //     onLongPress: () {
              //       Timer.periodic(
              //         const Duration(seconds: 1),
              //         (Timer timer) {
              //           setState(() {
              //             num = num! + 1;
              //           });
              //           if (num == 60) {
              //             timer.cancel();
              //           }
              //         },
              //       );
              //     },
              //     child: Icon(Icons.ads_click))
            ],
          ),
        )
            // Center(
            //     child: Container(
            //   child: SocialMediaRecorder(
            //     sendRequestFunction: (soundFile) {
            //       // print("the current path is ${soundFile.path}");
            //       print("Recorded");
            //     },
            //     encode: AudioEncoderType.AAC,
            //   ),
            // )),

            );
      },
    );
  }
}

// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter_sound/public/flutter_sound_recorder.dart';
// import 'package:permission_handler/permission_handler.dart';

// ************************************************

// you need to this 2 packages

// flutter_sound: ^9.2.13
// permission_handler: ^10.2.0

// you need to add this permissions in your mainfest file
//
// <uses-permission android:name="android.permission.RECORD_AUDIO"/>
// <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>

// ****************************************************
// class Test extends StatefulWidget {
//   const Test({Key? key}) : super(key: key);

//   @override
//   State<Test> createState() => _TestState();
// }

// class _TestState extends State<Test> {
//   final record = FlutterSoundRecorder();
//   bool isRecorerReady = false;
//   bool isRecording = false;

//   @override
//   void initState() {
//     checkPermission();
//     super.initState();
//   }

//   Future checkPermission() async {
//     if (!await Permission.microphone.isGranted) {
//       PermissionStatus status = await Permission.microphone.request();
//       if (status != PermissionStatus.granted) {
//         throw 'Microphone permission is required for this feature';
//       }
//     }
//     await record.openRecorder();

//     record.setSubscriptionDuration(const Duration(milliseconds: 500));

//     setState(() {
//       isRecorerReady = true;
//     });
//   }

//   startVoiceRecording() async {
//     if (!isRecorerReady) return;
//     await record.startRecorder(
//         toFile: '${Random().nextInt(999999)}${DateTime.now().microsecond}');
//     if (record.isRecording) {
//       setState(() {
//         isRecording = true;
//       });
//     }
//   }

//   cancelVoiceRecording() async {
//     await record.stopRecorder();
//     if (record.isStopped) {
//       setState(() {
//         isRecording = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ElevatedButton(
//             onPressed: () {
//               if (isRecording) {
//                 startVoiceRecording();
//               } else {
//                 cancelVoiceRecording();
//               }
//             },
//             child: Text(isRecording ? 'stop recording' : 'start recording ')),
//       ],
//     );
//   }
// }
