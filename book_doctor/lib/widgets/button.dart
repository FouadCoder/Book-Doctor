
import 'package:flutter/material.dart';
class ClassButton extends StatelessWidget{
  final String textbutton;
  final Color color;
  final VoidCallback onPressed;
  const ClassButton({super.key,
    required this.textbutton ,
    required this.color,
    required this.onPressed,});

  @override
  Widget build(BuildContext context) {
  return Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.02,
              bottom: 5
            ),
            height: 55,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(onPressed: onPressed, 
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              elevation: 2,
              padding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              )
            ),
            child: Text( textbutton , style:  const TextStyle(fontSize: 20 , color: Colors.white),),));
  }

}
