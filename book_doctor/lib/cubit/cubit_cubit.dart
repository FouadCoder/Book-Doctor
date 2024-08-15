
import 'dart:async';
import 'dart:io';
import 'package:book_dctor/cubit/cubit_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
// Cubit for DARK MOOD
class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(ThemeData()){
    toggleTheme();
  }



  void toggleTheme() async {
    // to add what he choose in Momery 
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      String? mood = sharedPreferences.getString("Mode");
      
    if (mood == "Dark") {
      emit(ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.grey,
        textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.white)),
      ));
    } else if (mood == "Light") {
      emit(ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
      textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.black)),
    ));
    } 
   } // End of toggleThem

  void updateThem(String themdate) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("Mode", themdate);
    if(themdate == "Dark"){
      emit(ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.grey,
        textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.white)),
      ));
    } else if(themdate == "Light"){
      emit(ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
      textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.black)),
    ));
    }
  }
}
// Cubit For Language
class LanguageCubit extends Cubit<LanguageState>{
  LanguageCubit() : super(LanguageInitial()){
    getLanguage();
  }

  // Get the language from SharedPreferences
  void getLanguage () async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? language = sharedPreferences.getString("Language");
    if(language != null){
      emit(LanguageSelected(language));
    } else{
      // if language == null , so I see the language of systeam
      final loacl = WidgetsBinding.instance.platformDispatcher.locale;
              String systeamLanguage(){
                switch(loacl.languageCode){
                  case "ar" :
                  return "ar";
                  case "es" :
                  return "es";
                  case "ja" :
                  return "ja";
                  default : return "en";
                }
              }
              // to make system langaue
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("Language", systeamLanguage());
      String language1 = systeamLanguage();
      emit(LanguageSelected(language1));
    }
  }
  // Update the language 
  void updateLanguage (String language) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("Language", language);
    emit(LanguageSelected(language));
  }
}

// Cubit get user dtae
class GetprofileDateCubit extends Cubit<GetprofileDateState>{
  GetprofileDateCubit() : super(GetprofileDateInitial());

  void getDateProfile() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    try{
      emit(GetprofileDateLoading());
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("Users").where("UserId" , isEqualTo: userId).get();
      if(querySnapshot.docs.isEmpty){
        emit(GetprofileDateEmpty());
      }
      else{
        emit(GetprofileDateLoaded(querySnapshot.docs));
      }
    }  
    catch(e){
      emit(GetprofileDateError());
    }
  }
}

// Update or Add Profile Date
class UpdateProfileCubit extends Cubit<UpdateProfileState>{
  UpdateProfileCubit() : super(UpdateProfileInitial());


  void updateProfile (String name , String phoneNumber , String address , String medicalHistory , String currentMedical
  ,String gender , File? image) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    String? email =  FirebaseAuth.instance.currentUser!.email;
    try{
      emit(UpdateProfileLoading());
      QuerySnapshot querySnapshot =  await FirebaseFirestore.instance.collection("Users").where("UserId" , isEqualTo: userId).get();
      // Get URL Image
      String? pirctureURL;
      if(image != null) {
        String fillname = "ProfilePicture$userId.jpg";
        var imagevar = FirebaseStorage.instance.ref("UsersPicture/$fillname");
        await imagevar.putFile(image);
        pirctureURL = await imagevar.getDownloadURL();
      }
      // If the date is empty 
      if(querySnapshot.docs.isEmpty){
        FirebaseFirestore.instance.collection("Users").add({
          "UserId" : userId ,
          "Phone Number" : phoneNumber,
          "name" : name,
          "Address" : address,
          "Medical History": medicalHistory,
          "Current Medical": currentMedical,
          "Gender" : gender,
          "ImageURL" : pirctureURL,
          "Email" : email,
          "JoinTime": FieldValue.serverTimestamp()
        });
        emit(UpdateProfileLoaded());
      }
      // if the date has alreay exit , so make update 
      else{
        FirebaseFirestore.instance.collection("Users").doc(querySnapshot.docs.first.id).update({
          "UserId" : userId ,
          "Phone Number" : phoneNumber,
          "name": name,
          "Address" : address,
          "Medical History": medicalHistory,
          "Current Medical": currentMedical,
          "Gender" : gender,
          "ImageURL" : pirctureURL
        });
        emit(UpdateProfileLoaded());
      }
    }
    catch(e){
      emit(UpdateProfileError());
    }
  }
}

// Get date of doctors
class DoctorsdateCubit extends Cubit<DoctorsdateState>{
  DoctorsdateCubit () : super(DoctorsdateInitial());


