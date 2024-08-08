import 'dart:io';

import 'package:book_dctor/Admin/cubit_admin.dart/cubit_state_admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
// get profile users 
class ProfileUsersADCubit extends Cubit<ProfileUsersADState>{
  ProfileUsersADCubit() : super(ProfileUsersADinitial());

  void getProfile() async {
    try{
      emit(ProfileUsersADLoading());
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("Users").get();
      if(querySnapshot.docs.isNotEmpty){
        final dateprofile = querySnapshot.docs;
        emit(ProfileUsersADLoaded(dateprofile));
      } else{
        emit(ProfileUsersADError());
      }
    }
    catch(e){
      emit(ProfileUsersADError());
    }
    
  }
}

// get books 
class BooksADCubit extends Cubit<BooksADState>{
  BooksADCubit(): super(BooksADInitial());


  void booksDate() async {
    try{
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("Books").get();
      if(querySnapshot.docs.isNotEmpty){
        final booksdate = querySnapshot.docs;
        emit(BooksADLoaded(booksdate));
      } else{
        emit(BooksADError());
      }
    }
    catch(e){
      emit(BooksADError());
    }
  }
}

// create a new profile of doctor 
class CreateAnewDcotorCubit extends Cubit<CreateAnewDcotorState>{
  CreateAnewDcotorCubit() : super(CreateAnewInitial());


  void createDoctor(
    String name,
    String bio,
    String price,
    String category,
    String rating,
    String expYears,
    File? image
  ) async {
    var uuid = const Uuid();
    String uniqueId = uuid.v4();
    // add the date
    try{
      emit(CreateAnewLoading());
      String? imageURL;
      if(image != null){
        String fileName = "DoctorPictrue$uuid";
        var storugFire = FirebaseStorage.instance.ref("doctorsPic/$fileName");
        await storugFire.putFile(image);
        imageURL = await storugFire.getDownloadURL();
      }
      await FirebaseFirestore.instance.collection("Doctors").add({
      "name" : name ,
      "price" : price,
      "exp" : expYears,
      "Bio" : bio,
      "rating" : rating,
      "Medical" : category,
      "id" : uniqueId,
      "Image" : imageURL
    });
    emit(CreateAnewLoaded());
    }
    catch(e){
      emit(CreateAnewError());
    }
  }
}

// make a month or more for each doctor 
class CreateDateDoctorCubit extends Cubit<CreateDateDoctorState>{
  CreateDateDoctorCubit() : super(CreateDateDoctorInitial());

  void getAvailableDays (String idDoctor) async {
    try{
      // Get date for doctor 
      emit(CreateDateDoctorLoading());
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("Doctors")
    .where("id" , isEqualTo: idDoctor).get();
    final availableGet = querySnapshot.docs.first;
    Map<String , dynamic> available = availableGet["Available"];
    // make a check 
    if(available.isNotEmpty){
          // YEAR // MONTH // DAY
    DateTime now = DateTime.now();
    DateTime startMonth = DateTime(now.year , now.month , now.day);
    DateTime endMonth = DateTime(now.year + 1 , 1 , 0 );


    // LOOP FOR
    // Day          //Hour  // false
    Map<String , Map<String, bool>> doctorMonth = {}; // List to add the date 
    // to get the all days of month 
    for(DateTime date = startMonth; date.isBefore(endMonth);date = date.add(const Duration(days: 1))){
      String dayOfWeek = DateFormat('EEEE').format(date); // Day like Friday or sunday ...

//The key will be the days on Available Map 
      // here you say if the key from Available is = dayOfweek , add them 
      if(available.containsKey(dayOfWeek)){
        // dayofWeek these is days , so he check if the same day 
        // like if friday and of dayofweek and he found the key of available the same
        // at this point , he will get the date // like 25/1 , and will add the date on dateStr
        String dateStr = DateFormat('MM-dd').format(date);
      // You have two maps , here you add the first one , that days 
      //01-28: {} , that's how it looks
      doctorMonth[dateStr] = {};
      // Another for 
      for(String time in available[dayOfWeek]){
        // here you add hours and make all of them false
        doctorMonth[dateStr]![time] = false;
      }
      }
    } // end of for 
    // Update // Or Add 
    if(querySnapshot.docs.isNotEmpty){
      FirebaseFirestore.instance.collection("Doctors").doc(querySnapshot.docs.first.id).update({
        "MonthTime" : doctorMonth
      });
    }
    emit(CreateDateDoctorLoaded());
    } else {
      // here if available was empty 
      emit(CreateDateDoctorError());
    }
    }
    catch(e){
      emit(CreateDateDoctorError());
    }
  }
}