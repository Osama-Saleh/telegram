// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyTextFormField extends StatelessWidget {
  MyTextFormField({
    super.key,
    this.hintText,
    this.labelText,
    this.border,
    this.validator,
    this.controller,
    this.obscureText,
    this.suffixIcon,
  });
  final String? hintText;
  final InputBorder? border;
  final String? labelText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  final Widget? suffixIcon;
  bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(fontSize: 15.sp),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 15.sp),
          border: border,
          contentPadding: EdgeInsets.all(3.h),
          suffixIcon: suffixIcon),
      validator: validator,
      obscureText: obscureText ?? false,
    );
  }
}
