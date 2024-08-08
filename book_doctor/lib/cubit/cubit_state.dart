
// Language


import 'package:cloud_firestore/cloud_firestore.dart';

abstract class LanguageState{}
class LanguageInitial extends LanguageState{}
class LanguageSelected extends LanguageState{

  String language;
  LanguageSelected(this.language);
}

// Get date user 
abstract class GetprofileDateState{}
class GetprofileDateInitial extends GetprofileDateState{}
class GetprofileDateLoading extends GetprofileDateState{}
class GetprofileDateLoaded extends GetprofileDateState{
  List<QueryDocumentSnapshot> userdate;
  GetprofileDateLoaded(this.userdate);
}
class GetprofileDateError extends GetprofileDateState{}
class GetprofileDateEmpty extends GetprofileDateState{}

//Update or Add date profile 
abstract class UpdateProfileState{}
class UpdateProfileInitial extends UpdateProfileState{}
class UpdateProfileLoading extends UpdateProfileState{}
class UpdateProfileLoaded extends UpdateProfileState{}
class UpdateProfileError extends UpdateProfileState{}

// Get date of doctors 
abstract class DoctorsdateState{}
class DoctorsdateInitial extends DoctorsdateState{}
class DoctorsdateLoading extends DoctorsdateState{}
class DoctorsdateLoaded extends DoctorsdateState{
List<QueryDocumentSnapshot> doctorsList;
  DoctorsdateLoaded(this.doctorsList);
}
class DoctorsdateError extends DoctorsdateState{}

// To get and update and delete Date form Favorite List
abstract class FavoriteDoctorsState{}
class FavoriteDoctorsInitial extends FavoriteDoctorsState{}
class FavoriteDoctorsLoading extends FavoriteDoctorsState{}
class FavoriteDoctorsLoaded extends FavoriteDoctorsState{
  List favorite;
  FavoriteDoctorsLoaded(this.favorite);
}
class FavoriteDoctorsError extends FavoriteDoctorsState{}
class FavoriteDoctorsEmptyList extends FavoriteDoctorsState{}

// Get the available date for every doctor , days and horus 
abstract class AvailableDaysState {}
class AvailableDaysInitial extends AvailableDaysState{}
class AvailableDaysLoading extends AvailableDaysState{}
class AvailableDaysLoaded extends AvailableDaysState{
  List day;
  AvailableDaysLoaded(this.day);
}
class AvailableDaysError extends AvailableDaysState{}

// get hours for doctors 
abstract class HourAvailableState{}
class HourAvailableInitial extends HourAvailableState{}
class HourAvailableLoading extends HourAvailableState{}
class HourAvailableLoaded extends HourAvailableState{
  String keyDay;
  String idDctor;
  List hours;
  HourAvailableLoaded(this.hours,this.keyDay , this.idDctor);
}
class HourAvailableError extends HourAvailableState{}
class HourAvailableStop extends HourAvailableState{
}

// BOOK A DATE 
abstract class BookDoctorState{}
class BookDoctorInitial extends BookDoctorState{}
class BookDoctorLoading extends BookDoctorState{}
class BookDoctorLoaded extends BookDoctorState{}
class BookDoctorError extends BookDoctorState{}

// cancel date in schedule 
abstract class CancelScheduleState{}
class CancelScheduleInitial extends CancelScheduleState{}
class CancelScheduleLoading extends CancelScheduleState{}
class CancelScheduleLoaded extends CancelScheduleState{}
class CancelScheduleError extends CancelScheduleState{}


