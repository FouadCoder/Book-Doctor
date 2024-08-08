import 'package:book_dctor/core/colors.dart';
import 'package:flutter/material.dart';

class ChooseDateChild extends StatelessWidget {
  final String titie;
  const ChooseDateChild({super.key ,required this.titie});

  @override
  Widget build(BuildContext context) {
    return Container(
                  margin: const EdgeInsets.only(
                    top: 15,
                    bottom: 5
                  ),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: blueMain,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(child: Text(titie , style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 20),)));
  }
}