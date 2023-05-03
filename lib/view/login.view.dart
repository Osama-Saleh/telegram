// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:telegram/components/app_colors.dart';
import 'package:telegram/state_management/cubit_states.dart';
import 'package:telegram/state_management/home_cubit.dart';
import 'package:telegram/widgets/my_elevated_button.dart';
import 'package:telegram/widgets/my_text.dart';
import 'package:telegram/widgets/my_text_form_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController mailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is SignUpSuccessState) {
          Fluttertoast.showToast(
              msg: "Login Success",
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: Colors.green);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.h),
            child: Form(
              key: formKey,
              child: Align(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  physics:const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: MyText(
                          text: "Login",
                          fontSize: 35.sp,
                          color: AppColor.black,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      MyText(
                        text: "Email",
                        fontSize: 15.sp,
                        color: AppColor.black,
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
                        height: 2.h,
                      ),
                      MyText(
                        text: "Password",
                        fontSize: 15.sp,
                        color: AppColor.black,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      MyTextFormField(
                        controller: passwordController,
                        hintText: "Password",
                        obscureText: cubit.showPassword,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        suffixIcon: IconButton(
                            onPressed: () {
                              cubit.changePasswordVisibility();
                            },
                            icon: Icon(cubit.suffix)),
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
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 30.w,
                          height: 8.h,
                          child: MyElevatedButton(
                            text: "Log In",
                            border: 10,
                            onPressed: () {
                              cubit.signUp(
                                  mail: mailController.text,
                                  password: passwordController.text,
                                  );
                              if (formKey.currentState!.validate()) {}
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
