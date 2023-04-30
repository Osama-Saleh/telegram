// ignore_for_file: avoid_print, unnecessary_string_interpolations, sized_box_for_whitespace

import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';
import 'package:telegram/components/app_colors.dart';
import 'package:telegram/view/add_user.dart';
import 'package:telegram/view/chat_view.dart';

import 'package:telegram/widgets/my_text.dart';
import 'package:telegram/widgets/my_text_form_field.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // String? name = "Osama";
  bool? isLast = false;
  var pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics:const NeverScrollableScrollPhysics(),
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
        children:  [ChatView(), AddUser()],
      ),
      //*=============================================
      //* Floating Action Button
      //*=============================================
      floatingActionButton: Container(
        height: 16.h,
        width: 16.w,
        child: FloatingActionButton(
            backgroundColor: AppColor.darkBlue,
            onPressed: () {
              pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
              if (isLast!) {
                print("object");
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.all(3.h),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              text: "New Contact",
                              color: AppColor.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            MyTextFormField(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.sp)),
                              labelText: "First name (required)",
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            MyTextFormField(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.sp)),
                              labelText: "Last name (optional)",
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            MyTextFormField(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.sp)),
                              labelText: "Phone number",
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Container(
                              width: double.infinity,
                              height: 8.h,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: MyText(
                                    text: "Create Contact",
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                  )),
                            )
                          ],
                        ),
                      );
                    });
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
      ),
    );
  }
}
