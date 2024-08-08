import 'package:book_dctor/core/colors.dart';
import 'package:book_dctor/cubit/cubit_cubit.dart';
import 'package:book_dctor/cubit/cubit_state.dart';
import 'package:book_dctor/generated/l10n.dart';
import 'package:book_dctor/widgets/listtile_profile.dart';
import 'package:book_dctor/widgets/sheetbutton_dark.dart';
import 'package:book_dctor/widgets/sheetbutton_language.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {

  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
      bool paymentway = false;




  @override
  void initState(){
    super.initState();
    context.read<GetprofileDateCubit>().getDateProfile();
    getVisaState();
  }
// add payment way to get in Doctor book 
      Future<void> getVisaState() async {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      bool? stateVisa = sharedPreferences.getBool("VisaState");
      if(stateVisa == null){
        stateVisa = false;
      } else if(stateVisa == true){
        stateVisa = true;
      } else{
        stateVisa = false;
      }
      setState(() {
        paymentway = stateVisa!;
      });
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: MediaQuery.of(context).size.height * 0.01,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // For Image and Name Of profile
              BlocBuilder<GetprofileDateCubit,GetprofileDateState >(
                builder: (context , state) {
                  // Loading
                  if(state is GetprofileDateLoading){
                    Center(child: SizedBox(height: 100,width: 100, child: Lottie.asset("assets/loading.blue.json"),),);
                    // Error
                  } else if (state is GetprofileDateError){
                    return Center(child: SizedBox(height: 150,width: MediaQuery.of(context).size.width, child: Column(
                      children: [Image.asset("assets/cry.png" ,height: 80,width: 80,),const SizedBox(height: 20,),Text(S.of(context).ErrorProfile) ],),),);
                  } else if (state is GetprofileDateLoaded){
                    final userdate = state.userdate;
                    if(userdate.isNotEmpty){
                      return ListTile(
                    // Image
                    onTap: (){Navigator.of(context).pushNamed("InsideProfile");},
                    leading:Container(
                              height: 55,
                              width: 55,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle
                              ),
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl:userdate[0]["ImageURL"] ?? "https://firebasestorage.googleapis.com/v0/b/book-a-doctor-460bc.appspot.com/o/user.png?alt=media&token=f4a01e9d-1182-49be-a5d0-64794f5db563",
                                  placeholder: (context , url) => const CircularProgressIndicator(color: blueMain,),
                                  errorWidget: (context , url , error)=> Image.asset("assets/user.png" , fit: BoxFit.cover,) ,
                                  fit: BoxFit.cover,),
                              ),
                            ),
                            // Name
                    title: Text(userdate[0]["name"] ?? "", style: const TextStyle(color: blueMain , fontWeight: FontWeight.bold , fontSize: 20) , overflow: TextOverflow.ellipsis,),
                    subtitle: Text(userdate[0]["Email"] ?? "" ,  overflow: TextOverflow.ellipsis,),
                  );
                    } else {
                      return Container();
                    }
                  }
                  // List tile if there no user date 
                return  ListTile(
                    // Image
                    onTap: (){Navigator.of(context).pushNamed("InsideProfile");},
                    leading:Container(
                              height: 50,
                              width: 50,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle
                              ),
                              child: ClipOval(
                                child: Image.asset("assets/user.png")
                              ),
                            ),
                            // Name
                    title: Text(S.of(context).Welcome, style: const TextStyle(color: blueMain , fontWeight: FontWeight.bold , fontSize: 20),),
                    subtitle: Text(S.of(context).MakeAcounnt),
                  );
                }) ,
              const SizedBox(height: 30,),



              // Paymeant
                  const Divider(color: Colors.grey , thickness: 0.1,),
                  ListTile(
                    title: Text(S.of(context).PaymentAlways ,),
                    leading: const Icon(Icons.payment , color: blueMain,),
                    trailing: Switch(
                      activeColor: blueMain,
                      value: paymentway, onChanged: (val) async {setState((){
                      paymentway = val;
                    }); // to save it 
                      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                      sharedPreferences.setBool("VisaState", paymentway);
                    }),
                  ),



              const Divider(color: Colors.grey , thickness: 0.1,),
              // favorite list 
              TileProfile(leading: const Icon(Icons.favorite), text: S.of(context).favourite, onTap: (){
                Navigator.of(context).pushNamed("Favorite");
              }),
              const Divider(color: Colors.grey , thickness: 0.1,),
              // Language
              TileProfile(leading: const Icon(Icons.language), text: S.of(context).Language, onTap: (){
                showModalBottomSheet(context: context, builder: (BuildContext context){
                  return const SheetbuttonLanguage();
                });
              }),
              const Divider(color: Colors.grey , thickness: 0.1,),
              // Dark Mode
              TileProfile(leading: const Icon(Icons.dark_mode_outlined), text: S.of(context).DarkMode, onTap: (){
                showDialog(context: context, builder: (BuildContext context){
                  return const EditSheetDARK();
                });
              }),
              const Divider(color: Colors.grey , thickness: 0.1,),
              // Logout
              TileProfile(leading: const Icon(Icons.login), text: S.of(context).Logout, onTap: () async {
                GoogleSignIn googleSignIn = GoogleSignIn();
                googleSignIn.disconnect();
                await FirebaseAuth.instance.signOut();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushNamedAndRemoveUntil("Login", (route)=> false);
              }),
            ],
          ),
        ),
      ),
    );
  }
}