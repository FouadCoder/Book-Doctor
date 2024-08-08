import 'package:book_dctor/core/colors.dart';
import 'package:flutter/material.dart';

class TotalAdmin extends StatelessWidget {
  final String firstText;
  final String numberOf;
  const TotalAdmin({super.key, required this.firstText, required this.numberOf});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text(firstText , style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 20 , color: blueMain),),
                  Text( numberOf, style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 25), overflow: TextOverflow.ellipsis,),
                ],),
    );
  }
}