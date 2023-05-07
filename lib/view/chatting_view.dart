// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:telegram/Module/message_model.dart';
import 'package:telegram/Module/user_model_fire.dart';
import 'package:telegram/components/app_colors.dart';
import 'package:telegram/components/const.dart';
import 'package:telegram/state_management/cubit_states.dart';
import 'package:telegram/state_management/home_cubit.dart';
import 'package:telegram/view/home_view.dart';
import 'package:telegram/widgets/my_icon_button.dart';
import 'package:telegram/widgets/my_text.dart';
import 'package:telegram/widgets/my_text_form_field.dart';

class ChattingView extends StatefulWidget {
  ChattingView({super.key, this.model});
  final UserModelFire? model;

  @override
  State<ChattingView> createState() => _ChattingViewState();
}

class _ChattingViewState extends State<ChattingView> {
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    return Builder(
      builder: (context) {
        cubit.getMessage(receiverId: widget.model!.token);
        return BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
                backgroundColor: AppColor.darkBlue.withOpacity(.2),
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
                        child: cubit.userModel != null
                            ? Center(
                                child: MyText(
                                text:
                                    "${widget.model!.name![0].toUpperCase()}${widget.model!.name![1].toUpperCase()}",
                                color: AppColor.white,
                                fontSize: 12.sp,
                              ))
                            : Image(
                                image: NetworkImage("${widget.model!.image}"),
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
                            builder: (context) => HomeView(),
                          ));
                    },
                    icon: Icons.arrow_back,
                  ),
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: cubit.messages!.length == null
                            ? MyText(
                                text: "not Message yet",
                              )
                            : ListView.separated(
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
                                itemCount:
                                    HomeCubit.get(context).messages!.length)),
                    Container(
                      height: 10.h,
                      width: double.infinity,
                      color: AppColor.white,
                      padding: EdgeInsets.only(left: 2.h, right: 2.h),
                      child: Row(
                        children: [
                          MyIconButton(
                            onPressed: () {},
                            icon: Icons.emoji_emotions_outlined,
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: messageController,
                              onChanged: (value) {
                                setState(() {
                                  
                                });
                                messageController.text = value.toString();
                                print(value);
                              },
                              decoration: InputDecoration(
                                // labelText: labelText,
                                labelStyle: TextStyle(fontSize: 15.sp),
                                hintText: "Message",
                                hintStyle: TextStyle(fontSize: 15.sp),

                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                contentPadding: EdgeInsets.all(3.h),
                              ),
                            ),
                            //  MyTextFormField(
                            //     controller: messageController,
                            //     hintText: "Message",
                            //     border: InputBorder.none),
                          ),
                          MyIconButton(
                            onPressed: () {
                              cubit.sendMessage(
                                  receiverId: widget.model!.token,
                                  dateTime: DateTime.now().toString(),
                                  text: messageController.text);
                            },
                            icon: Icons.send,
                          ),
                          // SizedBox(width: 5.w,),
                          MyIconButton(
                            onPressed: () {},
                            icon: Icons.mic_none_rounded,
                          )
                        ],
                      ),
                    )
                  ],
                ));
          },
        );
      },
    );
  }
}

class MyMessage extends StatelessWidget {
  MyMessage({super.key, this.messageModel});
  MessageModel? messageModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Align(
        alignment: AlignmentDirectional.topEnd,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.green[300]!.withOpacity(.5),
              borderRadius: const BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(10),
                  topStart: Radius.circular(10),
                  bottomStart: Radius.circular(10))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyText(
              text: "${messageModel!.text}",
              fontSize: 15.sp,
            ),
          ),
        ),
      ),
    );
  }
}

class ReceiveMessage extends StatelessWidget {
  ReceiveMessage({super.key, this.messageModel});
  MessageModel? messageModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(10),
                  topEnd: Radius.circular(10),
                  bottomStart: Radius.circular(10))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyText(
              text: "${messageModel!.text}",
              fontSize: 15.sp,
            ),
          ),
        ),
      ),
    );
  }
}
