// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:insect_dection_app/features/insect/pages/widgets/bookmark_button.dart';

import '../../domain/entities/insect_entity_ui.dart';

class InsectPage extends StatefulWidget {
  final UIInsects insects;
  const InsectPage({super.key, required this.insects});

  @override
  State<InsectPage> createState() => _InsectPageState();
}

class _InsectPageState extends State<InsectPage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isBookmarked = false;

  // toggle love
  Future toggleLove() async {
    // // Get shared preferences
    // final SharedPreferences prefs = await SharedPreferences.getInstance();

    // // Get the current love status
    // bool isLoved = prefs.getBool("isLoved") ?? false;

    // Add or remove insect from favorites
    if (!isBookmarked) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(currentUser.email)
          .collection("favorites")
          .doc(widget.insects.name)
          .set({
        "name": widget.insects.name,
        "image": widget.insects.image,
        "description": widget.insects.description,
        "timestamp": DateTime.now().millisecondsSinceEpoch,
      });

      // // Save the love status to shared preferences
      // prefs.setBool("isLoved", true);
    } else {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(currentUser.email)
          .collection("favorites")
          .doc(widget.insects.name)
          .delete();

      // Save the love status to shared preferences
      // prefs.setBool("isLoved", false);
    }

    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.insects.name,
          style: TextStyle(color: Colors.grey[800]),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: BookmarkButton(
              onTap: toggleLove,
              isBookmarked: isBookmarked,
            ),
          ),
        ],
        iconTheme: IconThemeData(color: Colors.grey[800]),
      ),
      backgroundColor: Colors.grey[300],
      body: ListView(
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(height: 5),
                // insect image
                Center(
                  child: Image.network(
                    widget.insects.image,
                    fit: BoxFit.fill,
                  ),
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // insect name
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 25.0, left: 30.0, right: 25.0, bottom: 10.0),
                      child: Text(
                        widget.insects.name,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // Scientific Name
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 25.0),
                      child: Text(
                        "Scientific Name",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),

                    // Description Container (details...)
                    Container(
                      height: 300,
                      width: 500,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.only(left: 15, bottom: 15, top: 15),
                      margin: EdgeInsets.only(left: 25, right: 25, top: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Description",
                            style: TextStyle(color: Colors.grey[500]),
                          ),

                          const SizedBox(height: 5),

                          // text (name, email, etc..)
                          Text(
                            widget.insects.description,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
