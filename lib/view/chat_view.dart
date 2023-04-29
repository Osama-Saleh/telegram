import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:telegram/components/app_colors.dart';
import 'package:telegram/controller/user_controller.dart';
import 'package:telegram/view/chatting_view.dart';
import 'package:telegram/widgets/build_item_user.dart';
import 'package:telegram/widgets/my_app_bar.dart';
import 'package:telegram/widgets/my_drawer.dart';
import 'package:telegram/widgets/my_text.dart';

class ChatView extends StatelessWidget {
  const ChatView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Telegram",
        onPressed1: () {
          print("Search");
        },
        icon1: Icons.search,
      ),
      //*==================================
      //* list of users that have telegram
      //*==================================
      body: ListView.separated(
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                print(index);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  ChattingView(index: index),
                    ));
              },
              child: BuildItemsUser(
                userModel: UserController.userController[index],
              ),
            );
          },
          separatorBuilder: (context, index) => Container(
                height: .5,
                margin: EdgeInsets.only(left: 8.h),
                color: AppColor.black.withOpacity(.3),
              ),
          itemCount: UserController.userController.length),
      drawer: const MyDrawer(),
    );
  }
}
