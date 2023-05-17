// // ignore_for_file: avoid_print

// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps

// import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_sound/flutter_sound.dart';
import 'package:telegram/chatting/cubit/chatting_cubit.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  // final recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;

  // Future initRecorder() async {
  //   final status = await Permission.microphone.request();
  //   if (status != PermissionStatus.granted) {
  //     throw "Microphone Permission not granted";
  //   }
  //   await recorder.openRecorder();
  //   isRecorderReady = true;
  //   recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  // }

  // Future record() async {
  //   if (!isRecorderReady) return;
  //   await recorder.startRecorder(toFile: "audio${DateTime.now().millisecond}");
  // }

  // Future stop() async {
  //   if (!isRecorderReady) return;
  //   final path = await recorder.stopRecorder();
  //   final audioFile = File(path!);
  //   print("recording $audioFile");
  // }

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

  @override
  void dispose() {
    super.dispose();
    // recorder.closeRecorder();
  }

  final audioPlayer = AudioPlayer();
  bool isPlay = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  String formatTime(int seconds) {
    return "${Duration(seconds: seconds)}".split(".")[0].padLeft(8, "0");
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChattingCubit, ChattingState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            body: Container(
          color: Colors.amber,
          child: Container(
            height: 80,
            color: Colors.red,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          String? uri =
                              // "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3";
                              "https://firebasestorage.googleapis.com/v0/b/telegram-da9d4.appspot.com/o/records%2Faudio184.mp3?alt=media&token=89f830fb-3adb-43b4-8e0c-af78c8c97e93.mp3";
                          // var  uu = Uri.parse(uri);
                          audioPlayer.play(UrlSource(uri));
                          setState(() {
                            isPlay = !isPlay;
                          });
                        },
                        child: isPlay
                            ? const Icon(Icons.pause)
                            : const Icon(Icons.play_arrow)),
                    Slider(
                      min: 0,
                      max: duration.inSeconds.toDouble(),
                      value: position.inSeconds.toDouble(),
                      onChanged: (value) {
                        final position = Duration(seconds: value.toInt());
                        audioPlayer.seek(position);
                        audioPlayer.resume();
                      },
                    )
                  ],
                ),
                Row(
                  children: [
                    // Text(formatTime(position.inSeconds)),
                    Spacer(),
                    Text(formatTime((duration - position).inSeconds)),
                  ],
                ),
              ],
            ),
          ),
        ));
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
