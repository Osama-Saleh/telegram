// ignore_for_file: avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:telegram/Module/user_model.dart';
import 'package:telegram/controller/user_controller.dart';
import 'package:telegram/widgets/build_item_user.dart';
import 'package:telegram/widgets/my_app_bar.dart';
import 'package:telegram/widgets/my_drawer.dart';

class ChatView extends StatelessWidget {
  ChatView({
    super.key,
  });
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<AnimatedListState> animatedKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: MyAppBar(
        title: "Telegram",
        onPressed1: () {
          print("Search");
        },
        icon1: Icons.search,
        leading: IconButton(
            onPressed: () {
              scaffoldKey.currentState!.openDrawer();
            },
            icon: Icon(
              Icons.menu,
              size: 20.sp,
            )),
      ),
      //*==================================
      //* list of users that have telegram
      //*==================================
      body: Column(
        children: [
          Expanded(
            child: AnimatedList(
              key: animatedKey,
              itemBuilder: (context, index, animation) {
                return Dismissible(
                  onDismissed: (direction) {
                    print("removed");
                  },
                  key: ValueKey(UserController.userController[index]),
                  background: Container(
                    color: Colors.red,
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                  ),
                  child: SizeTransition(
                    sizeFactor: animation,
                    child: BuildItemsUser(
                      userModel: UserController.userController[index],
                      index: index,
                    ),
                  ),
                );
              },
              initialItemCount: UserController.userController.length,
            ),
          ),
          TextButton(
              onPressed: () {
                insertItems();
              },
              child: Text("Add"))
        ],
      ),
      drawer: const MyDrawer(),
    );
  }

  void insertItems() {
    var index = UserController.userController.length;
    UserController.userController
        .addAll([UserController.userController[index - 1]]);
    animatedKey.currentState!.insertItem(index);
  }
}
