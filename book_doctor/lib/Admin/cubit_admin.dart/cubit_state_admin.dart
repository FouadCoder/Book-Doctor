import 'package:cloud_firestore/cloud_firestore.dart';

// get profile date 
abstract class ProfileUsersADState{}
class ProfileUsersADinitial extends ProfileUsersADState{}
class ProfileUsersADLoading extends ProfileUsersADState{}
class ProfileUsersADLoaded extends ProfileUsersADState{
  List<QueryDocumentSnapshot> profileDate;
  ProfileUsersADLoaded(this.profileDate);
}
class ProfileUsersADError extends ProfileUsersADState{}

// get books 
abstract class BooksADState{}
class BooksADInitial extends BooksADState{}
class BooksADLoading extends BooksADState{}
class BooksADLoaded extends BooksADState{
  List<QueryDocumentSnapshot> booksDate;
  BooksADLoaded(this.booksDate);
}
class BooksADError extends BooksADState{}

// create a new profile doctor 
abstract class CreateAnewDcotorState{}
class CreateAnewInitial extends CreateAnewDcotorState{}
class CreateAnewLoading extends CreateAnewDcotorState{}
class CreateAnewLoaded extends CreateAnewDcotorState{}
class CreateAnewError extends CreateAnewDcotorState{}

// Create a schdule for a year or some monthes 
abstract class CreateDateDoctorState{}
class CreateDateDoctorInitial extends CreateDateDoctorState{}
class CreateDateDoctorLoading extends CreateDateDoctorState{}
class CreateDateDoctorLoaded extends CreateDateDoctorState{}
class CreateDateDoctorError extends CreateDateDoctorState{}