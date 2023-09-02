import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  // User
  final currentUser = FirebaseAuth.instance.currentUser!;

  // user selected a insects, go to the insect page
  void goToInsectPage(UIInsects insects) {
    Navigator.of(context).push(
      InsectPage.route(
        context,
        currentUserId: currentUser.uid,
        modelId: insects.name,
      ),
    );
  }

  List categories = [
    "Library",
    "Starred",
    "Recently",
  ];

  List insectsLibrary = [];
  List starredInsects = [];
  List recentlySearchedInsects = [];

  getInsectsLibrary() async {
    var data = await FirebaseFirestore.instance
        .collection("Insects")
        .orderBy('name')
        .get();
    setState(() {
      insectsLibrary = data.docs;
    });
  }

  getStarredInsects() async {
    var data = await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser.email)
        .collection('favorites')
        .get();
    setState(() {
      starredInsects = data.docs;
    });
  }

  getRecentlySearchedInsects() async {
    var data = await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser.email)
        .collection('RecentlySearched')
        .get();
    setState(() {
      recentlySearchedInsects = data.docs;
    });
  }

  @override
  void didChangeDependencies() {
    getInsectsLibrary();
    getStarredInsects();
    getRecentlySearchedInsects();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: const CustomAppbar(),
        drawer: const MyDrawer(),
        backgroundColor: Colors.grey[300],
        body: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 25.0, right: 25.0, bottom: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Library",
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: starredInsects.length,
                itemBuilder: (context, index) {
                  //create a insect
                  UIInsects insects = UIInsects(
                    id: starredInsects[index]['model_id'],
                    name: starredInsects[index]['nomenclature']['common_name'],
                    description: starredInsects[index]
                        ['identification_features'],
                  );
                  //Insects insects = recentlySearchedInsects[index];
                  return InsectTile(
                    insects: insects,
                    onTap: () => goToInsectPage(insects),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
