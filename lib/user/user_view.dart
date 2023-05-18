// ignore_for_file: avoid_print, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:telegram/user/cubit/user_cubit.dart';
import 'package:telegram/user/cubit/widgets/build_item_user.dart';
import 'package:telegram/user/cubit/widgets/my_drawer.dart';
import 'package:telegram/components/widgets/my_app_bar.dart';
import 'package:telegram/components/widgets/my_text.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<AnimatedListState> animatedKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
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
          //*==================================HomeCubit.get(context).countUsers!.length == 0
          body: UserCubit.get(context).countUsers!.length == 0
              ? const Center(
                  child: MyText(text: "Not found users", color: Colors.black),
                )
              : Column(
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
                              model:
                                  UserCubit.get(context).countUsers![index],
                              // name:
                              //     "${HomeCubit.get(context).userModel!.fName} ${HomeCubit.get(context).userModel!.fName}",
                            ),
                            // ),
                          );
                        },
                        initialItemCount:
                            UserCubit.get(context).countUsers!.length,
                      ),
                    ),
                    // TextButton(
                    //     onPressed: () {
                    //       myShowModealBottomSheet(context, key: animatedKey);

                    //       // HomeCubit.get(context).insertItems(key: animatedKey);
                    //     },
                    //     child: const Text("Add"))
                  ],
                ),

          drawer: const MyDrawer(),
        );
      },
    );
  }
}
