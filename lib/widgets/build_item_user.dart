import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:telegram/Module/user_model.dart';
import 'package:telegram/components/app_colors.dart';
import 'package:telegram/controller/user_controller.dart';
import 'package:telegram/widgets/my_text.dart';

class BuildItemsUser extends StatelessWidget {
  const BuildItemsUser({
    super.key,
    this.userModel,
  });
 final UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Container(
          height: 15.h,
          width: 15.w,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
          child: userModel!.image!.isEmpty
              ? Center(
                  child:MyText(text: "${userModel!.name![0]}${userModel!.name![1]}",
                  color: AppColor.white,
                  fontSize: 20.sp,
                  ),
              )
              : Image(
                  image: NetworkImage(
                      "${userModel!.image}"),
                  fit: BoxFit.cover,
                  height: 15.h,
                  width: 15.w,
                ),
        ),
        title: MyText(
          text: "${userModel!.name}",
          fontSize: 15.sp,
        ),
        subtitle:  MyText(
          text: "Message",
          fontSize: 15.sp,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: MyText(text: "2:55 PM",fontSize: 10.sp,)),
           
            Expanded(
              child: Container(
                height: 4.h,
                width: 12.w,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20.sp)),
                child: Center(
                    child: MyText(
                  text: "5324",
                  color: AppColor.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 10.sp,
                )),
              ),
            )
          ],
        ));
  }
}
