// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

class InsectTile extends StatelessWidget {
  final Insect insect;
  final void Function()? onTap;
  const InsectTile({
    super.key,
    required this.insect,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.only(bottom: 15, right: 20, left: 20),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: ListTile(
          key: key,
          isThreeLine: false,
          title: Text(insect.nomenclature.commonName),
          subtitle: Text(insect.nomenclature.otherName),
          leading: CircleAvatar(
            backgroundColor: Colors.black,
            radius: 35,
            backgroundImage: insect.photoUrl.isNotEmpty
                ? NetworkImage(insect.photoUrl)
                : null,
          ),
          trailing: const Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}
