// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:telegram/components/app_colors.dart';
import 'package:telegram/state_management/cubit_states.dart';
import 'package:telegram/state_management/home_cubit.dart';
import 'package:telegram/widgets/my_elevated_button.dart';
import 'package:telegram/widgets/my_text.dart';
import 'package:telegram/widgets/my_text_form_field.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
              child: Padding(
            padding: EdgeInsets.only(top: 8.h, left: 5.h, right: 5.h),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: "Get Started",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  MyText(
                    text: "Create your account now",
                    fontSize: 15.sp,
                    color: AppColor.black.withOpacity(.5),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  MyText(
                    text: "Full name",
                    fontSize: 15.sp,
                    color: AppColor.black.withOpacity(.5),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  MyTextFormField(
                    controller: nameController,
                    hintText: "Enter Your Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "faild";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  MyText(
                    text: "Email",
                    fontSize: 15.sp,
                    color: AppColor.black.withOpacity(.5),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  MyTextFormField(
                    controller: mailController,
                    hintText: "Enter Your Mail",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "faild";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  MyText(
                    text: "Password",
                    fontSize: 15.sp,
                    color: AppColor.black.withOpacity(.5),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  MyTextFormField(
                    hintText: "Password",
                    obscureText: cubit.isVisibel,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    suffixIcon: IconButton(
                        onPressed: () {
                          cubit.showPassword();
                        },
                        icon: Icon(cubit.iconData)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "faild";
                      }
                      return null;
                    },
                  ),
                  Container(
                    width: double.infinity,
                    child: MyElevatedButton(text: "Sign Up"),
                  )
                ],
              ),
            ),
          )),
        );
      },
    );
  }
}

