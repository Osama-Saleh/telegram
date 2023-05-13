import 'package:flutter/material.dart';
import 'package:social_media_recorder/audio_encoder_type.dart';
import 'package:social_media_recorder/screen/social_media_recorder.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Container(
        child:  SocialMediaRecorder(
                  sendRequestFunction: (soundFile) {
                    // print("the current path is ${soundFile.path}");
                  },
                  encode: AudioEncoderType.AAC,
                ),
      )),
    );
  }
}