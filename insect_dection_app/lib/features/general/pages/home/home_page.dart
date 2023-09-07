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
  void goToInsectPage(Insect insects) {
    Navigator.of(context).push(
      InsectPage.route(
        context,
        modelId: insects.modelId,
      ),
    );
  }

  List insects = [];

  getUserStream() async {
    var data = await FirebaseFirestore.instance
        .collection("insects")
        .orderBy('modelId')
        .limit(11)
        .get();
    setState(() {
      insects = data.docs
          .map<Insect>((e) => InsectModel.fromMap(e.data()).toEntity())
          .toList();
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
                itemCount: insects.length,
                itemBuilder: (context, index) {
                  //create a insect
                  final insect = insects[index];
                  return InsectTile(
                    insect: insect,
                    onTap: () => goToInsectPage(insect),
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
  }
}
