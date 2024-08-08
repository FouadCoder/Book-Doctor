// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Arabic`
  String get LanguageArabic {
    return Intl.message(
      'Arabic',
      name: 'LanguageArabic',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get LanguageEnglish {
    return Intl.message(
      'English',
      name: 'LanguageEnglish',
      desc: '',
      args: [],
    );
  }

  /// `Spanish`
  String get LanguageSpanish {
    return Intl.message(
      'Spanish',
      name: 'LanguageSpanish',
      desc: '',
      args: [],
    );
  }

  /// `Japanese`
  String get LanguageJapanese {
    return Intl.message(
      'Japanese',
      name: 'LanguageJapanese',
      desc: '',
      args: [],
    );
  }

  /// `Payment`
  String get Payment {
    return Intl.message(
      'Payment',
      name: 'Payment',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get Language {
    return Intl.message(
      'Language',
      name: 'Language',
      desc: '',
      args: [],
    );
  }

  /// `Favorite`
  String get favourite {
    return Intl.message(
      'Favorite',
      name: 'favourite',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get DarkMode {
    return Intl.message(
      'Dark Mode',
      name: 'DarkMode',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get Logout {
    return Intl.message(
      'Log out',
      name: 'Logout',
      desc: '',
      args: [],
    );
  }

  /// `Create your account`
  String get CreateAccount {
    return Intl.message(
      'Create your account',
      name: 'CreateAccount',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get Profile {
    return Intl.message(
      'Profile',
      name: 'Profile',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get Gender {
    return Intl.message(
      'Gender',
      name: 'Gender',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get Female {
    return Intl.message(
      'Female',
      name: 'Female',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get Male {
    return Intl.message(
      'Male',
      name: 'Male',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get Email {
    return Intl.message(
      'Email',
      name: 'Email',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get Name {
    return Intl.message(
      'Name',
      name: 'Name',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get PhoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'PhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get Address {
    return Intl.message(
      'Address',
      name: 'Address',
      desc: '',
      args: [],
    );
  }

  /// `Medical history`
  String get MedicalHistory {
    return Intl.message(
      'Medical history',
      name: 'MedicalHistory',
      desc: '',
      args: [],
    );
  }

  /// `Current medical`
  String get CurrentMedical {
    return Intl.message(
      'Current medical',
      name: 'CurrentMedical',
      desc: '',
      args: [],
    );
  }

  /// `New Profile Picture`
  String get NewPorfilePicture {
    return Intl.message(
      'New Profile Picture',
      name: 'NewPorfilePicture',
      desc: '',
      args: [],
    );
  }

  /// `Choose from Gallery`
  String get Gallrey {
    return Intl.message(
      'Choose from Gallery',
      name: 'Gallrey',
      desc: '',
      args: [],
    );
  }

  /// `Capture with Camera`
  String get Camara {
    return Intl.message(
      'Capture with Camera',
      name: 'Camara',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get Login {
    return Intl.message(
      'Login',
      name: 'Login',
      desc: '',
      args: [],
    );
  }

  /// `Login in your Account`
  String get LoginInYourAccount {
    return Intl.message(
      'Login in your Account',
      name: 'LoginInYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Create your Account`
  String get SignCreateYouraccunt {
    return Intl.message(
      'Create your Account',
      name: 'SignCreateYouraccunt',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get Password {
    return Intl.message(
      'Password',
      name: 'Password',
      desc: '',
      args: [],
    );
  }

  /// `Login with Google`
  String get LoginGoogle {
    return Intl.message(
      'Login with Google',
      name: 'LoginGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account? `
  String get DontHvaeAccount {
    return Intl.message(
      'Don\'t have an account? ',
      name: 'DontHvaeAccount',
      desc: '',
      args: [],
    );
  }

  /// `Have an account? `
  String get HaveAccount {
    return Intl.message(
      'Have an account? ',
      name: 'HaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signup {
    return Intl.message(
      'Sign up',
      name: 'signup',
      desc: '',
      args: [],
    );
  }

  /// `Sign up with Google`
  String get SignGoogle {
    return Intl.message(
      'Sign up with Google',
      name: 'SignGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Passwork`
  String get ConfirmPassword {
    return Intl.message(
      'Confirm Passwork',
      name: 'ConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Success !`
  String get Success {
    return Intl.message(
      'Success !',
      name: 'Success',
      desc: '',
      args: [],
    );
  }

  /// `Profile update successful! Thank you for keeping your information current`
  String get MessageSuccess {
    return Intl.message(
      'Profile update successful! Thank you for keeping your information current',
      name: 'MessageSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Failed !`
  String get Failed {
    return Intl.message(
      'Failed !',
      name: 'Failed',
      desc: '',
      args: [],
    );
  }

  /// `We encountered an error while updating your profile. Please try again or contact support if the issue persists.`
  String get MessageWrong {
    return Intl.message(
      'We encountered an error while updating your profile. Please try again or contact support if the issue persists.',
      name: 'MessageWrong',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get Save {
    return Intl.message(
      'Save',
      name: 'Save',
      desc: '',
      args: [],
    );
  }

  /// `Go back`
  String get GoBack {
    return Intl.message(
      'Go back',
      name: 'GoBack',
      desc: '',
      args: [],
    );
  }

  /// `Please add your name.`
  String get AddName {
    return Intl.message(
      'Please add your name.',
      name: 'AddName',
      desc: '',
      args: [],
    );
  }

  /// `Please provide your address.`
  String get AddAddress {
    return Intl.message(
      'Please provide your address.',
      name: 'AddAddress',
      desc: '',
      args: [],
    );
  }

  /// `Please select gender.`
  String get SelecGender {
    return Intl.message(
      'Please select gender.',
      name: 'SelecGender',
      desc: '',
      args: [],
    );
  }

  /// `Welcome! `
  String get Welcome {
    return Intl.message(
      'Welcome! ',
      name: 'Welcome',
      desc: '',
      args: [],
    );
  }

  /// `Let's get started by creating your account.`
  String get MakeAcounnt {
    return Intl.message(
      'Let\'s get started by creating your account.',
      name: 'MakeAcounnt',
      desc: '',
      args: [],
    );
  }

  /// `Uh-oh! Looks like our doctors are taking a little nap. Try again soon!`
  String get ErrorMessage {
    return Intl.message(
      'Uh-oh! Looks like our doctors are taking a little nap. Try again soon!',
      name: 'ErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Healthcare Team`
  String get OurDoctors {
    return Intl.message(
      'Healthcare Team',
      name: 'OurDoctors',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get Category {
    return Intl.message(
      'Category',
      name: 'Category',
      desc: '',
      args: [],
    );
  }

  /// `Doctor Details`
  String get DoctorDetails {
    return Intl.message(
      'Doctor Details',
      name: 'DoctorDetails',
      desc: '',
      args: [],
    );
  }

  /// `Biography`
  String get AboutDoctor {
    return Intl.message(
      'Biography',
      name: 'AboutDoctor',
      desc: '',
      args: [],
    );
  }

  /// `Schedules`
  String get Suchedules {
    return Intl.message(
      'Schedules',
      name: 'Suchedules',
      desc: '',
      args: [],
    );
  }

  /// `Schedule`
  String get Schedule {
    return Intl.message(
      'Schedule',
      name: 'Schedule',
      desc: '',
      args: [],
    );
  }

  /// `Available time`
  String get AvailableTime {
    return Intl.message(
      'Available time',
      name: 'AvailableTime',
      desc: '',
      args: [],
    );
  }

  /// `Available`
  String get Available {
    return Intl.message(
      'Available',
      name: 'Available',
      desc: '',
      args: [],
    );
  }

  /// `Not available`
  String get Notavailable {
    return Intl.message(
      'Not available',
      name: 'Notavailable',
      desc: '',
      args: [],
    );
  }

  /// `Read more`
  String get readMore {
    return Intl.message(
      'Read more',
      name: 'readMore',
      desc: '',
      args: [],
    );
  }

  /// `Read less`
  String get readless {
    return Intl.message(
      'Read less',
      name: 'readless',
      desc: '',
      args: [],
    );
  }

  /// `Book Appointment`
  String get Book {
    return Intl.message(
      'Book Appointment',
      name: 'Book',
      desc: '',
      args: [],
    );
  }

  /// `AskDoctorAI`
  String get AskDoctorAI {
    return Intl.message(
      'AskDoctorAI',
      name: 'AskDoctorAI',
      desc: '',
      args: [],
    );
  }

  /// `Oops! It seems like we hit a snag. Don't worry, our team is on it! Please try again soon. Thanks for your patience!`
  String get ErrorINAI {
    return Intl.message(
      'Oops! It seems like we hit a snag. Don\'t worry, our team is on it! Please try again soon. Thanks for your patience!',
      name: 'ErrorINAI',
      desc: '',
      args: [],
    );
  }

  /// `Oops! We couldn't fetch your date. Sorry about that! We're fixing it now.`
  String get ErrorProfile {
    return Intl.message(
      'Oops! We couldn\'t fetch your date. Sorry about that! We\'re fixing it now.',
      name: 'ErrorProfile',
      desc: '',
      args: [],
    );
  }

  /// `Your message didn't come through. Type something and let's chat!`
  String get EmptyMessage {
    return Intl.message(
      'Your message didn\'t come through. Type something and let\'s chat!',
      name: 'EmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `My Favorite Doctors`
  String get FavoriteList {
    return Intl.message(
      'My Favorite Doctors',
      name: 'FavoriteList',
      desc: '',
      args: [],
    );
  }

  /// `Your favorite doctors list is waiting for your personal touch. Add your favorites to keep them close!`
  String get EmptyFavoriteList {
    return Intl.message(
      'Your favorite doctors list is waiting for your personal touch. Add your favorites to keep them close!',
      name: 'EmptyFavoriteList',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Can't fetch the days right now. Please check back soon. Thanks for your patience!`
  String get ErrorGetDays {
    return Intl.message(
      'Oops! Can\'t fetch the days right now. Please check back soon. Thanks for your patience!',
      name: 'ErrorGetDays',
      desc: '',
      args: [],
    );
  }

  /// `Create Your Profile`
  String get create {
    return Intl.message(
      'Create Your Profile',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// ` Please create your profile to book an appointment. This helps us serve you better. Thank you!`
  String get messagecreate {
    return Intl.message(
      ' Please create your profile to book an appointment. This helps us serve you better. Thank you!',
      name: 'messagecreate',
      desc: '',
      args: [],
    );
  }

  /// `Specialty`
  String get Specialty {
    return Intl.message(
      'Specialty',
      name: 'Specialty',
      desc: '',
      args: [],
    );
  }

  /// ` Notes`
  String get Note {
    return Intl.message(
      ' Notes',
      name: 'Note',
      desc: '',
      args: [],
    );
  }

  /// `Years of Experience`
  String get EXP {
    return Intl.message(
      'Years of Experience',
      name: 'EXP',
      desc: '',
      args: [],
    );
  }

  /// `EXP`
  String get expHome {
    return Intl.message(
      'EXP',
      name: 'expHome',
      desc: '',
      args: [],
    );
  }

  /// `Consultation Fee`
  String get price {
    return Intl.message(
      'Consultation Fee',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Please choose both a date and time for your appointment before proceeding.`
  String get ChooseDate {
    return Intl.message(
      'Please choose both a date and time for your appointment before proceeding.',
      name: 'ChooseDate',
      desc: '',
      args: [],
    );
  }

  /// `Your appointment has been successfully booked! We look forward to seeing you.`
  String get SuccessBook {
    return Intl.message(
      'Your appointment has been successfully booked! We look forward to seeing you.',
      name: 'SuccessBook',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong while trying to book your appointment. Please try again later. If the problem persists, contact support for assistance.`
  String get ErrorBookl {
    return Intl.message(
      'Something went wrong while trying to book your appointment. Please try again later. If the problem persists, contact support for assistance.',
      name: 'ErrorBookl',
      desc: '',
      args: [],
    );
  }

  /// `Booking Unsuccessful`
  String get ErrorBookHeadline {
    return Intl.message(
      'Booking Unsuccessful',
      name: 'ErrorBookHeadline',
      desc: '',
      args: [],
    );
  }

  /// `We apologize for the inconvenience. We are actively working to resolve the issue`
  String get ErrorSchedule {
    return Intl.message(
      'We apologize for the inconvenience. We are actively working to resolve the issue',
      name: 'ErrorSchedule',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong while trying to delete the item from your schedule. Please try again later.`
  String get ErrorDeleteSchedule {
    return Intl.message(
      'Oops! Something went wrong while trying to delete the item from your schedule. Please try again later.',
      name: 'ErrorDeleteSchedule',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong while trying to book your appointment. Please try again later.`
  String get ErrorBook {
    return Intl.message(
      'Oops! Something went wrong while trying to book your appointment. Please try again later.',
      name: 'ErrorBook',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get Cancel {
    return Intl.message(
      'Cancel',
      name: 'Cancel',
      desc: '',
      args: [],
    );
  }

  /// `Search for Your Doctor`
  String get FindDoctor {
    return Intl.message(
      'Search for Your Doctor',
      name: 'FindDoctor',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get All {
    return Intl.message(
      'All',
      name: 'All',
      desc: '',
      args: [],
    );
  }

  /// `Psychologist`
  String get Psychologist {
    return Intl.message(
      'Psychologist',
      name: 'Psychologist',
      desc: '',
      args: [],
    );
  }

  /// `Orthopedist`
  String get Orthopedist {
    return Intl.message(
      'Orthopedist',
      name: 'Orthopedist',
      desc: '',
      args: [],
    );
  }

  /// `Physical therapy`
  String get Physicaltherapy {
    return Intl.message(
      'Physical therapy',
      name: 'Physicaltherapy',
      desc: '',
      args: [],
    );
  }

  /// `Dermatologist`
  String get Dermatologist {
    return Intl.message(
      'Dermatologist',
      name: 'Dermatologist',
      desc: '',
      args: [],
    );
  }

  /// `Pediatrician`
  String get Pediatrician {
    return Intl.message(
      'Pediatrician',
      name: 'Pediatrician',
      desc: '',
      args: [],
    );
  }

  /// `Neurologist`
  String get Neurologist {
    return Intl.message(
      'Neurologist',
      name: 'Neurologist',
      desc: '',
      args: [],
    );
  }

  /// `Cardiologist`
  String get Cardiologist {
    return Intl.message(
      'Cardiologist',
      name: 'Cardiologist',
      desc: '',
      args: [],
    );
  }

  /// `Upcoming`
  String get Upcoming {
    return Intl.message(
      'Upcoming',
      name: 'Upcoming',
      desc: '',
      args: [],
    );
  }

  /// `Complete`
  String get Complete {
    return Intl.message(
      'Complete',
      name: 'Complete',
      desc: '',
      args: [],
    );
  }

  /// `Admin Dashboard`
  String get WelcomeAdmin {
    return Intl.message(
      'Admin Dashboard',
      name: 'WelcomeAdmin',
      desc: '',
      args: [],
    );
  }

  /// `Create Doctor Profile`
  String get addNewDoctor {
    return Intl.message(
      'Create Doctor Profile',
      name: 'addNewDoctor',
      desc: '',
      args: [],
    );
  }

  /// `Total appointments`
  String get Books {
    return Intl.message(
      'Total appointments',
      name: 'Books',
      desc: '',
      args: [],
    );
  }

  /// `Users`
  String get Users {
    return Intl.message(
      'Users',
      name: 'Users',
      desc: '',
      args: [],
    );
  }

  /// `Doctors`
  String get Doctors {
    return Intl.message(
      'Doctors',
      name: 'Doctors',
      desc: '',
      args: [],
    );
  }

  /// `Manage Appointment Books`
  String get MangeBooks {
    return Intl.message(
      'Manage Appointment Books',
      name: 'MangeBooks',
      desc: '',
      args: [],
    );
  }

  /// `Books In Progress`
  String get BooksInProgress {
    return Intl.message(
      'Books In Progress',
      name: 'BooksInProgress',
      desc: '',
      args: [],
    );
  }

  /// `Successfully Booked`
  String get SuccessfullyBooked {
    return Intl.message(
      'Successfully Booked',
      name: 'SuccessfullyBooked',
      desc: '',
      args: [],
    );
  }

  /// `Not available`
  String get NOTAVAILABLE {
    return Intl.message(
      'Not available',
      name: 'NOTAVAILABLE',
      desc: '',
      args: [],
    );
  }

  /// `Specialization`
  String get Specialization {
    return Intl.message(
      'Specialization',
      name: 'Specialization',
      desc: '',
      args: [],
    );
  }

  /// `Bio`
  String get Bio {
    return Intl.message(
      'Bio',
      name: 'Bio',
      desc: '',
      args: [],
    );
  }

  /// `You haven't choose yet.`
  String get Youhaventchooseyet {
    return Intl.message(
      'You haven\'t choose yet.',
      name: 'Youhaventchooseyet',
      desc: '',
      args: [],
    );
  }

  /// `Click the button to choose a date`
  String get selectDate {
    return Intl.message(
      'Click the button to choose a date',
      name: 'selectDate',
      desc: '',
      args: [],
    );
  }

  /// `Rating`
  String get rRating {
    return Intl.message(
      'Rating',
      name: 'rRating',
      desc: '',
      args: [],
    );
  }

  /// `Please write at least 5 letters before saving.`
  String get shortName {
    return Intl.message(
      'Please write at least 5 letters before saving.',
      name: 'shortName',
      desc: '',
      args: [],
    );
  }

  /// `Please write at least 170 letters before saving.`
  String get shortBio {
    return Intl.message(
      'Please write at least 170 letters before saving.',
      name: 'shortBio',
      desc: '',
      args: [],
    );
  }

  /// `Please select the number of years of experience before saving.`
  String get ChooseYear {
    return Intl.message(
      'Please select the number of years of experience before saving.',
      name: 'ChooseYear',
      desc: '',
      args: [],
    );
  }

  /// `Please choose a rating before saving.`
  String get ChooseRating {
    return Intl.message(
      'Please choose a rating before saving.',
      name: 'ChooseRating',
      desc: '',
      args: [],
    );
  }

  /// `Please select a specialization before saving.`
  String get ChooseCategory {
    return Intl.message(
      'Please select a specialization before saving.',
      name: 'ChooseCategory',
      desc: '',
      args: [],
    );
  }

  /// `Please write something.`
  String get empty {
    return Intl.message(
      'Please write something.',
      name: 'empty',
      desc: '',
      args: [],
    );
  }

  /// `You didn't choose Specialization`
  String get didnTCategory {
    return Intl.message(
      'You didn\'t choose Specialization',
      name: 'didnTCategory',
      desc: '',
      args: [],
    );
  }

  /// `You didn't choose Rating`
  String get didnTrrating {
    return Intl.message(
      'You didn\'t choose Rating',
      name: 'didnTrrating',
      desc: '',
      args: [],
    );
  }

  /// `You didn't choose years of experience`
  String get didnTyears {
    return Intl.message(
      'You didn\'t choose years of experience',
      name: 'didnTyears',
      desc: '',
      args: [],
    );
  }

  /// `Please upload a photo for the doctor.`
  String get didnTimage {
    return Intl.message(
      'Please upload a photo for the doctor.',
      name: 'didnTimage',
      desc: '',
      args: [],
    );
  }

  /// `Success!`
  String get SuccessDoctorHeadS {
    return Intl.message(
      'Success!',
      name: 'SuccessDoctorHeadS',
      desc: '',
      args: [],
    );
  }

  /// `The doctor has been successfully added to the system.`
  String get SUccessDoctorMessage {
    return Intl.message(
      'The doctor has been successfully added to the system.',
      name: 'SUccessDoctorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Failed`
  String get FailedDoctorHeadF {
    return Intl.message(
      'Failed',
      name: 'FailedDoctorHeadF',
      desc: '',
      args: [],
    );
  }

  /// ` Unable to add new doctor. Please try again, contact support for assistance.`
  String get FailedDoctorMessageF {
    return Intl.message(
      ' Unable to add new doctor. Please try again, contact support for assistance.',
      name: 'FailedDoctorMessageF',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get Close {
    return Intl.message(
      'Close',
      name: 'Close',
      desc: '',
      args: [],
    );
  }

  /// `Add Schedule`
  String get Addschdule {
    return Intl.message(
      'Add Schedule',
      name: 'Addschdule',
      desc: '',
      args: [],
    );
  }

  /// `Failed ,Please try later.`
  String get tryLater {
    return Intl.message(
      'Failed ,Please try later.',
      name: 'tryLater',
      desc: '',
      args: [],
    );
  }

  /// `The schedule has been added successfully 🌟`
  String get SuccessAddDATE {
    return Intl.message(
      'The schedule has been added successfully 🌟',
      name: 'SuccessAddDATE',
      desc: '',
      args: [],
    );
  }

  /// `The date has been successfully removed `
  String get SuccessDeleteSchedule {
    return Intl.message(
      'The date has been successfully removed ',
      name: 'SuccessDeleteSchedule',
      desc: '',
      args: [],
    );
  }

  /// `Use Visa as Default`
  String get PaymentAlways {
    return Intl.message(
      'Use Visa as Default',
      name: 'PaymentAlways',
      desc: '',
      args: [],
    );
  }

  /// `Make Visa your default payment method for faster checkouts.`
  String get titlePayment {
    return Intl.message(
      'Make Visa your default payment method for faster checkouts.',
      name: 'titlePayment',
      desc: '',
      args: [],
    );
  }

  /// `This can't be empty`
  String get Empty {
    return Intl.message(
      'This can\'t be empty',
      name: 'Empty',
      desc: '',
      args: [],
    );
  }

  /// `Passwords don't match.`
  String get donTmatch {
    return Intl.message(
      'Passwords don\'t match.',
      name: 'donTmatch',
      desc: '',
      args: [],
    );
  }

  /// `Password is too weak. Please choose a stronger one.`
  String get weakpassword {
    return Intl.message(
      'Password is too weak. Please choose a stronger one.',
      name: 'weakpassword',
      desc: '',
      args: [],
    );
  }

  /// `Email already in use. Please try another one.`
  String get emailexait {
    return Intl.message(
      'Email already in use. Please try another one.',
      name: 'emailexait',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again later.`
  String get trylater {
    return Intl.message(
      'Something went wrong. Please try again later.',
      name: 'trylater',
      desc: '',
      args: [],
    );
  }

  /// `The password you entered is incorrect. Please try again`
  String get wrongPassword {
    return Intl.message(
      'The password you entered is incorrect. Please try again',
      name: 'wrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `Email not found. Please check or sign up.`
  String get noemailexit {
    return Intl.message(
      'Email not found. Please check or sign up.',
      name: 'noemailexit',
      desc: '',
      args: [],
    );
  }

  /// `Oops! We can't connect right now. Please check your internet and try again.`
  String get nointernet {
    return Intl.message(
      'Oops! We can\'t connect right now. Please check your internet and try again.',
      name: 'nointernet',
      desc: '',
      args: [],
    );
  }

  /// `Unable to Login with Google, Please try later.`
  String get tryagain {
    return Intl.message(
      'Unable to Login with Google, Please try later.',
      name: 'tryagain',
      desc: '',
      args: [],
    );
  }

  /// `Please check your email and complete the verification process. Thank you!`
  String get checkEmail {
    return Intl.message(
      'Please check your email and complete the verification process. Thank you!',
      name: 'checkEmail',
      desc: '',
      args: [],
    );
  }

  /// `Verification Email`
  String get headlinecheck {
    return Intl.message(
      'Verification Email',
      name: 'headlinecheck',
      desc: '',
      args: [],
    );
  }

  /// `Send Verification Link Again`
  String get verifyAgin {
    return Intl.message(
      'Send Verification Link Again',
      name: 'verifyAgin',
      desc: '',
      args: [],
    );
  }

  /// `Please verify your email to complete registration.`
  String get NotVerify {
    return Intl.message(
      'Please verify your email to complete registration.',
      name: 'NotVerify',
      desc: '',
      args: [],
    );
  }

  /// `You have requested a verification email recently. Please give it a bit of time before trying again.`
  String get waitverify {
    return Intl.message(
      'You have requested a verification email recently. Please give it a bit of time before trying again.',
      name: 'waitverify',
      desc: '',
      args: [],
    );
  }

  /// `Verification email sent. Please check your email.`
  String get emailsent {
    return Intl.message(
      'Verification email sent. Please check your email.',
      name: 'emailsent',
      desc: '',
      args: [],
    );
  }

  /// `Email Not Verified`
  String get headlineaskverify {
    return Intl.message(
      'Email Not Verified',
      name: 'headlineaskverify',
      desc: '',
      args: [],
    );
  }

  /// `Your email isn't verified yet. Do you want to verify it now?`
  String get messageaskverify {
    return Intl.message(
      'Your email isn\'t verified yet. Do you want to verify it now?',
      name: 'messageaskverify',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message(
      'Verify',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `Resend verification email in: `
  String get timerEmailresend {
    return Intl.message(
      'Resend verification email in: ',
      name: 'timerEmailresend',
      desc: '',
      args: [],
    );
  }

  /// `Check Verification Status`
  String get checkveifyButton {
    return Intl.message(
      'Check Verification Status',
      name: 'checkveifyButton',
      desc: '',
      args: [],
    );
  }

  /// `Your email has been verified. You can now log in to your account and start using the app.`
  String get successVeirfyMessage {
    return Intl.message(
      'Your email has been verified. You can now log in to your account and start using the app.',
      name: 'successVeirfyMessage',
      desc: '',
      args: [],
    );
  }

  /// `Log In Now`
  String get LoginAfterVerifyButton {
    return Intl.message(
      'Log In Now',
      name: 'LoginAfterVerifyButton',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password? `
  String get ForgotPassword {
    return Intl.message(
      'Forgot Password? ',
      name: 'ForgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please write your email.`
  String get writeEmail {
    return Intl.message(
      'Please write your email.',
      name: 'writeEmail',
      desc: '',
      args: [],
    );
  }

  /// `Rest password link sent! Check your email.`
  String get passwordrestsent {
    return Intl.message(
      'Rest password link sent! Check your email.',
      name: 'passwordrestsent',
      desc: '',
      args: [],
    );
  }

  /// `The email must end with '@gmail.com'`
  String get endEmailAddress {
    return Intl.message(
      'The email must end with \'@gmail.com\'',
      name: 'endEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Your password should be at least 8 characters long.`
  String get morethanA8 {
    return Intl.message(
      'Your password should be at least 8 characters long.',
      name: 'morethanA8',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect email or password. Please try again.`
  String get worngemailorpassword {
    return Intl.message(
      'Incorrect email or password. Please try again.',
      name: 'worngemailorpassword',
      desc: '',
      args: [],
    );
  }

  /// `Too many login attempts. Please try again later.`
  String get toomanyrequst {
    return Intl.message(
      'Too many login attempts. Please try again later.',
      name: 'toomanyrequst',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get Dark {
    return Intl.message(
      'Dark',
      name: 'Dark',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get Light {
    return Intl.message(
      'Light',
      name: 'Light',
      desc: '',
      args: [],
    );
  }

  /// `Years exp`
  String get years {
    return Intl.message(
      'Years exp',
      name: 'years',
      desc: '',
      args: [],
    );
  }

  /// `Ask Ai Doctor`
  String get askDoctorAI {
    return Intl.message(
      'Ask Ai Doctor',
      name: 'askDoctorAI',
      desc: '',
      args: [],
    );
  }

  /// `Image selection canceled.`
  String get imageCancel {
    return Intl.message(
      'Image selection canceled.',
      name: 'imageCancel',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'ja'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
