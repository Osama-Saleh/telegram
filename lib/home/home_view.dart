// ignore_for_file: avoid_print, unnecessary_string_interpolations, sized_box_for_whitespace

import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';
import 'package:telegram/Module/user_model.dart';
import 'package:telegram/components/app_colors.dart';
import 'package:telegram/user/user_view.dart';
import 'package:telegram/view/add_user.dart';
import 'package:telegram/components/widgets/my_show_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  GlobalKey<AnimatedListState> animatedKey = GlobalKey();

  bool? isLast = false;
  var pageController = PageController();
  UserModel? userModel = UserModel();

  @override
  Widget build(BuildContext contextt) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) {
          if (value == 1) {
            print(value);
            setState(() {
              isLast = true;
            });
          } else {
            setState(() {
              isLast = false;
            });
          }
          print(isLast);
        },
        children: const [UserView(),  AddUser()],
      ),
      //*=============================================
      //* Floating Action Button
      //*=============================================
      floatingActionButton: Container(
        height: 9.h,
        width: 12.w,
        child: FloatingActionButton(
            backgroundColor: AppColor.darkBlue,
            onPressed: () {
              pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
              if (isLast!) {
                print("object");
                myShowModealBottomSheet(context);
              }
            },
            shape: const BeveledRectangleBorder(),
            child: isLast == true
                ? Icon(
                    Icons.person_add_alt_1,
                    size: 20.sp,
                  )
                : Icon(
                    Icons.edit,
                    size: 20.sp,
                  )),
      ),
    );
  }
}
