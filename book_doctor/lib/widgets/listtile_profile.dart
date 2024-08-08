
import 'package:book_dctor/core/colors.dart';
import 'package:flutter/material.dart';

class TileProfile extends StatelessWidget {
  final Icon leading;
  final String text;
  final Function()? onTap;
  const TileProfile({super.key, required this.leading, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: GestureDetector(
                  onTap: onTap,
                  child: ListTile(
                    leading: leading , iconColor: blueMain,
                    title: Text(text),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded ,),
                  ),
                ),
    );
  }
}