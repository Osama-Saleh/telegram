// ignore_for_file: avoid_print, unnecessary_string_interpolations

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:telegram/components/app_colors.dart';
import 'package:telegram/controller/user_controller.dart';
import 'package:telegram/view/add_user.dart';
import 'package:telegram/view/chat_view.dart';
import 'package:telegram/widgets/build_item_user.dart';
import 'package:telegram/widgets/my_drawer.dart';
import 'package:telegram/widgets/my_text.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? name = "Osama";
  bool? isLast = false;
  var pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: PageView(
        controller: pageController,
        onPageChanged: (value) {
          if (value == 1) {
            setState(() {
              isLast = true;
            });
          } else {
            setState(() {
              isLast = false;
            });
          }
        },
        children: [
          ChatView(),
          AddUser()
        ],
      ),
      //*=============================================
      //* Floating Action Button
      //*=============================================
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColor.darkBlue,
          onPressed: () {
            pageController.nextPage(
                duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
            if (isLast!) {
              print("object");
            }
          },
          child: isLast == true
              ? Icon(
                  Icons.person_add_alt_1,
                  size: 20.sp,
                )
              : Icon(
                  Icons.edit,
                  size: 20.sp,
                )),
      
    );
  }
}

