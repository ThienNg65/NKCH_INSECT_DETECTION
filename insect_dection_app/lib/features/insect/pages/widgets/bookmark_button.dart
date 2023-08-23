import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BookmarkButton extends StatelessWidget {
  final bool isBookmarked;
  void Function()? onTap;
  BookmarkButton({super.key, required this.onTap, required this.isBookmarked});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        isBookmarked ? Icons.bookmark : Icons.bookmark_border,
        color: isBookmarked ? Colors.yellowAccent : Colors.grey[600],
      ),
    );
  }
}
