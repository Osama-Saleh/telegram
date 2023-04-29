import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sizer/sizer.dart';
import 'package:telegram/components/app_colors.dart';
import 'package:telegram/controller/user_controller.dart';
import 'package:telegram/widgets/my_app_bar.dart';
import 'package:telegram/widgets/my_text.dart';

class ChattingView extends StatelessWidget {
  const ChattingView({super.key,this.index});

 final int? index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.darkBlue,
        centerTitle: false,
        title: Row(

          children: [
            Container(
          height: 15.h,
          width: 15.w,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
          child: UserController.userController[index!].image!.isEmpty
              ? Center(
                  child: Text(
                  "${UserController.userController[index!].name![0]}${UserController.userController[index!].name![1]}",
                  style: TextStyle(color: AppColor.white),
                ))
              : Image(
                  image: NetworkImage(
                      "${UserController.userController[index!].image}"),
                  fit: BoxFit.cover,
                ),
        ),
        SizedBox(width: 3.w,),
            MyText(text: "${UserController.userController[index!].name}",fontSize: 15.sp,),
            
          ],
        ),
      ),
      
      
    );
  }
}
