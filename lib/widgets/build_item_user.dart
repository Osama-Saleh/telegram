// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:telegram/Module/user_model_fire.dart';
import 'package:telegram/chatting/chatting_view.dart';
import 'package:telegram/components/app_colors.dart';
import 'package:telegram/user/cubit/user_cubit.dart';
// import 'package:telegram/view/chatting_view.dart';
import 'package:telegram/widgets/my_divider.dart';
import 'package:telegram/widgets/my_text.dart';

class BuildItemsUser extends StatelessWidget {
  const BuildItemsUser({
    super.key,
    // this.userModel,
    this.model,
    // this.name,
  });
  // final UserModel? userModel;
  final UserModelFire? model;
  // final String? name;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          height: 18.h,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChattingView(model: model ) ,));
                  },
                  child: Row(
                    children: [
                      //*===============================================================
                      //* if user not have image take take first two character from name
                      //*===============================================================
                      Container(
                        height: 15.h,
                        width: 15.w,
                        clipBehavior: Clip.antiAlias,
                        margin: EdgeInsets.only(left: 2.h),
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: model!.image == null
                            ? Center(
                                child: MyText(
                                  text:
                                      "${model!.name![0].toUpperCase()}${model!.name![1].toUpperCase()}",
                                  color: AppColor.white,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : Image(
                                image: NetworkImage("${model!.image}"),
                                fit: BoxFit.cover,
                              ),
                      ),
                      //*================================================================
                      SizedBox(
                        width: 3.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            text: "${model!.name}",
                            fontSize: 15.sp,
                          ),
                          MyText(
                            text: "Message",
                            fontSize: 11.sp,
                          )
                        ],
                      ),
                      const Spacer(),
                      Container(
                        margin: EdgeInsets.only(right: 2.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyText(
                              text: "2:55 PM",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Container(
                              height: 4.h,
                              width: 12.w,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(20.sp)),
                              child: Center(
                                  child: MyText(
                                text: "5324",
                                color: AppColor.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                              )),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              MyDivider()
            ],
          ),
        );
      },
    );
  }
}
