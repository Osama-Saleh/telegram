// ignore_for_file: must_be_immutable, avoid_unnecessary_containers, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sizer/sizer.dart';
import 'package:telegram/Module/message_model.dart';
import 'package:telegram/chatting/cubit/chatting_cubit.dart';
import 'package:telegram/components/widgets/my_text.dart';

class MyMessage extends StatelessWidget {
  MyMessage({super.key, this.messageModel});
  MessageModel? messageModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChattingCubit, ChattingState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Align(
            alignment: AlignmentDirectional.topEnd,
            child: messageModel!.text != null 
                //* spicail to text
                ? Container(
                    decoration: BoxDecoration(
                        color: Colors.green[300]!.withOpacity(.5),
                        borderRadius: const BorderRadiusDirectional.only(
                            bottomEnd: Radius.circular(10),
                            topStart: Radius.circular(10),
                            bottomStart: Radius.circular(10))),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            // messageModel!.text != null ?
                            MyText(
                          text: "${messageModel!.text}",
                          fontSize: 15.sp,
                        )
                        // : Image(image: NetworkImage("${messageModel!.image}"),fit: BoxFit.cover,)
                        ),
                  )
                : messageModel!.record != null
                    ? InkWell(
                        onTap: () {
                          ChattingCubit.get(context).initplayer(path: "${messageModel!.record}").whenComplete(() {
                            ChattingCubit.get(context).player.play();
                          print("played");
                          });
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          color: Colors.red,
                          child:Text("${messageModel!.record}"),
                          // const Icon(Icons.play_arrow)
                        ),
                      )
                    //* spicail to image
                    : Container(
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
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      child: AlertDialog(
                                        content: PhotoView(
                                          imageProvider: NetworkImage(
                                              "${messageModel!.image}"),
                                        ),
                                      ),
                                    );
                                  },
                                );
                                print("object");
                              },
                              child: Image(
                                image: NetworkImage("${messageModel!.image}"),
                                fit: BoxFit.cover,
                              ),
                            )),
                      ),
          ),
        );
      },
    );
  }
}
