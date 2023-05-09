// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:telegram/components/app_colors.dart';
import 'package:telegram/components/const.dart';
import 'package:telegram/controller/local_storage/hive.dart';
import 'package:telegram/login/cubit/login_cubit.dart';
import 'package:telegram/state_management/cubit_states.dart';
import 'package:telegram/state_management/home_cubit.dart';
import 'package:telegram/home/home_view.dart';
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
  late Box myBox;

  @override
  Widget build(BuildContext context) {
    var cubit = LoginCubit.get(context);

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LoginSuccessState) {
          // HiveHelper.boxName = "userData";
          await HiveHelper.openBox(nameBox: "userData");
          await HiveHelper.setData(key: "userToken", value: "${state.token}")
              .whenComplete(() {
            MyConst.uidUser = HiveHelper.getData(key: "userToken");
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeView(),
                ));
            print(
                "haha 1 : ${MyConst.uidUser} hahah 2 ${HiveHelper.getData(key: "userToken")}");
          });
          //!----------------------------------------------------------------
          //   myBox = Hive.box("myBox");

          // await  myBox.put("token", "${state.token}").whenComplete(() {
          //     print('hahahah');
          //     MyConst.uidUser = myBox.get("token");
          //       print('radwan => ${myBox.get("token")}  radwan2 => ${MyConst.uidUser}');
          //   });

          //!----------------------------------------------------------------
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
                  physics: const BouncingScrollPhysics(),
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
                              cubit.login(
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
