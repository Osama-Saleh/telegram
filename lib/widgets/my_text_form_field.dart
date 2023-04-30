import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({super.key, this.hintText,this.labelText,this.border});
  final String? hintText;
  final InputBorder? border;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(fontSize: 15.sp),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 15.sp),
          contentPadding: EdgeInsets.all(3.h),
          border: border,
          ),
    );
  }
}
