import 'dart:io';
import 'package:book_dctor/Admin/cubit_admin.dart/cubit_cubit_admin.dart';
import 'package:book_dctor/Admin/cubit_admin.dart/cubit_state_admin.dart';
import 'package:book_dctor/Admin/wigets_admin/choose_date.dart';
import 'package:book_dctor/core/colors.dart';
import 'package:book_dctor/generated/l10n.dart';
import 'package:book_dctor/widgets/button.dart';
import 'package:book_dctor/widgets/general_textfromfiled.dart';
import 'package:book_dctor/widgets/show_dilog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class CreateDoctor extends StatefulWidget {
  const CreateDoctor({super.key});

  @override
  State<CreateDoctor> createState() => _CreateDoctorState();
}

class _CreateDoctorState extends State<CreateDoctor> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerBio = TextEditingController();
  TextEditingController controllerBioAR = TextEditingController();
  TextEditingController controllerBioES = TextEditingController();
  TextEditingController controllerBioJA = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey();

  String titleSP = "Specialization";
  String ratDoctor = "Rating";
  String yeartsEXP = "Experience years";
  File? image;

  @override
  void dispose() {
    controllerName.dispose();
    controllerBio.dispose();
    controllerPrice.dispose();
    controllerBioAR.dispose();
    controllerBioJA.dispose();
    controllerBioES.dispose();
    super.dispose();
  }

// Get Image from Gallrey
  void getImageGellrey() async {
    final imagePicker =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicker != null) {
      setState(() {
        image = File(imagePicker.path);
      });
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Image selection canceled.")));
    }
  }

// Get Image from Camara
  void getImageCamare() async {
    final imagePicker =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (imagePicker != null) {
      setState(() {
        image = File(imagePicker.path);
      });
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar( const SnackBar(content: Text("Image selection canceled.")));
    }
  }

// sheet button to choose Phone
  void sheetButtonPicture(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              margin: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
              height: 220,
              width: MediaQuery.of(context).size.width,
              // Child For all sheet
              child: Column(
                children: [
                  // Text New Profile Picture
                  Container(
                      margin: const EdgeInsets.all(10),
                      child: Text(
                        S.of(context).NewPorfilePicture,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      )),
                  // Button to take photo from gallery
                  ClassButton(
                      textbutton: S.of(context).Gallrey,
                      color: blueMain,
                      onPressed: () {
                        getImageGellrey();
                      }),
                  // Button to take photo from Camara
                  ClassButton(
                      textbutton: S.of(context).Camara,
                      color: blueMain,
                      onPressed: () {
                        getImageCamare();
                      })
                ],
              ));
        });
  }

// show dilog for success
  void showMessageSuccess(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext conttext) {
          return ShowdialogSuccess(
              message: S.of(context).SUccessDoctorMessage,
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("Admin", (route) => false);
              },
              stateImage: "assets/true.blue.png",
              mainText: S.of(context).SuccessDoctorHeadS,
              buttomText: S.of(context).GoBack);
        });
  }

