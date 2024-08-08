import 'package:book_dctor/Admin/create_doctor.dart';
import 'package:book_dctor/Admin/cubit_admin.dart/cubit_cubit_admin.dart';
import 'package:book_dctor/Admin/doctors_list.dart';
import 'package:book_dctor/Admin/main_admin.dart';
import 'package:book_dctor/auth/login.dart';
import 'package:book_dctor/auth/service.dart';
import 'package:book_dctor/auth/sign_in.dart';
import 'package:book_dctor/cubit/cubit_cubit.dart';
import 'package:book_dctor/cubit/cubit_state.dart';
import 'package:book_dctor/generated/l10n.dart';
import 'package:book_dctor/pages/chat.dart';
import 'package:book_dctor/pages/edit_profile.dart';
import 'package:book_dctor/pages/favorite.dart';
import 'package:book_dctor/pages/home.dart';
import 'package:book_dctor/pages/inside_profile.dart';
import 'package:book_dctor/pages/mainpage.dart';
import 'package:book_dctor/pages/no_internet.dart';
import 'package:book_dctor/pages/profile.dart';
import 'package:book_dctor/pages/verify_email.dart';
import 'package:book_dctor/payment/strip_keys.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  ThemeData currentMode = await openInitial(); // to get the current mode
  Stripe.publishableKey = PaymentKeys.apiPublish;
  runApp(MyApp(initializeApp: currentMode));
}

// to get the current mode
Future<ThemeData> openInitial() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String? mood = sharedPreferences.getString("Mode");

  if (mood == "Dark") {
    return ThemeData(brightness: Brightness.dark);
  } else if (mood == "Light") {
    return ThemeData(brightness: Brightness.light);
  } else {
    return ThemeData(brightness: Brightness.dark);
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required initializeApp});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
          BlocProvider<LanguageCubit>(create: (context) => LanguageCubit()),
          BlocProvider<GetprofileDateCubit>(
              create: (context) => GetprofileDateCubit()),
          BlocProvider<UpdateProfileCubit>(
              create: (context) => UpdateProfileCubit()),
          BlocProvider<DoctorsdateCubit>(
              create: (context) => DoctorsdateCubit()),
          BlocProvider<FavoriteDoctorsCubit>(
              create: (context) => FavoriteDoctorsCubit()),
          BlocProvider<HourAvailableCubit>(
              create: (context) => HourAvailableCubit()),
          BlocProvider<BookDoctorCubit>(create: (context) => BookDoctorCubit()),
          BlocProvider<ProfileUsersADCubit>(
              create: (context) => ProfileUsersADCubit()),
          BlocProvider<BooksADCubit>(create: (context) => BooksADCubit()),
          BlocProvider<CreateAnewDcotorCubit>(
              create: (context) => CreateAnewDcotorCubit()),
          BlocProvider<CreateDateDoctorCubit>(
              create: (context) => CreateDateDoctorCubit()),
          BlocProvider<CancelScheduleCubit>(
              create: (context) => CancelScheduleCubit()),
          BlocProvider<ConnectivityCubit>(
              create: (context) => ConnectivityCubit(Connectivity())),
        ],
        // For them
        child: BlocBuilder<ThemeCubit, ThemeData>(
          builder: (context, stateThem) {
            // For Language
            return BlocBuilder<LanguageCubit, LanguageState>(
                builder: (context, stateLanguage) {

                  // get systeam language
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
              String language = systeamLanguage(); // to get the systeam language 
              if (stateLanguage is LanguageSelected) {
                language = stateLanguage.language;
              }
              return BlocBuilder<ConnectivityCubit, ConnectivityStatus>(
                builder: (context, stateInternet) {
                  if(stateInternet == ConnectivityStatus.offline){
                    return const NoInternet();
                  }
                  return MaterialApp(
                      // To make the app suitable for every language
                      locale: Locale(language),
                      localizationsDelegates: const [
                        S.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      supportedLocales: S.delegate.supportedLocales,
                      theme: stateThem,
                      debugShowCheckedModeBanner: false,
                      home: const CheckAcuuontAuth(),
                      routes: {
                        "InsideProfile": (context) => const InsideProfile(),
                        "Profile": (context) => const Profile(),
                        "EditProfile": (context) => const EditProfile(),
                        "MainPage": (context) => const MainPage(),
                        "Login": (context) => const Login(),
                        "Sign": (context) => const SignIn(),
                        "Home": (context) => const Home(),
                        "Chat": (context) => const Chat(),
                        "Favorite": (context) => const Favorite(),
                        "Admin": (context) => const MainAdmin(),
                        "CreateDoctor": (context) => const CreateDoctor(),
                        "DoctorsAdmin": (context) => const DoctorsList(),
                        "VerifyEmail" : (context) => const VerifyEmail()
                      });
                },
              );
            });
          },
        ));
  }
}
