import 'package:book_dctor/core/colors.dart';
import 'package:book_dctor/cubit/cubit_cubit.dart';
import 'package:book_dctor/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SheetbuttonLanguage extends StatefulWidget {
  const SheetbuttonLanguage({super.key});

  @override
  State<SheetbuttonLanguage> createState() => _SheetbuttonLanguageState();
}

class _SheetbuttonLanguageState extends State<SheetbuttonLanguage> {
// to make void work every time open the sheet 
  @override
  void initState(){
    super.initState();
    getCurrentLanguage();
  }
String? language;
  // get the current language
  void getCurrentLanguage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      language = sharedPreferences.getString("Language");
    });
  }
  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: const EdgeInsets.all(10),
      height: 300,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(child: Column(
        children: [
          // English
          RadioListTile(
            title: Text(S.of(context).LanguageEnglish), activeColor: blueMain,
            value: "en", groupValue: language, onChanged: (val){
              setState(() {
                language = val;
              });
              context.read<LanguageCubit>().updateLanguage(language!);
            }),
            // Arabic
            RadioListTile(
            title: Text(S.of(context).LanguageArabic), activeColor: blueMain,
            value: "ar", groupValue: language, onChanged: (val){
              setState(() {
                language = val;
              });
              context.read<LanguageCubit>().updateLanguage(language!);
            }),
            // spanish
            RadioListTile(
            title: Text(S.of(context).LanguageSpanish), activeColor: blueMain,
            value: "es", groupValue: language, onChanged: (val){
              setState(() {
                language = val;
              });
              context.read<LanguageCubit>().updateLanguage(language!);
            }),
            // Japanese
            RadioListTile(
            title: Text(S.of(context).LanguageJapanese), activeColor: blueMain,
            value: "ja", groupValue: language, onChanged: (val){
              setState(() {
                language = val;
              });
              context.read<LanguageCubit>().updateLanguage(language!);
            })
        ],
      )),
    );
  }
}