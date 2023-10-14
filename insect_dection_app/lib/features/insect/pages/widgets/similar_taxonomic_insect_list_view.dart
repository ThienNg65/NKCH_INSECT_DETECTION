import 'package:flutter/material.dart';

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
      width: 400,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          SimilarTaxonomicInsectListTile(),
          SimilarTaxonomicInsectListTile(),
          SimilarTaxonomicInsectListTile(),
          SimilarTaxonomicInsectListTile(),
          SimilarTaxonomicInsectListTile(),
          SimilarTaxonomicInsectListTile(),
          SimilarTaxonomicInsectListTile(),
          SimilarTaxonomicInsectListTile(),
          SimilarTaxonomicInsectListTile(),
          SimilarTaxonomicInsectListTile(),
          SimilarTaxonomicInsectListTile(),
          SimilarTaxonomicInsectListTile(),
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
  @override
  Widget build(BuildContext context) {
    return Container(
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
            "Naruto Na ",
            overflow: TextOverflow.clip,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
