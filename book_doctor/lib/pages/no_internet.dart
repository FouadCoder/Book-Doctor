
import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body:  Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Image.asset("assets/internet.png" , height: 100, width: 100,),),
                const SizedBox(height: 20,),
                const Text( "Oops! We can't connect right now. Please check your internet and try again." , style: TextStyle(fontWeight: FontWeight.bold), )
              ],
            ),
          ),
          ),
        );
  }
}