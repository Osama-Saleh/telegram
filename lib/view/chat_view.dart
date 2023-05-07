// ignore_for_file: avoid_print, must_be_immutable, prefer_is_empty, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:telegram/state_management/cubit_states.dart';
import 'package:telegram/state_management/home_cubit.dart';
import 'package:telegram/widgets/build_item_user.dart';
import 'package:telegram/widgets/my_app_bar.dart';
import 'package:telegram/widgets/my_drawer.dart';
import 'package:telegram/widgets/my_show_model.dart';
import 'package:telegram/widgets/my_text.dart';

class ChatView extends StatefulWidget {
  ChatView({
    super.key,
  });

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<AnimatedListState> animatedKey = GlobalKey();
  // @override
  // void setState(VoidCallback fn) {
  //   super.setState(fn);
  //   HomeCubit.get(context).getAllUser();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
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
          //* list of users that have Application
          //*==================================
          body: HomeCubit.get(context).countUsers!.length == 0
              ? const Center(
                  child: MyText(text: "Not found users", color: Colors.black),
                )
              :  Column(
                      children: [
                        Expanded(
                          child: AnimatedList(
                            key: animatedKey,
                            physics: const BouncingScrollPhysics(),
                            // reverse: true,
                            itemBuilder: (context, index, animation) {
                              return
                                  // Dismissible(
                                  //   onDismissed: (direction) {
                                  //     UserController.userController.removeAt(index);

                                  //     print(UserController.userController.length);
                                  //   },
                                  //   key: ValueKey(HomeCubit.get(context).countUsers![index]),
                                  //   background: Container(
                                  //     color: Colors.red,
                                  //   ),
                                  //   secondaryBackground: Container(
                                  //     color: Colors.red,
                                  //   ),
                                  //   child:
                                  SlideTransition(
                                position: animation.drive(Tween<Offset>(
                                  begin: const Offset(1, 0),
                                  end: const Offset(0, 0),
                                )),
                                // sizeFactor: animation,
                                child: BuildItemsUser(
                                  model: HomeCubit.get(context).countUsers![index],
                                  // name:
                                  //     "${HomeCubit.get(context).userModel!.fName} ${HomeCubit.get(context).userModel!.fName}",
                                ),
                                // ),
                              );
                            },
                            initialItemCount:
                                HomeCubit.get(context).countUsers!.length,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              myShowModealBottomSheet(context,
                                  key: animatedKey);

                              // HomeCubit.get(context).insertItems(key: animatedKey);
                            },
                            child: Text("Add"))
                      ],
                    ),
                 
          drawer: const MyDrawer(),
        );
      },
    );
  }
}