  void getDctorsList () async {
    try{
      emit(DoctorsdateLoading());
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("Doctors").get();
      final doctors = querySnapshot.docs;
      emit(DoctorsdateLoaded(doctors));
    }
    catch(e){
      emit(DoctorsdateError());
    }
  }
}

// Get and update and delete Favorite List
class FavoriteDoctorsCubit extends Cubit<FavoriteDoctorsState>{
  FavoriteDoctorsCubit() : super(FavoriteDoctorsInitial());

// Get date from Favorite
void getFavoriteList() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    List favoriteList = [];
    try{
      emit(FavoriteDoctorsLoading());
      QuerySnapshot querySnapshotdoctor = await FirebaseFirestore.instance.collection("Favorite")
      .where("userId" , isEqualTo: userId).get();
      if(querySnapshotdoctor.docs.isNotEmpty){
        for(var idSearch in querySnapshotdoctor.docs){
        // to get the id 
        final String idDoctor = idSearch["id"];
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("Doctors")
        .where("id" , isEqualTo: idDoctor).get();
        favoriteList.addAll(querySnapshot.docs);
      }
      if(favoriteList.isNotEmpty){
        emit(FavoriteDoctorsLoaded(favoriteList));
      }
      else{
        emit(FavoriteDoctorsEmptyList());
      }
      } else {
        // if there no date in favorite list 
        emit(FavoriteDoctorsEmptyList());
      } 
    }
    catch(e){
      emit(FavoriteDoctorsError());
    }
  }
// Add  
void addFavoriteList (String idDoctor , String nameDoctor) async {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  try{
    await FirebaseFirestore.instance.collection("Favorite").add({
      "userId" : userId ,
      "Name" : nameDoctor,
      "id" : idDoctor
    });
  }
  catch(e){
    emit(FavoriteDoctorsError());
  }
}
// delete 
void deleteItemFavourite (String idDoctor) async {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  try{
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("Favorite")
    .where("userId" , isEqualTo: userId).where("id" , isEqualTo: idDoctor).get();
    if(querySnapshot.docs.isNotEmpty){
      DocumentSnapshot  documentSnapshot = querySnapshot.docs[0];
      await FirebaseFirestore.instance.collection("Favorite").doc(documentSnapshot.id).delete();
    } else{
      emit(FavoriteDoctorsError());
    }
  }
  catch(e){
    emit(FavoriteDoctorsError());
  }
}
}

// get the available days


// Get hours for each doctor 
class HourAvailableCubit extends Cubit<HourAvailableState>{
  HourAvailableCubit() : super(HourAvailableInitial());


  StreamSubscription? subscription;
// function to make the stream work 
void workStream(String idDoctor , String keyDay){
  if(subscription != null){
    subscription!.cancel();
    subscription = null;
  }
    Stream mystream = FirebaseFirestore.instance.collection("Doctors").where("id" , isEqualTo: idDoctor).limit(1).snapshots();
    
        
        subscription = mystream.listen((snapshotEvent){
          final QuerySnapshot querySnapshot = snapshotEvent as QuerySnapshot;
          final doctors = querySnapshot.docs.first;
          // get the hours
          Map<String , dynamic> availability = doctors["MonthTime"];
          Map<String , dynamic> daysAndBool = availability[keyDay];  // Hours and bool
List<String> hours = [];
      for(final keyA in daysAndBool.keys){ // keyA Hour 
      final boolHour = daysAndBool[keyA];// bool for each day , can be true or false 
      if(boolHour == false && !hours.contains(keyA)){
        hours.add(keyA);
        }
        } // End of for 
        hours.sort();
        emit(HourAvailableLoaded(hours, keyDay, idDoctor));
        });
  
  
}
// stop stream 
void stopStream(){
  if(subscription != null){
      subscription!.cancel();
  emit(HourAvailableStop()); }
}

}

















// bood a date
class BookDoctorCubit extends Cubit<BookDoctorState>{
  BookDoctorCubit() : super(BookDoctorInitial());


