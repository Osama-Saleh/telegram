// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:telegram/Module/user_model_fire.dart';
import 'package:telegram/components/app_colors.dart';
import 'package:telegram/state_management/cubit_states.dart';
import 'package:telegram/state_management/home_cubit.dart';
import 'package:telegram/view/home_view.dart';
import 'package:telegram/widgets/my_icon_button.dart';
import 'package:telegram/widgets/my_text.dart';
import 'package:telegram/widgets/my_text_form_field.dart';

class ChattingView extends StatelessWidget {
  ChattingView({super.key, this.model});
  TextEditingController messageController = TextEditingController();
  final UserModelFire? model;

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
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
                                "${model!.name![0].toUpperCase()}${model!.name![1].toUpperCase()}",
                            color: AppColor.white,
                            fontSize: 12.sp,
                          ))
                        : Image(
                            image: NetworkImage(
                                "${model!.image}"),
                            fit: BoxFit.cover,
                          ),
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  MyText(
                    text: "${model!.name}",
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
                    child: ListView(
                  children: [
                    //* receive message
                    Padding(
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
                              text: "Hollo",
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    //* my message
                    Padding(
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
                              text: "hi",
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
                const Spacer(),
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
                        child: MyTextFormField(
                            controller: messageController,
                            hintText: "Message",
                            border: InputBorder.none),
                      ),
                      MyIconButton(
                        onPressed: () {},
                        icon: Icons.attachment_outlined,
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
  }
}
