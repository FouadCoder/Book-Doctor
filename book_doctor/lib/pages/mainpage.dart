
import 'package:book_dctor/pages/chat.dart';
import 'package:book_dctor/pages/home.dart';
import 'package:book_dctor/pages/profile.dart';
import 'package:book_dctor/pages/schedule.dart';
import 'package:book_dctor/widgets/svg.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int indexBottomNavigationBar = 0;
  // void for BottomNavigationBar
  void onTap (int index){
    setState(() {
      if(index == 2){
        Navigator.of(context).pushNamed("Chat");
      } else{
      indexBottomNavigationBar = index;
      }
      
    });
  }
  // List for pages 
    final List<Widget> pages = [
      const Home(),
      const Schedule(),
      const Chat(),
      const Profile(),
    ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexBottomNavigationBar,
        onTap: onTap,
        items: [
          // Home
          BottomNavigationBarItem(icon: SizedBox( height: 30, width: 30, child: ColorableSvg(svgAsset: "assets/home1.svg" ,
          isSelected: indexBottomNavigationBar == 0 )), label: ""),
          // shedule
          BottomNavigationBarItem(icon: SizedBox( height: 30, width: 30, child: ColorableSvg(svgAsset: "assets/shedule.svg" ,
          isSelected: indexBottomNavigationBar == 1)), label: ""),
          // messsage
          BottomNavigationBarItem(icon: SizedBox( height: 30, width: 30, child: ColorableSvg(svgAsset: "assets/message.svg" ,
          isSelected: indexBottomNavigationBar == 2)), label: ""),
          // Profile
          BottomNavigationBarItem(icon: SizedBox( height: 30, width: 30, child: ColorableSvg(svgAsset: "assets/person.svg" ,
          isSelected: indexBottomNavigationBar == 3 ,)), label: "")
        ],
      ) ,
      body: pages[indexBottomNavigationBar],
    );
  }
}