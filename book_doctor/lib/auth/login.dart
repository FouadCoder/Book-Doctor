import 'dart:async';

import 'package:book_dctor/auth/service.dart';
import 'package:book_dctor/core/colors.dart';
import 'package:book_dctor/generated/l10n.dart';
import 'package:book_dctor/widgets/button.dart';
import 'package:book_dctor/widgets/general_textfromfiled.dart';
import 'package:book_dctor/widgets/show_dilog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {

  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController controllerEmail = TextEditingController();

  final TextEditingController controllerPassword = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey();
  bool loading = false;
  bool loadingLogin = false;

  DateTime? _lastrequest;
  int? _requstConut;
  int conter = 0;
  Timer? _timer;
  
  @override
  void initState(){
    super.initState();
    getLastrequest();
  }



 // to ask user if he want to verify email 
void verifayEmail(BuildContext context){
  showDialog(context: context, builder: (BuildContext context){
    return ShowdialogSuccess(message: S.of(context).messageaskverify, onPressed: (){Navigator.of(context).pushNamed("VerifyEmail");}, stateImage: "assets/email.png", mainText: S.of(context).headlineaskverify, buttomText: S.of(context).verify);
  });
}

// get the date of how many user asked verify 
  Future<void> getLastrequest() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    DateTime lastrequestdate = DateTime.parse(sharedPreferences.getString("_lastrequestPassword") ?? DateTime.now().toString()); // get the last request time
    int requstConutdate = sharedPreferences.getInt("_requstConutPassword") ?? 0 ;

    // get the time 
    final now = DateTime.now();
    final differentTime = now.difference(lastrequestdate);
    // check if the different time is more than one day 
    if(differentTime.inDays > 1){
      requstConutdate = 0;
    }

    setState(() {
      _lastrequest = lastrequestdate;
      _requstConut = requstConutdate;
    });
    startTimer();
  }

// update the date in SharedPreferences 
  Future<void> upddatLastrequst() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("_lastrequestPassword", DateTime.now().toString()); // date time
    sharedPreferences.setInt("_requstConutPassword", _requstConut! + 1);
    await getLastrequest();
  }
// send the verify 
  int _isuserCanRequstverify(){
    final now = DateTime.now();
    final differentTime = now.difference(_lastrequest!); // the different between now and last request 
    int requerTime = 0;
    if(_lastrequest == null || _requstConut == 0){return 0;}
    else if(_requstConut == 1 ){requerTime = 10 * 60;} // 10  Minutes
    else if(_requstConut == 2 ){requerTime = 20  * 60;}// 20 Minutes
    else if(_requstConut == 3 ){requerTime = 60 * 60;} //  1 Hour
    else if(_requstConut! >= 4){requerTime = 360 * 60;} // 6 Hours

    final differentSEC = differentTime.inSeconds; // get the different in sec
    final remainigTime = requerTime - differentSEC;
    return remainigTime > 0 ? remainigTime : 0;
  }

  
