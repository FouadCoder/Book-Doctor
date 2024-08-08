import 'package:book_dctor/core/colors.dart';
import 'package:book_dctor/cubit/cubit_cubit.dart';
import 'package:book_dctor/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditSheetDARK extends StatefulWidget {
  const EditSheetDARK({super.key});

  @override
  State<EditSheetDARK> createState() => _EditSheetDARKState();
}

class _EditSheetDARKState extends State<EditSheetDARK> {

// to work every time I go to sheet to chnage the DARK MOOD
  @override
  void initState(){
    super.initState();
    getTheCurrnetMood();
  }
  // to get The currnetMood
  String? darkMood;
  void getTheCurrnetMood () async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      darkMood = sharedPreferences.getString("Mode");
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      // Dark
            RadioListTile(title: Text(S.of(context).Dark), activeColor: blueMain,
              value: "Dark", groupValue: darkMood, onChanged: (val){setState(() {
                darkMood = val;
              });
              context.read<ThemeCubit>().updateThem((val!));
              }),
              // Light
            RadioListTile(title: Text(S.of(context).Light),activeColor: blueMain,
              value: "Light", groupValue: darkMood, onChanged: (val){setState(() {
                darkMood = val;
              });
              context.read<ThemeCubit>().updateThem((val!));
              }),
          ],
        ),
      ),
    );
  }
}