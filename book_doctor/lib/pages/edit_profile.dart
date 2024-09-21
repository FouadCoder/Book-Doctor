
import 'dart:io';

import 'package:book_dctor/core/colors.dart';
import 'package:book_dctor/cubit/cubit_cubit.dart';
import 'package:book_dctor/cubit/cubit_state.dart';
import 'package:book_dctor/generated/l10n.dart';
import 'package:book_dctor/widgets/button.dart';
import 'package:book_dctor/widgets/general_textfromfiled.dart';
import 'package:book_dctor/widgets/show_dilog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class EditProfile extends StatefulWidget {

    const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController controllerName = TextEditingController();

  final TextEditingController controllerPhone = TextEditingController();

  final TextEditingController controllerAddress = TextEditingController();

  final TextEditingController controllerMedicalHostory = TextEditingController();

  final TextEditingController controllerCurrentMedical = TextEditingController();

  final TextEditingController controllerGender = TextEditingController();
  bool loadingSave = false;

  @override
void dispose() {
  controllerName.dispose();
  controllerPhone.dispose();
  controllerAddress.dispose();
  controllerMedicalHostory.dispose();
  controllerCurrentMedical.dispose();
  controllerGender.dispose();
  super.dispose();
}
File? image;
// Get Image from Gallrey
void getImageGellrey() async{
final imagePicker = await ImagePicker().pickImage(source: ImageSource.gallery);
if(imagePicker != null){
  setState(() {
    image = File(imagePicker.path);
  });
  if(mounted){
    Navigator.of(context).pop();
  }
  
} else {
  if(mounted){
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(S.of(context).imageCancel)));
  }
} }
// Get Image from Camara 
void getImageCamare() async{
final imagePicker = await ImagePicker().pickImage(source: ImageSource.camera);
if(imagePicker != null){
  setState(() {
    image = File(imagePicker.path);
  });
  if(mounted){
    Navigator.of(context).pop();
  }
  
} else {
  if(mounted){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).imageCancel)));
  }
  
}

}
// sheet button to choose Phone
void sheetButtonPicture (BuildContext context){
  showModalBottomSheet(context: context, builder: (BuildContext context){
    return  Container(
      margin: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(
      topLeft:Radius.circular(20),
      topRight: Radius.circular(20),
        )
        ),
      height: 220 ,
      width: MediaQuery.of(context).size.width,
      // Child For all sheet
    child: Column(
      children: [
        // Text New Profile Picture
        Container(
          margin: const EdgeInsets.all(10),
          child:  Text(S.of(context).NewPorfilePicture, style: const TextStyle(fontSize: 17 , fontWeight: FontWeight.bold),)),
        // Button to take photo from gallery
        ClassButton(textbutton: S.of(context).Gallrey,color:  blueMain,onPressed: (){getImageGellrey();}),
        // Button to take photo from Camara 
        ClassButton(textbutton: S.of(context).Camara, color: blueMain , onPressed: (){getImageCamare();})
      ],
    ));
  });
}
  int? ageSelected;
  String? bloodSelected;
  int? heightSeleced;
  int? weightSeceltd;
  String? gender;
  bool selectGender = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: MediaQuery.of(context).size.height * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Center(
                child: GestureDetector(
                  onTap: (){ sheetButtonPicture(context);},
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle
                    ),
                    child:ClipOval(child:  image != null ? Image.file(File(image!.path) , fit: BoxFit.cover,) : Image.asset("assets/user.png" , fit: BoxFit.cover,),)
                  ),
                ),
              ),
          
          
              const SizedBox(height: 30),
              Text(S.of(context).Name , style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 20 , color: blueMain),),
              GeneralTextfromfiled(heightText: 60,controller: controllerName, color: Colors.blueGrey ,textInputType: TextInputType.name ,maxLength: 25,),
              Text(S.of(context).PhoneNumber , style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 20 , color: blueMain),),
              GeneralTextfromfiled(heightText: 60,controller: controllerPhone, color: Colors.blueGrey , maxLength: 25, textInputType: TextInputType.phone,),
              Text(S.of(context).Address , style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 20 , color: blueMain),),
              GeneralTextfromfiled(heightText: 60,controller: controllerAddress, color: Colors.blueGrey , maxLength: 50, textInputType: TextInputType.streetAddress),
              Text(S.of(context).MedicalHistory , style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 20 , color: blueMain),),
              GeneralTextfromfiled(heightText: 60,controller: controllerMedicalHostory, color: Colors.blueGrey , maxLength: 250, textInputType: TextInputType.text,),
              Text(S.of(context).CurrentMedical , style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 20 , color: blueMain),),
              GeneralTextfromfiled(heightText: 60,controller: controllerCurrentMedical, color: Colors.blueGrey , maxLength: 250, textInputType: TextInputType.text,),
              const SizedBox(height: 10),
          
          // For choose Gender
              Column(
                children: [
                  // Male
                  RadioListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(S.of(context).Male , style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 20),),
                        const SizedBox(width: 10),
                        SizedBox(height: 25,width: 20, child: Image.asset("assets/male1.png"),)
                      ],
                    ),
                    activeColor: blueMain,
                    value: "Male", groupValue: gender, onChanged: (val){
                    setState(() {
                      gender = val;
                      selectGender = true; // to make sure he choose Gender
                    });
                  }) ,
                  // Female
                    RadioListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(S.of(context).Female , style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 20),),
                        const SizedBox(width: 10),
                        SizedBox(height: 25,width: 20, child: Image.asset("assets/female.png"),)
                      ],
                    ),
                    
                    activeColor: blueMain,
                    value: "Female", groupValue: gender, onChanged: (val){
                    setState(() {
                      gender = val;
                      selectGender = true;  // to make sure he choose Gender
                    });
                  })
                ],
              ),
          
                  BlocListener<UpdateProfileCubit,UpdateProfileState>(
                    listener: (context , state) {
                      // Loading
                        if (state is UpdateProfileLoading){setState(() {loadingSave = true ;});}
                      // if the update end successfully
                      else if(state is UpdateProfileLoaded){
                        setState(() {loadingSave = false;});
                        showDialog( barrierDismissible:  false,context: context, builder: (BuildContext context){
                          return ShowdialogSuccess(message: S.of(context).MessageSuccess, onPressed: (){Navigator.of(context).pushNamedAndRemoveUntil("MainPage" , (route)=> false);}, stateImage: "assets/true.blue.png", mainText: S.of(context).Success, buttomText: S.of(context).GoBack);
                        });
                      }
                      // if something goes wrong 
                      else if (state is UpdateProfileError){
                        setState(() {loadingSave = false;});
                        showDialog( barrierDismissible: false,context: context, builder: (BuildContext context){
                          return ShowdialogSuccess(message: S.of(context).MessageWrong, onPressed: (){Navigator.of(context).pushNamedAndRemoveUntil("MainPage" , (route)=> false);}, stateImage: "assets/cry.png", mainText: S.of(context).Failed, buttomText: S.of(context).GoBack);
                        });
                      }
                    }, child: 
                    loadingSave ? 
                    Center(child: Lottie.asset("assets/loding.blue.json" , height: 150 , width: 150)) :
                    ClassButton(textbutton: S.of(context).Save, color: blueMain, onPressed: (){
                      if(selectGender == true){
                        if(controllerName.text.isNotEmpty){
                          if(controllerAddress.text.isNotEmpty){
                            String name = controllerName.text;
                      if(controllerPhone.text.isEmpty){controllerPhone.text = "";}
                      String phoneNumber = controllerPhone.text;
                      String address = controllerAddress.text;
                      if(controllerMedicalHostory.text.isEmpty){controllerMedicalHostory.text = "";}
                      if(controllerCurrentMedical.text.isEmpty){controllerCurrentMedical.text = "";}
                      String medicalHistory = controllerMedicalHostory.text;
                      String currentMedical = controllerCurrentMedical.text;
                      String gender1 = gender!; 
                      context.read<UpdateProfileCubit>().updateProfile(name, phoneNumber, address, medicalHistory, currentMedical, gender1,image);
                          } 
                          // if address is empty 
                          else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).Address), backgroundColor: Colors.red));
                          }
                        } // if name empty 
                        else {ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).AddName), backgroundColor: Colors.red));}
                      }
                      // select gender 
                      else {ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).SelecGender ) , backgroundColor: blueMain,));}
                    }),
                  )
                ],
              ),
          ),
        ),
      );
  } }