// send rest password
  Future<void> _sendrestPassword(String emailRest) async {
          // send verify 
          try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailRest); // send rest password
      await upddatLastrequst(); // to update last date 
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).passwordrestsent , style: const TextStyle(color: Colors.white),) , backgroundColor: Colors.green,));
          }
          on FirebaseAuthException {
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).tryLater, style: const TextStyle(color: Colors.white)) , backgroundColor: Colors.red,));
          }
  }

    // Timer
    void startTimer(){
      int rmingTime = _isuserCanRequstverify();
      setState(() {
        conter = rmingTime;
      });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer){
      setState(() {
        if(conter <= 0){
          _timer!.cancel();
        } else {
          conter--;
        }
      });
    });
  }

    // make it in nice way String Time minutes and sec
  String getFormattedTime() {
  int minutes = conter ~/ 60;
  int seconds = conter % 60;
  String minutesStr = minutes.toString().padLeft(2, '0');
  String secondsStr = seconds.toString().padLeft(2, '0');
  return '$minutesStr:$secondsStr';
}

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.03,
          horizontal: MediaQuery.of(context).size.width * 0.03,
        ),
        child:SingleChildScrollView(
          child:Form(
            key: globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name of APP
                const SizedBox(height: 150),
                const Center(child:Text("HealthHub" , style: TextStyle(fontSize: 27 , fontWeight: FontWeight.bold , color: blueMain),)),
                const SizedBox(height: 80),
              // Text Login in your account 
              Text(S.of(context).LoginInYourAccount , style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 20),),
              const SizedBox(height: 20),
              // Email
              Text(S.of(context).Email , style: const TextStyle(color: blueMain , fontSize: 18 , fontWeight: FontWeight.bold),),
              GeneralTextfromfiled(heightText: 60,controller: controllerEmail, color: Colors.blueGrey , maxLength: 250 ,textInputType: TextInputType.emailAddress,validator: (val){
                if(val!.isEmpty){return S.of(context).Empty;}
                if(!val.trim().endsWith("@gmail.com")){return S.of(context).endEmailAddress;}
                return null;},),
              // Password
              const SizedBox(height: 5),
              Text(S.of(context).Password, style: const TextStyle(color: blueMain , fontSize: 18 , fontWeight: FontWeight.bold),),
              GeneralTextfromfiled(heightText: 60,controller: controllerPassword, color: Colors.blueGrey , maxLength: 60 ,textInputType: TextInputType.text,validator: (val){
                if(val!.isEmpty){return S.of(context).Empty;}
                return null;},), 
              const SizedBox(height: 10,),
              // Forget password
              conter == 0 ?
              Row(
                children: [
                  const Spacer(),
                  GestureDetector(
                    onTap: (){
                      if(controllerEmail.text.isNotEmpty){
                        if(controllerEmail.text.endsWith("@gmail.com")){
                          _sendrestPassword(controllerEmail.text.trim()); // send rest password
                        } else {
                          // if the email write in bad way 
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).endEmailAddress , style: const TextStyle(color: Colors.white),) , backgroundColor: Colors.red,));
                        }
                      } else {
                        // if user didn't write has email 
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).writeEmail , style: const TextStyle(color: Colors.white),) , backgroundColor: Colors.red,));
                      }
                    },
                    child: Text(S.of(context).ForgotPassword , style: const TextStyle(fontWeight: FontWeight.bold , color: blueMain),textAlign: TextAlign.right,),
                  ),
                ],
              ) : Row(children: [
                const Spacer(),
                // ignore: unnecessary_string_interpolations
                Text("${getFormattedTime()}" , style: const TextStyle(fontSize: 18),),
              ],),
            const SizedBox(height: 5,),
              // Login 
              loadingLogin ? 
              Center(child: Lottie.asset("assets/loding.blue.json" , height: 120 , width: 120)) :
              ClassButton(textbutton: S.of(context).Login , color: blueMain, onPressed: () async{
                // check that passwords and email not empty 
            if(globalKey.currentState!.validate()){
              try {
                setState(() {loadingLogin = true;});
              await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: controllerEmail.text.trim(),
                password: controllerPassword.text.trim()
              );
              // here if login end successfully 
              User? user = FirebaseAuth.instance.currentUser;
              if(user != null && user.emailVerified){
                // Main page 
                setState(() {loadingLogin = false;}); // false
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushNamedAndRemoveUntil("MainPage", (route)=> false);
              } else {
                setState(() {loadingLogin = false;}); // salse 
                // ignore: use_build_context_synchronously
                verifayEmail(context);
              }
              

              // if there error 
            } on FirebaseAuthException catch (e) {
              setState(() {loadingLogin = false;});
              // if email or password is worng
              if(e.code == 'invalid-credential'){
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).worngemailorpassword , style: const TextStyle(color: Colors.white),) , backgroundColor: Colors.red,));
                // too many requsets
              } else if(e.code == 'too-many-requests'){
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).toomanyrequst , style: const TextStyle(color: Colors.white),) , backgroundColor: Colors.red,));
                // any error else 
              } else {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).trylater , style: const TextStyle(color: Colors.white),) , backgroundColor: Colors.red,));
              }
              }
            }
              }),
            
            
            
              // Google
              loading ? 
              Center(child: Lottie.asset("assets/loding.blue.json" , height: 150 , width: 150)) :
              ClassButton(textbutton: S.of(context).LoginGoogle, color: blueMain, onPressed: () async {
                try{
                // Loading here
                setState(() {loading = true;});
                QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("Admin").get();
              final adminEmail = querySnapshot.docs.first["email"];
              // Sign in Auth
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
                      // stop loading
                      setState(() {loading = false;});
                }  catch(e){
                setState(() {loading = false;});
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: 
                // ignore: use_build_context_synchronously
                Text(S.of(context).tryagain)));
                // this will make the loading stop , no matter what is the state success or error
              } finally { setState(() {loading = false;});}
              }),
            
            
              const SizedBox(height: 30),
              // Text don't have an account Sign in
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(S.of(context).DontHvaeAccount),
                  GestureDetector(onTap: (){
                    Navigator.of(context).pushReplacementNamed("Sign");
                  }, child: Text(S.of(context).signup , style: const TextStyle(color: blueMain , fontWeight: FontWeight.bold),))
                ],
              )
              ],
            ),
          ),
        ),
      ),
    );
  }
@override
  void dispose(){
  controllerEmail.dispose();
  controllerPassword.dispose();
    if(_timer != null){
      _timer!.cancel();
    }
  super.dispose();
}

}