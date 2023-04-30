import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:telegram/components/app_colors.dart';
import 'package:telegram/controller/user_controller.dart';
import 'package:telegram/view/home_view.dart';
import 'package:telegram/widgets/my_icon_button.dart';
import 'package:telegram/widgets/my_text.dart';
import 'package:telegram/widgets/my_text_form_field.dart';

class ChattingView extends StatelessWidget {
  const ChattingView({super.key, this.index});

  final int? index;

  @override
  Widget build(BuildContext context) {
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
                child: UserController.userController[index!].image!.isEmpty
                    ? Center(
                        child: MyText(
                        text:
                            "${UserController.userController[index!].name![0]}${UserController.userController[index!].name![1]}",
                        color: AppColor.white,
                        fontSize: 12.sp,
                      ))
                    : Image(
                        image: NetworkImage(
                            "${UserController.userController[index!].image}"),
                        fit: BoxFit.cover,
                      ),
              ),
              SizedBox(
                width: 3.w,
              ),
              MyText(
                text: "${UserController.userController[index!].name}",
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
          children: [
            Expanded(child: ListView()),
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
                  const Expanded(
                    child: MyTextFormField(
                        hintText: "Message", border: InputBorder.none),
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
  }
}
