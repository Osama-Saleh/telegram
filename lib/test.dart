// ignore_for_file: file_names, unnecessary_import, implementation_imports, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:sizer/sizer.dart';
import 'package:telegram/components/app_colors.dart';
import 'package:telegram/view/home_view.dart';
import 'package:telegram/widgets/my_divider.dart';
import 'package:telegram/widgets/my_drawer_items.dart';
import 'package:telegram/widgets/my_icon_button.dart';
import 'package:telegram/widgets/my_text.dart';

class TestView extends StatefulWidget {
  TestView({super.key});

  @override
  State<TestView> createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  // var top = 0.0;
  bool isChick = true;
  double? height;
  bool animate = false;

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      animate = true;
    });
  }

  @override
  void initState() {
    startAnimation();
    super.initState();
  }

//!=================================
  double _height = 50.0;
  bool _isExpanded = false;

  Future<bool> _showList() async {
    await Future.delayed(Duration(milliseconds: 900));
    return true;
  }

//!=================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      //*========================================================
      //* (Custom AppBar) apper container if apllication have new version
      //*========================================================
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height ?? 39.7.h),
        child: SafeArea(
          child: AnimatedContainer(
            height: animate ? 300 : 0,
            duration: Duration(milliseconds: 1000),
            curve: Curves.easeIn,
            color: isChick ? AppColor.darkBlue : AppColor.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (isChick)
                  SafeArea(
                    child: AnimatedContainer(
                      height: animate ? 180 : 0,
                      duration: Duration(milliseconds: 850),
                      curve: Curves.easeIn,
                      color: Colors.red,
                      child: Column(
                        children: [
                          //!-----------------------------------------------
                          // isChick
                          //     ? SafeArea(
                          //         child: FutureBuilder(
                          //             future: _showList(),

                          //             /// will wait untill box animation completed
                          //             builder: (context, snapshot) {
                          //               if (!snapshot.hasData) {
                          //                 return SizedBox();
                          //               }
                          //               return Column(
                          //                 children: [
                          //                   Row(
                          //                     mainAxisAlignment:
                          //                         MainAxisAlignment.center,
                          //                     children: [
                          //                       Expanded(
                          //                         child: MyText(
                          //                           text:
                          //                               "Update your Spotify app language",
                          //                           textAlig:
                          //                               TextAlign.center,
                          //                           fontSize: 15.sp,
                          //                           color: AppColor.black,
                          //                         ),
                          //                       ),
                          //                       MyIconButton(
                          //                         icon: Icons.close,
                          //                         onPressed: () {
                          //                           setState(() {
                          //                             isChick = !isChick;
                          //                             height = 9.h;
                          //                           });
                          //                         },
                          //                       )
                          //                     ],
                          //                   ),
                          //                   MyText(
                          //                     text:
                          //                         "You can now set the language of your app, notifications, and other communications from Spotify.",
                          //                     textAlig: TextAlign.center,
                          //                     fontSize: 12.sp,
                          //                     color: AppColor.black,
                          //                   ),
                          //                   SizedBox(
                          //                     height: 5.h,
                          //                   ),
                          //                   Container(
                          //                     // height: animate ? 7.h : 0.h,
                          //                     // duration: Duration(seconds: 2),

                          //                     child: ElevatedButton(
                          //                       onPressed: () {},
                          //                       style:
                          //                           ElevatedButton.styleFrom(
                          //                               shape:
                          //                                   RoundedRectangleBorder(
                          //                                 borderRadius:
                          //                                     BorderRadius
                          //                                         .circular(
                          //                                             30.0),
                          //                               ),
                          //                               backgroundColor:
                          //                                   Colors.white
                          //                                       .withOpacity(
                          //                                           .4)),
                          //                       child: MyText(
                          //                         text: "CONTINUE",
                          //                         textAlig: TextAlign.center,
                          //                         fontSize: 12.sp,
                          //                       ),
                          //                     ),
                          //                   )
                          //                 ],
                          //               );
                          //             }),
                          //       )
                          //     : SizedBox.shrink(),
                          //!-----------------------------------------------------

                          Container(
                            // height: animate ? 30 : 0,
                            // duration: Duration(milliseconds: 6000),
                            // curve: Curves.easeIn,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: MyText(
                                    text: "Update your Spotify app language",
                                    textAlig: TextAlign.center,
                                    fontSize: 15.sp,
                                    color: AppColor.black,
                                  ),
                                ),
                                MyIconButton(
                                  icon: Icons.close,
                                  onPressed: () {
                                    setState(() {
                                      isChick = !isChick;
                                      height = 9.h;
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: MyText(
                              text:
                                  "You can now set the language of your app, notifications, and other communications from Spotify.",
                              textAlig: TextAlign.center,
                              fontSize: 12.sp,
                              color: AppColor.black,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Container(
                            // height: animate ? 7.h : 0.h,
                            // duration: Duration(seconds: 2),

                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  backgroundColor:
                                      Colors.white.withOpacity(.4)),
                              child: MyText(
                                text: "CONTINUE",
                                textAlig: TextAlign.center,
                                fontSize: 12.sp,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                Expanded(
                  child: SafeArea(
                    child: AppBar(
                      title: Text("Done"),
                      centerTitle: true,
                      leading: Icon(Icons.arrow_back),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Center(
              child: Text(
            "data",
            style: TextStyle(fontSize: 25),
          ));
        },
      ),
    );
  }
}
