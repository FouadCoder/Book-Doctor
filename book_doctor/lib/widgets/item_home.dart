
import 'package:book_dctor/core/colors.dart';
import 'package:book_dctor/cubit/cubit_cubit.dart';
import 'package:book_dctor/generated/l10n.dart';
import 'package:book_dctor/pages/book_doctor.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class ItemHome extends StatefulWidget {
  final List doctors;
  final int indexDoctors;
  const ItemHome({super.key , required this.doctors, required this.indexDoctors});

  @override
  State<ItemHome> createState() => _ItemHomeState();
}

class _ItemHomeState extends State<ItemHome> with SingleTickerProviderStateMixin {
  late final AnimationController controllerHeart;
  bool bookmark = false;
  @override
  void initState(){
    super.initState();
      getStateBookmark();
    controllerHeart = AnimationController(vsync: this , duration: const Duration(seconds: 1));
  }

  @override
  void dispose(){
    controllerHeart.dispose();
    super.dispose();
  }

// check if book true or not 
  Future<void> getStateBookmark() async {
    String idDcotor = widget.doctors[widget.indexDoctors]["id"];
    String userId = FirebaseAuth.instance.currentUser!.uid;
    try{
      QuerySnapshot querySnapshot = await  FirebaseFirestore.instance.collection("Favorite")
      .where("userId" , isEqualTo: userId).where("id" , isEqualTo: idDcotor).get();
      
      bookmark = querySnapshot.docs.isNotEmpty;
      if(bookmark){
        setState(() {
          bookmark = true;
          controllerHeart.forward();
        });
      } else{
        setState(() {
          bookmark = false;
        });
      }
    }
    catch(e){
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).tryLater , style:  const TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis,) , backgroundColor: Colors.red,));
      }
      
    }
  }
  @override
  Widget build(BuildContext context) {
    // get the current medical
    Locale currentLocale = Localizations.localeOf(context);
    // get the current medical
    String getMedical(){
                          switch(currentLocale.languageCode){
                            case "ar" : 
                            return   widget.doctors[widget.indexDoctors]["MedicalAR"] ?? "";
                            case "ja" : 
                            return     widget.doctors[widget.indexDoctors]["MedicalJA"] ?? "";
                            case "es" : 
                            return     widget.doctors[widget.indexDoctors]["MedicalES"] ?? "";
                            default : return widget.doctors[widget.indexDoctors]["Medical"] ?? "";
                          }
                        }
    // To give the item the same index and doctor 
    return GestureDetector(
      onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MoreInfoDotor(doctors: widget.doctors, indexDoctors: widget.indexDoctors)));},
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          // Image
                          const SizedBox(width: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: 80,width: 80, child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl:widget.doctors[widget.indexDoctors]["Image"] ,
                                  placeholder: (context , url) => const CircularProgressIndicator(color: blueMain),
                                  fit: BoxFit.cover,),
                              ),),
                          ),  const SizedBox(width: 7,),
                          // Colum for Name and rating and exp
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 15),
                              // Name 
                              Text("${widget.doctors[widget.indexDoctors]["name"]}" , style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 15), overflow: TextOverflow.ellipsis,),
                              // Medical specialty
                              Text(getMedical() ,  overflow: TextOverflow.ellipsis,) ,
                              const SizedBox(height: 8,),
                              Row(children: [ 
                              const Icon(Icons.star , color: Colors.amber,) ,
                              const SizedBox(width: 5),
                              // Rating
                              Text(widget.doctors[widget.indexDoctors]["rating"], style:const TextStyle(fontWeight: FontWeight.bold),) ,
                              const SizedBox(width: 10,),
                              // exp
                              Text(". ${widget.doctors[widget.indexDoctors]["exp"]} ${S.of(context).expHome}" , style: const TextStyle(fontWeight: FontWeight.bold), overflow:TextOverflow.ellipsis,)
                              ],)
                            ],
                          ) ,
                          // Last Colum has heart and price 
                          const Spacer(),
                          Container(
                            margin: const EdgeInsets.all(5),
                            child: GestureDetector(
                              onTap: (){
                                if(bookmark == false){
                                    bookmark = true;
                                  controllerHeart.forward();
                                  final idDcotor = widget.doctors[widget.indexDoctors]["id"];
                                  final nameDcotor = widget.doctors[widget.indexDoctors]["name"];
                                  context.read<FavoriteDoctorsCubit>().addFavoriteList(idDcotor, nameDcotor);
                                } else {
                                  bookmark = false;
                                  controllerHeart.reverse();
                                  final idDcotor = widget.doctors[widget.indexDoctors]["id"];
                                  context.read<FavoriteDoctorsCubit>().deleteItemFavourite(idDcotor);
                                }
                              },
                              child: SizedBox(height: 70,width: 70, child: Lottie.asset("assets/heart4.json" , controller: controllerHeart),)),
                          )
                        ],
                      )
                    ),
    );
  }
}