import 'package:flutter/material.dart';
import 'package:insect_dection_app/core/core.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, this.color, this.onTap});

  final String text;
  final Color? color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.orange,
        width: 100,
        height: 50,
        child: Center(
          child: ReusableText(
            text: text,
            style: appstyle(16, color ?? Colors.lightBlue, FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
