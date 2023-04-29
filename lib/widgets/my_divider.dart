import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({
    super.key,
    this.height,
    this.color
  });
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 0.1.h,
      color: color ?? Colors.grey,
      // margin: EdgeInsets.only(left: 5.h),
    );
  }
}
