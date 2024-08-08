

import 'package:book_dctor/core/colors.dart';
import 'package:book_dctor/generated/l10n.dart';
import 'package:book_dctor/widgets/button.dart';
import 'package:flutter/material.dart';

class ChooseCAMAREORGALLRAY extends StatefulWidget {
final VoidCallback galleryVoid;
final VoidCallback camaraVoid;
  const ChooseCAMAREORGALLRAY({super.key, required this.galleryVoid, required this.camaraVoid});

  @override
  State<ChooseCAMAREORGALLRAY> createState() => _ChooseCAMAREORGALLRAYState();
}

class _ChooseCAMAREORGALLRAYState extends State<ChooseCAMAREORGALLRAY> {



  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(
      topLeft:Radius.circular(20),
      topRight: Radius.circular(20),
        )
        ),
      height: 220 ,
      width: MediaQuery.of(context).size.width,
      // Child For all sheet
    child: Column(
      children: [
        // Text New Profile Picture
        Container(
          margin: const EdgeInsets.all(10),
          child:  Text(S.of(context).NewPorfilePicture, style: const TextStyle(fontSize: 17 , fontWeight: FontWeight.bold),)),
        // Button to take photo from gallery
        ClassButton(textbutton: S.of(context).Gallrey,color:  blueMain,onPressed: widget.galleryVoid),
        // Button to take photo from Camara 
        ClassButton(textbutton: S.of(context).Camara, color: blueMain , onPressed: widget.camaraVoid)
      ],
    ));
  }
}