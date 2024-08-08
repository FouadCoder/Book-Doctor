import 'dart:async';
import 'package:book_dctor/Admin/main_admin.dart';
import 'package:book_dctor/auth/login.dart';
import 'package:book_dctor/pages/mainpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';


class AuthService {
  // Google
Future<UserCredential?> signInWithGoogle() async {
  try{
      // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  if(googleUser == null){
    return null;
  }
  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  catch(e){
  return null;
  }
}
}

class CheckAcuuontAuth extends StatefulWidget{
  const CheckAcuuontAuth({super.key});

  @override
  State<CheckAcuuontAuth> createState() => _CheckAcuuontAuthState();
}

class _CheckAcuuontAuthState extends State<CheckAcuuontAuth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context , snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: Lottie.asset("assets/loding.blue.json" , height: 200 , width: 200));
                // If user have date

// Check if user admin or not 
              } else if(snapshot.hasData){
              User? user = snapshot.data;
              String? userEmail = user?.email;
              if(userEmail != null && user!= null){
                // here check if admin or not 
                return StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("Admin").snapshots(),
                  builder: (context , snapshotAdmin){
                    // check if there date 
                    if(snapshotAdmin.hasData){
                      final date = snapshotAdmin.data!.docs.first;
                      String adminEmail = date["email"];
                      if( user.emailVerified && userEmail != adminEmail){
                        return const MainPage();
                      } else if(userEmail == adminEmail){
                        return const MainAdmin();
                      } else{
                        return const Login();
                      }
                    } else{
                      // if snapshot has no date 
                      return const Login();
                    }
                  });
                  // here if useremail or user == null
              } else{
                return const Login();
              }
            } 


            // here if user has no date 
            else{
              return const Login();
            }
            })
    );
}
}