  void bookDateDoctor(String name ,String address , String gender , String medicalHistory , String currentMedical , String phoneNumber
  , String doctorName ,String idDoctor ,String medical, String medicalAR , String medicalES , String medicalJA,String price , String dayBook , String hourBook ,String image , String payment) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    String? email = FirebaseAuth.instance.currentUser!.email;
    var uuid = const Uuid();
    String uniqueId = uuid.v4(); // to make unique Id every time
    DateTime now = DateTime.now();
    try{
      emit(BookDoctorLoading());
      FirebaseFirestore.instance.collection("Books").add({
        // Date of user 
        "name" : name ,
        "email" : email,
        "userId" : userId,
        "address" : address,
        "gender" : gender ,
        "medicalHistory" : medicalHistory,
        "currnetMedical" : currentMedical,
        "phoneNumber" : phoneNumber,
        // Date of doctor
        "DoctorName" : doctorName,
        "DoctorId": idDoctor,
        "Medical" : medical,
        "MedicalAR" : medicalAR,
        "MedicalES" : medicalES,
        "MedicalJA" :medicalJA,
        "Image" : image,
        "price" : price ,
        "Payment" : payment,
        // Date of book
        "dayBook" : dayBook,
        "hourBook" : hourBook,
        "uniqueId" : uniqueId,
        "DateTime" : now
      });
      // make the date false in Doctors schedule
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("Doctors").where("id" , isEqualTo: idDoctor).limit(1).get();
      if(querySnapshot.docs.isNotEmpty){
        final dateDoctors = querySnapshot.docs.first;
        final List keyday = dayBook.split(" / ") as List;
        int monthkey = int.parse(keyday[0]);
        int dayhkey = int.parse(keyday[1]);

    String formattedDateKey = '${monthkey.toString().padLeft(2, '0')}-${dayhkey.toString().padLeft(2, '0')}'; /// Formatted Date Key: 08-25
      Map<String , dynamic> availability = dateDoctors["MonthTime"];
      // check if the day exit 
      if(availability.containsKey(formattedDateKey)){
        Map<String  , dynamic> hourandBool = availability[formattedDateKey]; // Hour and bool
        // check the bool for hour 
        if(hourandBool.containsKey(hourBook)){
          // Update in Firebase
          String fieldPath = 'MonthTime.$formattedDateKey.$hourBook'; // to chnage the hour and make it ture
          await FirebaseFirestore.instance.collection("Doctors").doc(dateDoctors.id).update({fieldPath: true});
        }
      }
      // Get the key day 
      }

      emit(BookDoctorLoaded());
    }catch(e){
      emit(BookDoctorError());
    }
  }
}


// cancel d date ins schedule 
class CancelScheduleCubit extends Cubit<CancelScheduleState>{
  CancelScheduleCubit() : super(CancelScheduleInitial());

  void cancelDate(String dayBook , String hourBook , String idDoctor , String docId) async {
    try{
      emit(CancelScheduleLoading());
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("Doctors").where("id" , isEqualTo: idDoctor).limit(1).get();
      if(querySnapshot.docs.isNotEmpty){
        final dateDoctors = querySnapshot.docs.first;
        final List keyday = dayBook.split(" / ") as List;
        int monthkey = int.parse(keyday[0]);
        int dayhkey = int.parse(keyday[1]);

    String formattedDateKey = '${monthkey.toString().padLeft(2, '0')}-${dayhkey.toString().padLeft(2, '0')}'; /// Formatted Date Key: 08-25
      Map<String , dynamic> availability = dateDoctors["MonthTime"];
      // check if the day exit 
      if(availability.containsKey(formattedDateKey)){
        Map<String  , dynamic> hourandBool = availability[formattedDateKey]; // Hour and bool
        // check the bool for hour 
        if(hourandBool.containsKey(hourBook)){
          // Update in Firebase
          String fieldPath = 'MonthTime.$formattedDateKey.$hourBook'; // to chnage the hour and make it ture
          await FirebaseFirestore.instance.collection("Doctors").doc(dateDoctors.id).update({fieldPath: false});
          await FirebaseFirestore.instance.collection("Books").doc(docId).delete();
          emit(CancelScheduleLoaded());
        }
      }
      // Get the key day 
      }
    }
    catch(e){
      emit(CancelScheduleError());
      }
  }
}



// check internet 
enum ConnectivityStatus { online, offline }

class ConnectivityCubit extends Cubit<ConnectivityStatus> {
  final Connectivity connectivity;

  ConnectivityCubit(this.connectivity) : super(ConnectivityStatus.online) {

    connectivity.onConnectivityChanged.listen((result) {
      emit(result.contains(ConnectivityResult.mobile) || result.contains(ConnectivityResult.wifi)
          ? ConnectivityStatus.online
          : ConnectivityStatus.offline);
    });
  }

  Future<void> checkConnectivity() async {
    var result = await connectivity.checkConnectivity();
    emit(result.contains(ConnectivityResult.mobile) || result.contains(ConnectivityResult.wifi)
        ? ConnectivityStatus.online
        : ConnectivityStatus.offline);
  }
}