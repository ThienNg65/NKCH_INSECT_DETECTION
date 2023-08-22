import 'package:flutter/material.dart';
import 'package:insect_dection_app/core/core.dart';

class RecentSearchPage extends StatefulWidget {
  const RecentSearchPage({super.key});

  @override
  State<RecentSearchPage> createState() => _RecentSearchPageState();
}

class _RecentSearchPageState extends State<RecentSearchPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppbar(),
      drawer: MyDrawer(),
      body: Center(child: Text('Recently Search')),
    );
  }
}
