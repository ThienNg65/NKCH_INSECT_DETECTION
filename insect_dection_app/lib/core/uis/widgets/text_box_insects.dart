// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';

class MyTextBoxInsect extends StatelessWidget {
  final String label;
  final String content;

  const MyTextBoxInsect({
    super.key,
    required this.label,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.only(top: 15, left: 15, bottom: 15),
      margin: EdgeInsets.only(left: 25, right: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // section name
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 18,
                ),
              ),
            ],
          ),

          const SizedBox(height: 7),

          // text (name, email, etc..)
          Container(
            padding: EdgeInsets.only(right: 10),
            child: Text(
              content,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
                color: Colors.grey[900],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
