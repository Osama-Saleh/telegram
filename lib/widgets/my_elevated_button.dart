import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:telegram/widgets/my_text.dart';

class MyElevatedButton extends StatelessWidget {
  const MyElevatedButton({
    super.key,
    this.text,
  });
  final String? text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          // shape: ou
        ),
        child: MyText(
          text: text,
          fontSize: 15.sp,
        ));
  }
}
