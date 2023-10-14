import 'package:flutter/material.dart';

import '../../insect.dart';

class SimilarTaxonomicInsectListView extends StatelessWidget {
  const SimilarTaxonomicInsectListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(15.0),
      margin: const EdgeInsets.all(20.0),
      height: 170,
      width: double.infinity,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          SimilarTaxonomicInsectListTile(),
          SimilarTaxonomicInsectListTile(),
          SimilarTaxonomicInsectListTile(),
          SimilarTaxonomicInsectListTile(),
        ],
      ),
    );
  }
}

class SimilarTaxonomicInsectListTile extends StatelessWidget {
  // final Insect insect;
  final void Function()? onTap;
  const SimilarTaxonomicInsectListTile({
    super.key,
    // required this.insect,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(10.0),
        child: const Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.black,
              radius: 35,
              // backgroundImage: insect.photoUrl.isNotEmpty
              //     ? NetworkImage(insect.photoUrl)
              //     : null,
            ),
            SizedBox(height: 10),
            Text(
              "Hello",
              overflow: TextOverflow.clip,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
