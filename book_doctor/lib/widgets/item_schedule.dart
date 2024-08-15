import 'package:book_dctor/core/colors.dart';
import 'package:book_dctor/widgets/button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ItemSchedule extends StatelessWidget {
  final String name;
  final String category;
  final String day;
  final String hour;
  final String image;
  final VoidCallback cancel;
  final String textbutton;
  final bool isUpcomingTrue;
  final bool isThereDate;
  const ItemSchedule({super.key, required this.name, required this.category, required this.day, required this.hour, required this.cancel, required this.isUpcomingTrue, required this.image, required this.textbutton, required this.isThereDate});

  @override
  Widget build(BuildContext context) {
    final them = Theme.of(context);
    final darkthem = them.brightness == Brightness.dark ;
    return Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: darkthem ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
            BoxShadow(
              color: darkthem ? Colors.white12 : Colors.black12,
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(2, 2)
            ) ,
          ]
              ),
              height: isUpcomingTrue ? 230 : 160, // when it's not upcoming , there no button to cancel so we don't need all this height
              child: Column(
                children: [
                  // ListTile Photo and name 
                  Container(
                    margin: const EdgeInsets.only(top: 5 , bottom: 5),
                    child: ListTile(
                      // photo
                      leading:  SizedBox(
                        height: 50,
                        width: 50,
                        child: ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: image ,
                                    placeholder: (context , url) => const CircularProgressIndicator(color: blueMain),
                                    fit: BoxFit.cover,),
                                ),
                      ),
                      title: Text( name, style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 16),  overflow: TextOverflow.ellipsis,),
                      subtitle: Text(category ,  overflow: TextOverflow.ellipsis,),
                    ),
                ),  // end or ListTile
                // ROW for day and hour 
                const SizedBox(height: 10,),
                isThereDate ?  Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // DAY
                  Row(children: [const Icon(Icons.date_range_outlined , color: blueMain,),const SizedBox(width: 5,) , Text(day)],),
                  // HOUR
                  Row(children: [const Icon(Icons.access_time_outlined , color: blueMain,),const SizedBox(width: 5,) , Text(hour)],)
                ],) : Container(), // END OF ROW 
                // BUTTON TO CANSEL THE DATE
                isUpcomingTrue ? Container(
                  margin: const EdgeInsets.all(10),
                  child: ClassButton(textbutton: textbutton, color: blueMain, onPressed: cancel))
                  : Container()
                ],
              ),
            );        
                
  }
}