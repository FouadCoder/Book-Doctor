import 'package:book_dctor/auth/service.dart';
import 'package:book_dctor/core/colors.dart';
import 'package:book_dctor/generated/l10n.dart';
import 'package:book_dctor/widgets/button.dart';
import 'package:book_dctor/widgets/general_textfromfiled.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SignIn extends StatefulWidget {

  const SignIn({super.key});
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController controllerEmail = TextEditingController();

  final TextEditingController controllerPassword = TextEditingController();

  final TextEditingController controllerConfiromPassword = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey();
  bool loading = false;
  bool loadingSignup = false;
void dipsoe(){
  controllerEmail.dispose();
  controllerPassword.dispose();
  controllerConfiromPassword.dispose();
    super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.03,
          horizontal: MediaQuery.of(context).size.width * 0.03,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name of APP
                const SizedBox(height: 100),
                const Center(child:Text("HealthHub" , style: TextStyle(fontSize: 27 , fontWeight: FontWeight.bold , color: blueMain),)),
                const SizedBox(height: 60),
              // Text Login in your account 
              Text(S.of(context).SignCreateYouraccunt , style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 20),),
              const SizedBox(height: 20),
              // Email
              Text(S.of(context).Email , style: const TextStyle(color: blueMain , fontSize: 18 , fontWeight: FontWeight.bold),),
              GeneralTextfromfiled(heightText: 60,controller: controllerEmail, color: Colors.blueGrey , maxLength: 250 ,textInputType: TextInputType.emailAddress),
              // Password
              const SizedBox(height: 5),
              Text(S.of(context).Password, style: const TextStyle(color: blueMain , fontSize: 18 , fontWeight: FontWeight.bold),),
              GeneralTextfromfiled(heightText: 60,controller: controllerPassword, color: Colors.blueGrey , maxLength: 60 ,textInputType: TextInputType.text,), 
              const SizedBox(height: 5),
              // Confirm Password
              Text(S.of(context).ConfirmPassword , style: const TextStyle(color: blueMain , fontSize: 18 , fontWeight: FontWeight.bold),),
              GeneralTextfromfiled(heightText: 60,controller: controllerConfiromPassword, color: Colors.blueGrey ,maxLength: 60 ,textInputType: TextInputType.text),
              const SizedBox(height: 10,),
            
              // Login 
              loadingSignup ?
              Center(child: Lottie.asset("assets/loding.blue.json" , height: 120 , width: 120)) : 
              ClassButton(textbutton: S.of(context).signup, color: blueMain, onPressed: () async {



                if(controllerEmail.text.isNotEmpty && controllerPassword.text.isNotEmpty && controllerConfiromPassword.text.isNotEmpty){
                  if(controllerEmail.text.trim().endsWith("@gmail.com")){
                    if(controllerPassword.text.length > 8){
                      if(controllerPassword.text == controllerConfiromPassword.text){
                        try {
                    setState(() {
                      loadingSignup = true;
                    });
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: controllerEmail.text.trim(),
                password: controllerPassword.text.trim(),
                      );
                      // Go to verify email page first 
                      setState(() {loadingSignup = false;});
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushNamed("VerifyEmail");
                  } on FirebaseAuthException catch (e) {
                    setState(() {loadingSignup = false;});
                    if (e.code == 'weak-password') {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).weakpassword , style: const TextStyle(color: Colors.white),) , backgroundColor: Colors.red,));
                    } else if (e.code == 'email-already-in-use') {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).emailexait , style: const TextStyle(color: Colors.white),) , backgroundColor: Colors.red,));
                          }
                  } catch (e) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).tryLater , style: const TextStyle(color: Colors.white),) , backgroundColor: Colors.red,));
                          } // END 
                      }
                      // if the password and confirm password didn't match 
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).donTmatch), backgroundColor: Colors.red));
                      }
                    }
                    // if the password less than 8 
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).morethanA8), backgroundColor: Colors.red));
                    }
                  } 
                  // if the email didn't end with @gmail.com
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).endEmailAddress), backgroundColor: Colors.red));
                  }
                } 
                // if empty
                else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).empty) , backgroundColor: Colors.red,));
                }
              }),
            
            
            
            
            
              // here you check the loading // Login with Google
              loading ?
              Center(child: Lottie.asset("assets/loding.blue.json" , height: 120 , width: 120)) :
              ClassButton(textbutton: S.of(context).SignGoogle, color: blueMain, onPressed: () async {
            
              try{
                // Loading here
                setState(() {loading = true;});
                QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("Admin").get();
              final adminEmail = querySnapshot.docs.first["email"];
                UserCredential? user = await AuthService().signInWithGoogle();
                
                // you make a check that user not null and not admin
                      if(user != null){
                        String? useremail =  FirebaseAuth.instance.currentUser!.email;
                        if(useremail != adminEmail){
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pushNamedAndRemoveUntil("MainPage", (route)=> false);
                        } else if(useremail == adminEmail){
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pushNamedAndRemoveUntil("Admin", (route)=> false);
                        } 
                        
                      } 
                      setState(() {loading = false;});
                }catch(e){
                setState(() {loading = false;});
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: 
                // ignore: use_build_context_synchronously
                Text(S.of(context).tryagain , style: const TextStyle(color: Colors.white),)));
                // this will make the loading stop , no matter what is the state success or error
              } finally { setState(() {loading = false;});}
              }),
              const SizedBox(height: 30),
              // Text don't have an account Sign in
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(S.of(context).HaveAccount),
                  GestureDetector(onTap: (){
                    Navigator.of(context).pushReplacementNamed("Login");
                  }, child: Text(S.of(context).Login , style: const TextStyle(color: blueMain , fontWeight: FontWeight.bold),))
                ],
              )
              ],
            ),
          ),
        ),
      ),
    );
  }
}