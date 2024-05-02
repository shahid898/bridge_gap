import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color? color;
  final void Function()? onPressed;

  const CustomButton(
      {super.key, required this.text, this.color, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(color ?? Colors.black),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              // side: const BorderSide(width: 2, color: AppColor.blackColor),

              // Adjust the radius as needed
            ),
          ),
        ),
        onPressed: () {
          onPressed!();
        },
        child: SizedBox(
          height: 25.h,
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
          ),
        ));
  }
}
