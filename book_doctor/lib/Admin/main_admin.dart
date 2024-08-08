import 'package:book_dctor/Admin/cubit_admin.dart/cubit_cubit_admin.dart';
import 'package:book_dctor/Admin/cubit_admin.dart/cubit_state_admin.dart';
import 'package:book_dctor/Admin/wigets_admin/total.dart';
import 'package:book_dctor/core/colors.dart';
import 'package:book_dctor/cubit/cubit_cubit.dart';
import 'package:book_dctor/cubit/cubit_state.dart';
import 'package:book_dctor/generated/l10n.dart';
import 'package:book_dctor/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';

class MainAdmin extends StatefulWidget {
  const MainAdmin({super.key});

  @override
  State<MainAdmin> createState() => _MainAdminState();
}

class _MainAdminState extends State<MainAdmin> {
@override
  void initState(){
  super.initState();
  context.read<DoctorsdateCubit>().getDctorsList();
  context.read<ProfileUsersADCubit>().getProfile();
  context.read<BooksADCubit>().booksDate();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).WelcomeAdmin , style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: blueMain,
        actions: [
          IconButton(onPressed: (){
            GoogleSignIn googleSignIn = GoogleSignIn();
            googleSignIn.disconnect();
            Navigator.of(context).pushNamedAndRemoveUntil("Login", (route)=> false);
          }, icon: const Icon(Icons.login_rounded , size: 35,))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              // Total of successfully books
              BlocBuilder<BooksADCubit, BooksADState>(
                builder: (context , stateBooks) {
                  if(stateBooks is BooksADLoading){return Center(child: Lottie.asset("assets/loding.blue.json" , height: 200 , width: 200));}
                  else if(stateBooks is BooksADLoaded){final booksDate = stateBooks.booksDate.length ; return TotalAdmin(firstText: S.of(context).Books, numberOf: "$booksDate"); }
                  else if(stateBooks is BooksADError){return Text(S.of(context).NOTAVAILABLE);}
                  return Container();
                }
              ),
              // doctors
              BlocBuilder<DoctorsdateCubit,DoctorsdateState>(
                builder: (context , stateDoctors) {
                  // loading 
                  if(stateDoctors is DoctorsdateLoading){return Center(child: Lottie.asset("assets/loding.blue.json" , height: 200 , width: 200));}
                  else if(stateDoctors is DoctorsdateLoaded){final totaldoctors = stateDoctors.doctorsList.length;return TotalAdmin(firstText: S.of(context).Doctors, numberOf: "$totaldoctors");}
                  else if(stateDoctors is DoctorsdateError){return Text(S.of(context).NOTAVAILABLE);}
                return Container();}
              ),
              // Users
              BlocBuilder<ProfileUsersADCubit , ProfileUsersADState>(
                builder: (context , stateUsers) {
                  if(stateUsers is ProfileUsersADLoading){return Center(child: Lottie.asset("assets/loding.blue.json" , height: 200 , width: 200));}
                  else if(stateUsers is ProfileUsersADLoaded){final usersLength = stateUsers.profileDate.length;return TotalAdmin(firstText: S.of(context).Users, numberOf: "$usersLength");}
                  else if(stateUsers is ProfileUsersADError){return Text(S.of(context).NOTAVAILABLE);}
                  return Container();
                }
              ),









              const SizedBox(height: 100),
              // Create a new profile 
              ClassButton(textbutton: S.of(context).addNewDoctor, color: blueMain, onPressed: (){Navigator.of(context).pushNamed("CreateDoctor");}),
              // Doctors
              ClassButton(textbutton: S.of(context).Doctors, color: blueMain, onPressed: (){Navigator.of(context).pushNamed("DoctorsAdmin");}),
              // Book
              ClassButton(textbutton: S.of(context).MangeBooks, color: blueMain, onPressed: (){}),
              // users 
              ClassButton(textbutton: S.of(context).Users, color: blueMain, onPressed: (){}),
            ],
          ),
        ),
      ),
    );
  }
}