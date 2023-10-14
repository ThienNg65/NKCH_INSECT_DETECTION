import 'package:flutter/material.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

class SimilarTaxonomicInsectListView extends StatelessWidget {
  final InsectList insectList;
  const SimilarTaxonomicInsectListView({
    super.key,
    required this.insectList,
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
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: insectList.currentPage.length,
        itemBuilder: (context, index) {
          final insect = insectList.currentPage[index];

          return SimilarTaxonomicInsectListTile(insect: insect);
        },
      ),
    );
  }
}

class SimilarTaxonomicInsectListTile extends StatelessWidget {
  final Insect insect;
  final void Function()? onTap;
  const SimilarTaxonomicInsectListTile({
    super.key,
    required this.insect,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.black,
              radius: 35,
              backgroundImage: insect.photoUrl.isNotEmpty
                  ? NetworkImage(insect.photoUrl)
                  : null,
            ),
            const SizedBox(height: 10),
            Text(
              insect.nomenclature.commonName,
              overflow: TextOverflow.clip,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
