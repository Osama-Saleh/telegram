import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:telegram/components/app_colors.dart';
import 'package:telegram/widgets/my_text.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  const MyAppBar(
      {super.key,
      this.title,
      this.onPressed1,
      this.onPressed2,
      this.icon1,
      this.icon2,
      this.leading,
      });
  final String? title;
  final Function()? onPressed1;
  final Function()? onPressed2;
  final IconData? icon1;
  final IconData? icon2;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.darkBlue,
      title: MyText(
        text: title,
        fontSize: 20.sp,
      ),
      centerTitle: false,
      actions: [
        IconButton(
            onPressed: onPressed1,
            icon: Icon(
              icon1,
              color: AppColor.white,
              size: 22.sp,
            )),
        if (icon2 != null)
          IconButton(
              onPressed: onPressed2,
              icon: Icon(
                icon2,
                color: AppColor.white,
                size: 22.sp,
              ))
      ],
      
      leading: leading,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(10.h);
}
