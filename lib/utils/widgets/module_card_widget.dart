import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ModuleCardWidget extends StatelessWidget {
  const ModuleCardWidget({super.key, this.title, this.onTap, this.image});

  final String? title;
  final VoidCallback? onTap;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          height: 290.h,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              color: const Color(0xff161617),
              borderRadius: BorderRadius.circular(25)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 210.h,
                child: Image.asset(
                  image!,
                  scale: 1.4,
                ),
              ),

              Text(
                title??"",
                style: TextStyle(fontSize: 22.sp, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