// show dilog for failed
  void showMessageFailed(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ShowdialogSuccess(
              message: S.of(context).FailedDoctorMessageF,
              onPressed: () {
                Navigator.of(context).pop();
              },
              stateImage: "assets/cry.png",
              mainText: S.of(context).FailedDoctorHeadF,
              buttomText: S.of(context).Close);
        });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      S.of(context).Psychologist,
      S.of(context).Orthopedist,
      S.of(context).Physicaltherapy,
      S.of(context).Dermatologist,
      S.of(context).Pediatrician, // kids
      S.of(context).Cardiologist, // heart
      S.of(context).Neurologist // brain
    ];

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.03,
              horizontal: MediaQuery.of(context).size.width * 0.03),
          child: Form(
            key: globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // photo
                Center(
                  child: GestureDetector(
                    onTap: () {
                      sheetButtonPicture(context);
                    },
                    child: Container(
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: ClipOval(
                          child: image != null
                              ? Image.file(
                                  File(image!.path),
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  "assets/user.png",
                                  fit: BoxFit.cover,
                                ),
                        )),
                  ),
                ),

                // name
                Text(
                  S.of(context).Name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: blueMain),
                ),
                GeneralTextfromfiled(
                  heightText: 60,
                  controller: controllerName,
                  color: Colors.blueGrey,
                  maxLength: 25,
                  textInputType: TextInputType.text,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return S.of(context).empty;
                    }
                    return null;
                  },
                ),
                // bio
                Text(
                  S.of(context).Bio,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: blueMain),
                ),
                GeneralTextfromfiled(
                  heightText: 125,
                  controller: controllerBio,
                  color: Colors.blueGrey,
                  maxLength: 250,
                  textInputType: TextInputType.text,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return S.of(context).empty;
                    }
                    if (val.length < 130) {
                      return S.of(context).shortBio;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),



                // AR BIO 
                Text(
                  S.of(context).BioAR,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: blueMain),
                ),
                GeneralTextfromfiled(
                  heightText: 125,
                  controller: controllerBioAR,
                  color: Colors.blueGrey,
                  maxLength: 250,
                  textInputType: TextInputType.text,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return S.of(context).empty;
                    }
                    if (val.length < 130) {
                      return S.of(context).shortBio;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),




                // ES BIO 
                Text(
                  S.of(context).BioES,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: blueMain),
                ),
                GeneralTextfromfiled(
                  heightText: 125,
                  controller: controllerBioES,
                  color: Colors.blueGrey,
                  maxLength: 250,
                  textInputType: TextInputType.text,
                  validator: (val) {
                    if(val!.isEmpty) {
                      return S.of(context).empty;
                    }
                    if(val.length < 130) {
                      return S.of(context).shortBio;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),





                // JA BIO 
                Text(
                  S.of(context).BioJA,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: blueMain),
                ),
                GeneralTextfromfiled(
                  heightText: 125,
                  controller: controllerBioJA,
                  color: Colors.blueGrey,
                  maxLength: 250,
                  textInputType: TextInputType.text,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return S.of(context).empty;
                    }
                    if(val.length < 130) {
                      return S.of(context).shortBio;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),




                // price
                Text(
                  S.of(context).price,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: blueMain),
                ),
                GeneralTextfromfiled(
                  heightText: 60,
                  controller: controllerPrice,
                  color: Colors.blueGrey,
                  textInputType: TextInputType.number,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return S.of(context).empty;
                    }
                    return null;
                  },
                ),
                // note for admin to choose date
                const SizedBox(
                  height: 10,
                ),
                Text(
                  S.of(context).selectDate,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: blueMain),
                ),

                // Specialization
                PopupMenuButton(
                    child: ChooseDateChild(titie: titleSP),
                    onSelected: (String? valueCat) {
                      setState(() {
                        titleSP = valueCat!;
                      });
                    },
                    itemBuilder: (context) => [
                          for (final cat in categories)
                            PopupMenuItem(value: cat, child: Text(cat))
                        ]),

                // rating
                PopupMenuButton(
                    child: ChooseDateChild(titie: ratDoctor),
                    onSelected: (String? valuerat) {
                      setState(() {
                        ratDoctor = valuerat!;
                      });
                    },
                    itemBuilder: (context) => [
                          for (double rat = 0.1; rat <= 5.0; rat += 0.1)
                            PopupMenuItem(
                              value: rat.toStringAsFixed(1),
                              child: Text("⭐ ${rat.toStringAsFixed(1)}"),
                            )
                        ]),

                // exp years
                PopupMenuButton(
                    child: ChooseDateChild(titie: yeartsEXP),
                    onSelected: (String? valuerat) {
                      setState(() {
                        yeartsEXP = valuerat!;
                      });
                    },
                    itemBuilder: (context) => [
                          for (int i = 0; i < 21; i++)
                            PopupMenuItem(
                              value: i.toString(),
                              child: Text("Year $i"),
                            )
                        ]),

                // Save
                const SizedBox(height: 30),
                BlocListener<CreateAnewDcotorCubit, CreateAnewDcotorState>(
                    listener: (context, stateListener) {
                  if (stateListener is CreateAnewLoaded) {
                    showMessageSuccess(context);
                  } else if (stateListener is CreateAnewError) {
                    showMessageFailed(context);
                  }
                }
                    // Loading
                    , child: BlocBuilder<CreateAnewDcotorCubit, CreateAnewDcotorState>(
                  builder: (context, state) {
                    if(state is CreateAnewLoading){
                      return Center(child: Lottie.asset("assets/loding.blue.json" , height: 150 , width: 150));
                    }
                    return ClassButton(
                        textbutton: S.of(context).Save,
                        color: Colors.green,
                        onPressed: () {
                          // First check // name // bio // price
                          if (globalKey.currentState!.validate()) {
                            // check // category
                            if (titleSP == "Specialization") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text(S.of(context).didnTCategory)));
                            }
                            // check // rating
                            else if (ratDoctor == "Rating") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text(S.of(context).didnTrrating)));
                            }
                            // check // years
                            else if (yeartsEXP == "Experience years") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(S.of(context).didnTyears)));
                            }
                            // check image
                            else if (image == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(S.of(context).didnTimage)));
                            }
                            // at this point , you already checked everything
                            // SAVE THE DATE
                            else {
                              String medicalAR = "";
                              String medicalES = "";
                              String medicalJA = "";
                              // give a value 
                              switch (titleSP) {
  case "Psychologist":
    medicalAR = "الأخصائي النفسي";
    medicalES = "Psicólogo";
    medicalJA = "心理学者";
    break;
  case "Orthopedist":
    medicalAR = "أخصائي العظام";
    medicalES = "Ortopedista";
    medicalJA = "整形外科医";
    break;
  case "Physical therapy":
  medicalAR = "العلاج الطبيعي";
  medicalES = "Fisioterapia";
  medicalJA = "理学療法";
    break;
  case "Dermatologist":
  medicalAR = "أخصائي الجلدية";
  medicalES = "Dermatólogo";
  medicalJA = "皮膚科医";
    break;
  case "Pediatrician":
  medicalAR = "طبيب الأطفال";
  medicalES = "Pediatra";
  medicalJA =  "小児科医";
    break;
  case "Neurologist":
  medicalAR = "أخصائي الأعصاب";
  medicalES = "Neurólogo";
  medicalJA = "神経科医";
    break;
  case "Cardiologist":
  medicalAR = "أخصائي القلب";
  medicalES = "Cardiólogo";
  medicalJA = "心臓病専門医";
    break;
  default:
  medicalAR = "";
  medicalES = "";
  medicalJA = "";
    break;
}




                              String name = controllerName.text;
                              String bio = controllerBio.text;
                              String bioAR = controllerBioAR.text;
                              String bioES = controllerBioES.text;
                              String bioJA = controllerBioJA.text;
                              String price = controllerPrice.text;
                              String category = titleSP;
                              String rating = ratDoctor;
                              String expYears = yeartsEXP;
                              context
                                  .read<CreateAnewDcotorCubit>().
                                  createDoctor(name, bio, price, category, bioAR, bioES, bioJA, medicalAR, medicalES, medicalJA, rating, expYears, image);
                            }
                          }
                        });
                  },
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
