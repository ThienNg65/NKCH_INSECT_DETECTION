import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

import '../../../user/pages/get_user_name.dart';



// ignore: camel_case_types
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// ignore: camel_case_types
class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  // document IDs
  List<String> docID = [];

  // get the docIDs
  Future getDocId() async {
    await FirebaseFirestore.instance.collection('user').get().then(
          // ignore: avoid_function_literals_in_foreach_calls
          (snapshot) => snapshot.docs.forEach((document) {
            // print(document.reference);
            docID.add(document.reference.id);
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          user.email!,
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
              child: const Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FutureBuilder(
                future: getDocId(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: docID.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          tileColor: Colors.grey[200],
                          title: GetUserName(documentId: docID[index]),
                        ),
                      );
                    },
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
