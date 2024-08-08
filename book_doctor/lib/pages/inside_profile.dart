import 'package:book_dctor/core/colors.dart';
import 'package:book_dctor/cubit/cubit_cubit.dart';
import 'package:book_dctor/cubit/cubit_state.dart';
import 'package:book_dctor/generated/l10n.dart';
import 'package:book_dctor/widgets/button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class InsideProfile extends StatefulWidget {
  const InsideProfile({super.key});

  @override
  State<InsideProfile> createState() => _InsideProfileState();
}

class _InsideProfileState extends State<InsideProfile> {

  @override
  void initState(){
    super.initState();
    context.read<GetprofileDateCubit>().getDateProfile();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).Profile, style: const TextStyle(fontWeight: FontWeight.bold),),
        actions: [
          // Go Edit Page
          GestureDetector(onTap: (){ Navigator.of(context).pushNamed("EditProfile");}, child: Container(
            margin: const EdgeInsets.only(
              left: 25,
              right: 25
            ),
            child: const Icon(Icons.edit)))
        ],
        centerTitle: true,
        backgroundColor: blueMain,
      ),
      body: Container(
              margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.05,
          horizontal: MediaQuery.of(context).size.width * 0.05,
            ),
              child: BlocBuilder<GetprofileDateCubit,GetprofileDateState>(
                builder: (context , state){
                  // Loading
                    if(state is GetprofileDateLoading){
                    Center(child: SizedBox(height: 100,width: 100, child: Lottie.asset("assets/loading.blue.json"),),);
                  }
                  // Error
                  else if(state is GetprofileDateError){
                    return Center(child: SizedBox(height: 300,width: 300, child: Lottie.asset("assets/user1.json"),),);
                  } 
                  // if date is empty like he didn't date before 
                  else if (state is GetprofileDateEmpty){
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Animtion 
                        SizedBox(height: 300,width: 300, child: Lottie.asset("assets/user1.json"),),
                        const SizedBox(height: 20),
                        ClassButton(textbutton: S.of(context).CreateAccount, color: blueMain, onPressed: (){
                          Navigator.of(context).pushNamed("EditProfile");
                        })
                      ],
                    );
                  }
                  // Successfully
                  else if(state is GetprofileDateLoaded){
                      final userdate = state.userdate;
                      if(userdate.isNotEmpty){
                        return ListView(
                    children: [
                      const SizedBox(height: 15),
                      // Image of Profile
                      Stack(
                        children: [
                          // Color
                          Container(
                            height: 220,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: blueMain,
                              borderRadius: BorderRadius.circular(20)
                            ),
                          ),
                          Center(
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                // Image 
                                Container(
                                height: 130,
                                width: 130,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle
                                ),
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: userdate[0]["ImageURL"] ?? "https://firebasestorage.googleapis.com/v0/b/book-a-doctor-460bc.appspot.com/o/user.png?alt=media&token=f4a01e9d-1182-49be-a5d0-64794f5db563",
                                    placeholder: (context , url) => const CircularProgressIndicator(color: blueMain,),
                                    errorWidget: (context , url , error)=> Image.asset("assets/user.png" , fit: BoxFit.cover,) ,
                                    fit: BoxFit.cover,),
                                ),
                              ),
                            const SizedBox(height: 30),
                            // name of user
                              Text( userdate[0]["name"] ?? "", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),  overflow: TextOverflow.ellipsis,), ],
                            ),
                          )
                        ],
                      ),
                      // Date of Profile
                      const SizedBox(height: 45),
                      // Email
                      Text(S.of(context).Email , style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 20 ) ,  overflow: TextOverflow.ellipsis,),
                      const SizedBox(height: 5),
                      Text(userdate[0]["Email"] ?? "" , style: const TextStyle(fontSize: 17, color: Colors.grey),),
                      const SizedBox(height: 15,),
                  
                      // Number
                      Text(S.of(context).PhoneNumber , style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 20)),
                      const SizedBox(height: 5),
                      Text( userdate[0]["Phone Number"] ?? "" , style: const TextStyle(fontSize: 17 , color: Colors.grey),),
                      const SizedBox(height: 15),
                  
                      // Address
                      Text(S.of(context).Address , style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 20)),
                      const SizedBox(height: 5),
                      Text( userdate[0]["Address"] ?? "" , style: const TextStyle(fontSize: 17 , color: Colors.grey),  overflow: TextOverflow.ellipsis,),
                      const SizedBox(height: 15),
                  
                  
                      // Text Medical history
                      Text(S.of(context).MedicalHistory , style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 22)),
                      const SizedBox(height: 10),
                      Text(userdate[0]["Medical History"] ?? "" ,
                      style: const TextStyle(fontWeight: FontWeight.w500 , color: Colors.grey), ),
                      const SizedBox(height: 20),
                  
                  
                      // Current medical
                      Text(S.of(context).CurrentMedical , style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 22)),
                      const SizedBox(height: 10,),
                      // Text date Current medical . will come from server
                      Text(userdate[0]["Current Medical"] ?? "" ,
                      style: const TextStyle(fontWeight: FontWeight.w500 , color: Colors.grey))
                    ],
                  ); 
                      } else {
                        SizedBox(height: 300,width: 300, child: Lottie.asset("assets/user1.json"),);
                      }
                  } 
                  return Container();
                }
              ),
            )
    );
  }
}