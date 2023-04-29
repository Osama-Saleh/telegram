import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sizer/sizer.dart';
import 'package:telegram/components/app_colors.dart';
import 'package:telegram/view/chat_view.dart';
import 'package:telegram/widgets/my_app_bar.dart';
import 'package:telegram/widgets/my_drawer_items.dart';

class AddUser extends StatelessWidget {
  const AddUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "New Messge",
        icon1: Icons.search,
        onPressed1: () {
          print("Serach");
        },
        icon2: Icons.sort,
        onPressed2: () {
          print("Sorted");
        },
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatView(),
                  ));
            },
            icon:const Icon(Icons.arrow_back)),
      ),
      body: Container(
        height:32.h,
        color: AppColor.white,
        child: Column(
          children: [
            MyListTitle(
              title: "New Group",
              leading: Icon(Icons.people_outline,size: 25.sp,),
            ),
            MyListTitle(
              title: "New Secret Chat",
              leading: Icon(Icons.lock_outline_rounded,size: 25.sp,),
            ),
            MyListTitle(
              title: "New Channel",
              leading: Icon(Icons.campaign_outlined,size: 25.sp,),
            )
          ],
        ),
      ),
      
    );
  }
}
