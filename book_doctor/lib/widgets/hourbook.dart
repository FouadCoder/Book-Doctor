import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Hourbook extends StatelessWidget {
  String hours; 
  int index;
  final bool isSelected;
  final Function ontap;
  Hourbook({super.key , required this.hours , required this.index, required this.isSelected, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){ontap(index , hours);},
      child: Container(height: 15, width: 80, 
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: isSelected ? Colors.grey : Colors.blueAccent ,
              borderRadius: BorderRadius.circular(20),
            ),child: Center(child: Text( hours, style: const TextStyle(fontWeight: FontWeight.bold),))),
    );
  }
}