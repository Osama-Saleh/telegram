// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:telegram/components/app_colors.dart';
import 'package:telegram/state_management/cubit_states.dart';
import 'package:telegram/state_management/home_cubit.dart';
import 'package:telegram/view/chat_view.dart';
import 'package:telegram/view/home_view.dart';
import 'package:telegram/widgets/my_app_bar.dart';
import 'package:telegram/widgets/my_drawer_items.dart';

class AddUser extends StatelessWidget {
  const AddUser({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: MyAppBar(
            title: "New Messge",
            icon1: Icons.search,
            onPressed1: () {
              print("Search");
            },
            icon2: Icons.sort,
            onPressed2: () {
              print("Sorted");
            },
            leading: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeView(),
                      ));
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 20.sp,
                )),
          ),
          body: Container(
            height: 32.h,
            color: AppColor.white,
            child: Column(
              children: [
                MyListTitle(
                  title: "New Group",
                  leading: Icon(
                    Icons.people_outline,
                    size: 20.sp,
                  ),
                ),
                MyListTitle(
                  title: "New Secret Chat",
                  leading: Icon(
                    Icons.lock_outline_rounded,
                    size: 20.sp,
                  ),
                ),
                MyListTitle(
                  title:"New Channel",
                  leading: Icon(
                    Icons.campaign_outlined,
                    size: 20.sp,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}