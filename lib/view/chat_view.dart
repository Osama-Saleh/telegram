// ignore_for_file: avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:telegram/Module/user_model.dart';
import 'package:telegram/controller/user_controller.dart';
import 'package:telegram/state_management/home_cubit.dart';
import 'package:telegram/widgets/build_item_user.dart';
import 'package:telegram/widgets/my_app_bar.dart';
import 'package:telegram/widgets/my_drawer.dart';
import 'package:telegram/widgets/my_show_model.dart';

class ChatView extends StatelessWidget {
  ChatView({
    super.key,
  });
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<AnimatedListState> animatedKey = GlobalKey();
  // void deleteItems({var key, int? index}) {
  //   UserController.userController.removeAt(index!);
  //   // animatedKey.currentState!.removeItem(index!, (context, animation) {
  //   //   Duration(milliseconds: 500);
  //   //   return SizeTransition(
  //   //     sizeFactor: animation,
  //   //     child: BuildItemsUser(index: index),
  //   //   );
  //   // });
  // }

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
              reverse: true,
              itemBuilder: (context, index, animation) {
                return Dismissible(
                  onDismissed: (direction) {
                    UserController.userController.removeAt(index);
                    
                    print(UserController.userController.length);
                  },
                  key: ValueKey(UserController.userController[index]),
                  background: Container(
                    color: Colors.red,
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                  ),
                  child: SlideTransition(
                    position: animation.drive(Tween<Offset>(
                      begin: const Offset(1, 0),
                      end: const Offset(0, 0),
                    )),
                    // sizeFactor: animation,
                    child: BuildItemsUser(
                      index: index,
                      name:
                          "${HomeCubit.get(context).userModel!.fName} ${HomeCubit.get(context).userModel!.fName}",
                    ),
                  ),
                );
              },
              initialItemCount: UserController.userController.length,
            ),
          ),
          TextButton(
              onPressed: () {
                myShowModealBottomSheet(context, key: animatedKey);

                // HomeCubit.get(context).insertItems(key: animatedKey);
              },
              child: Text("Add"))
        ],
      ),
      drawer: const MyDrawer(),
    );
  }
}
