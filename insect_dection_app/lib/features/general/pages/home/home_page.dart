import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // User
  final currentUser = FirebaseAuth.instance.currentUser!;

  // all user
  final usersCollection = FirebaseFirestore.instance.collection("Users");

  // text controller
  final TextEditingController textController = TextEditingController();

  // to the RecentPage page
  void goToRecentSearchPage() {
    // pop menu drawer
    Navigator.pop(context);

    // go to the profile page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RecentSearchPage(),
      ),
    );
  }

  // user selected a insects, go to the insect page
  void goToInsectPage(UIInsects insects) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InsectPage(
          insects: insects,
        ),
      ),
    );
  }

  List _allResult = [];

  getUserStream() async {
    var data = await FirebaseFirestore.instance
        .collection("Insects")
        .orderBy('name')
        .get();
    setState(() {
      _allResult = data.docs;
    });
  }

  @override
  void didChangeDependencies() {
    getUserStream();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                    "Recently Search",
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Text(
                    "See All",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _allResult.length,
                itemBuilder: (context, index) {
                  //create a insect
                  UIInsects insects = UIInsects(
                    name: _allResult[index]['name'],
                    image: _allResult[index]['image'],
                    description: _allResult[index]['description'],
                  );
                  //Insects insects = recentlySearchedInsects[index];
                  return InsectTile(
                    insects: insects,
                    onTap: () => goToInsectPage(insects),
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15.0, left: 25.0, right: 25.0),
              child: Divider(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
    // // Recently Search Box
    // Expanded(
    //   child: ListView.builder(
    //     itemCount: 4,
    //     scrollDirection: Axis.horizontal,
    //     itemBuilder: (context, index) {
    //       //create a insect
    //       Insects insects = Insects(
    //           name: "Brown",
    //           imagePath: "assets/images/browns_tails.jpg",
    //           description: "Looks Brown");
    //       //Insects insects = recentlySearchedInsects[index];
    //       return InsectTile(
    //         insects: insects,
    //       );
    //     },
    //   ),
    // ),

    // Padding(
    //   padding: const EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
    //   child: Divider(
    //     color: Colors.white,
    //   ),
    // ),
  }
}
