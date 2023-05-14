// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:telegram/components/app_colors.dart';
import 'package:telegram/register/cubit/register_cubit.dart';
import 'package:telegram/login/login.view.dart';
import 'package:telegram/components/widgets/my_elevated_button.dart';
import 'package:telegram/components/widgets/my_text.dart';
import 'package:telegram/components/widgets/my_text_form_field.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController nameController = TextEditingController();

  TextEditingController mailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cubit = RegisterCubit.get(context);
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          Fluttertoast.showToast(
                  msg: "Register Success",
                  toastLength: Toast.LENGTH_SHORT,
                  backgroundColor: Colors.green)
              .whenComplete(() {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginView(),
                ));
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
              child: Padding(
            padding: EdgeInsets.only(top: 8.h, left: 5.h, right: 5.h),
            child: Form(
              key: formKey,
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
                      color: AppColor.black,
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
                      height: 2.h,
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
                          icon: Icon(cubit.suffix)
                          ),
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
                    Container(
                      width: double.infinity,
                      child: MyElevatedButton(
                        text: "Sign Up",
                        onPressed: () {
                          cubit.register(
                            name: nameController.text,
                            mail: mailController.text,
                            password: passwordController.text,
                          );
                          if (formKey.currentState!.validate()) {}
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyText(
                          text: "Have an account",
                          fontSize: 12.sp,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginView(),
                                  ));
                            },
                            child: MyText(
                              text: "Login",
                              fontSize: 12.sp,
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          )),
        );
      },
    );
  }
}
