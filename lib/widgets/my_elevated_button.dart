import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:telegram/widgets/my_text.dart';

class MyElevatedButton extends StatelessWidget {
   MyElevatedButton({
    super.key,
    this.text,
    this.onPressed,
    this.border
  });
  final String? text;
  final Function()? onPressed;
   double? border;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(border??0),
        )),
        child: MyText(
          text: text,
          fontSize: 15.sp,
        ));
  }
}
