import 'package:flutter/material.dart';
import 'package:insect_dection_app/views/drawer/app_style.dart';

import 'package:insect_dection_app/views/drawer/reusable_text.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, this.text, required this.child, this.actions});

  final String? text;
  final Widget child;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(),
      backgroundColor: Colors.blueGrey,
      elevation: 0,
      automaticallyImplyLeading: false,
      leadingWidth: 70,
      leading: child,
      actions: actions,
      centerTitle: true,
      title: ReusableText(
        text: text ?? "",
        style: appstyle(16, Colors.black, FontWeight.w600),
      ),
    );
  }
}
