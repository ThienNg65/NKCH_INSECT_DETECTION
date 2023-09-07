import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  final TextEditingController _searchController = TextEditingController();

  List _allResult = [];
  List _resultList = [];

  @override
  void initState() {
    _searchController.addListener(_onSearchChanged);
    super.initState();
  }

  _onSearchChanged() {
    debugPrint(_searchController.text);
    searchResultList();
  }

  searchResultList() {
    var showResults = [];
    if (_searchController.text != "") {
      for (var userSnapshot in _allResult) {
        var username = userSnapshot['name'].toString().toLowerCase();
        if (username.contains(_searchController.text.toLowerCase())) {
          showResults.add(userSnapshot);
        }
      }
    } else {
      showResults = List.from(_allResult);
    }
    setState(() {
      _resultList = showResults;
    });
  }

  getUserStream() async {
    var data = await FirebaseFirestore.instance
        .collection("Insects")
        .orderBy('name')
        .get();
    setState(() {
      _allResult = data.docs;
    });
    searchResultList();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
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
        appBar: CustomAppbar(
          title: Padding(
            padding: const EdgeInsets.all(10.0),
            child: CupertinoSearchTextField(
              backgroundColor: Colors.grey[200],
              controller: _searchController,
            ),
          ),
        ),
        drawer: const MyDrawer(),
        body: ListView.builder(
          itemCount: _resultList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  InsectPage.route(
                    context,
                    modelId: _resultList[index]['model_id'],
                  ),
                );
              },
              child: ListTile(
                title: Text(_resultList[index]['name']),
                subtitle: Text(_resultList[index]['description']),
                leading: CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 35,
                  backgroundImage: NetworkImage(_resultList[index]['image']),
                ),
                trailing: const Icon(Icons.arrow_forward),
              ),
            );
          },
        ),
      ),
    );
  }
}
