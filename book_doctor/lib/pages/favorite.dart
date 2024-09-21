import 'package:book_dctor/core/colors.dart';
import 'package:book_dctor/cubit/cubit_cubit.dart';
import 'package:book_dctor/cubit/cubit_state.dart';
import 'package:book_dctor/generated/l10n.dart';
import 'package:book_dctor/widgets/item_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {

  @override
  void initState(){
    super.initState();
    context.read<FavoriteDoctorsCubit>().getFavoriteList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(S.of(context).FavoriteList , style: const TextStyle(fontWeight: FontWeight.bold , color: blueMain),),),
        body: BlocBuilder<FavoriteDoctorsCubit,FavoriteDoctorsState>(
          builder: (context , state){
            //  LOADING
          if(state is FavoriteDoctorsLoading){
            return Center(child: Lottie.asset("assets/loding.blue.json" , height: 200 , width: 200));
            // If there ERROR
          } else if (state is FavoriteDoctorsError){
            return Center(child: SizedBox(height: 150,width: MediaQuery.of(context).size.width, child: Column(
                      children: [Image.asset("assets/cry.png" ,height: 80,width: 80,),const SizedBox(height: 20,),Text(S.of(context).ErrorProfile) ],),),);
            // if there no date in Favorite
            } else if (state is FavoriteDoctorsEmptyList){
              return Container(
                margin: const EdgeInsets.only(left: 10 , right: 10),
                child: Center(
                  child: Column( 
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [SizedBox(height: 70,width: 70, child: Image.asset("assets/fav.png"),), const SizedBox(height: 20,),
                            Text( S.of(context).EmptyFavoriteList, style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 17),) 
                          ],
                        ),
                ),
              );
          } else if(state is FavoriteDoctorsLoaded){
            final favoritelist = state.favorite;
            return Container(
              margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.02,
                vertical: MediaQuery.of(context).size.height * 0.02
              ),
              child: ListView.builder(
                itemCount: favoritelist.length,
                itemBuilder: (context , index){
                  return ItemHome(doctors: favoritelist, indexDoctors: index);
                }),
            );
          }
                  return Container();}),
    );
  }
}