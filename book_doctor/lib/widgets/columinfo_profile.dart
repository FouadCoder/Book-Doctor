
import 'package:flutter/material.dart';

class ColuminfoProfile extends StatelessWidget {
  final String image;
  final String typeText;
  final String realDate;
  const ColuminfoProfile({super.key, required this.image, required this.typeText, required this.realDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 15,
        right: 15
      ),
      child: Column(
          children: [Container(
          decoration: const BoxDecoration(
        shape: BoxShape.circle
          ),
          child: Image.asset(image, height: 50, width: 50,),
        ),
        Text(typeText , style: const TextStyle(fontWeight: FontWeight.w200),),
        const SizedBox(height: 10,),
        Text(realDate, style: const TextStyle(fontWeight: FontWeight.bold),)
        ],
        ),
    );
  }
}