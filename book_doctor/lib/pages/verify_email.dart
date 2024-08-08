import 'dart:async';

import 'package:book_dctor/core/colors.dart';
import 'package:book_dctor/generated/l10n.dart';
import 'package:book_dctor/widgets/button.dart';
import 'package:book_dctor/widgets/show_dilog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  DateTime? _lastrequest; // last time user ask verify 
  int ? _requstConut; // how many times user asked verify
  int  conter = 0; // sec
  Timer? _timer;

@override
  void initState(){
  super.initState();
  getLastrequest();
  if(_requstConut == 0){
    FirebaseAuth.instance.currentUser!.sendEmailVerification(); // send verify 
  } 
}

void successVerifyGoLogin(BuildContext context){
  showDialog(context: context, builder: (BuildContext context){
    return ShowdialogSuccess(message: S.of(context).successVeirfyMessage, onPressed: (){Navigator.of(context).pushNamedAndRemoveUntil("Login", (route)=> false);}, stateImage: "assets/true.blue.png", mainText: S.of(context).Success, buttomText: S.of(context).LoginAfterVerifyButton);
  });
}

// get the last date of verify , how many user request Email verify 
  Future<void> getLastrequest() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    DateTime lastrequest = DateTime.parse(sharedPreferences.getString("_lastrequest") ?? DateTime.now().toString()); // get the last request time
    int requstConut = sharedPreferences.getInt("_requstConut") ?? 0 ;

    final now = DateTime.now();
    final differentTime = now.difference(lastrequest);
    // check if there more than one day has been passed 
    if(differentTime.inDays > 1){
      requstConut = 0;
    }
    
    setState(() {
      _lastrequest = lastrequest;
      _requstConut = requstConut;
    });

    startTimer();
  }

// update the date in SharedPreferences 
  Future<void> upddatLastrequst() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("_lastrequest", DateTime.now().toString()); // date time
    sharedPreferences.setInt("_requstConut", _requstConut! + 1);
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
    else if(_requstConut! >= 4){requerTime = 360 * 60;} // 5 Hours

    final differentSEC = differentTime.inSeconds; // get the different in sec
    final remainigTime = requerTime - differentSEC;
    return remainigTime > 0 ? remainigTime : 0;
  }

  
// send verify to user 
  Future<void> _sendverifyEmail() async {
          // send verify 
          try{
      await FirebaseAuth.instance.currentUser!.sendEmailVerification(); // send verify 
      await upddatLastrequst(); // to update last date 
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).emailsent) , backgroundColor: Colors.green,));
          }
          catch(e){
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).tryLater) , backgroundColor: Colors.red,));
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
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image 
              const SizedBox(height: 30,),
              SizedBox(height: 120,width: 120, child: Image.asset("assets/email.png"),),
              const SizedBox(height: 10,),
              Text(S.of(context).headlinecheck , style: const TextStyle(fontWeight: FontWeight.bold , color: blueMain , fontSize: 23),),
              const SizedBox(height: 20,),
              // text check email 
              Center(child: Text(S.of(context).checkEmail , style: const TextStyle(fontWeight: FontWeight.w500),textAlign: TextAlign.center,)),
              const SizedBox(height: 50,),
              // button to sign in 
              Container( margin: const EdgeInsets.all(15),
                child: ClassButton(textbutton: S.of(context).checkveifyButton, color: blueMain, onPressed: () async {
                  User ? user = FirebaseAuth.instance.currentUser;
                  await user!.reload(); // to get the last date if user has verify has email 
                  user = FirebaseAuth.instance.currentUser;
                  if( user != null && user.emailVerified){
                    // take the user to Home Page 
                    // ignore: use_build_context_synchronously
                    successVerifyGoLogin(context);
                  } else {
                    // if user has not verifay has email 
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).NotVerify , style: const TextStyle(color: Colors.white),) , backgroundColor: Colors.red,));
                  }
                })),
                // send verify again 
                conter == 0 ?
                GestureDetector(
                  onTap: () async {
                  await _sendverifyEmail();
                  },
                  child: Text(S.of(context).verifyAgin , style: const TextStyle(fontWeight: FontWeight.bold , color: blueMain),),
                  // if timer not zero , that will appear
                )  : Text("${S.of(context).timerEmailresend}  ${getFormattedTime()}" , style: const TextStyle(fontSize: 18),)
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose(){
    if(_timer != null){
      _timer!.cancel();
    }
    super.dispose();
  }
}


