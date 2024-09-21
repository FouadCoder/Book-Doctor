
import 'package:book_dctor/core/colors.dart';
import 'package:book_dctor/cubit/cubit_cubit.dart';
import 'package:book_dctor/cubit/cubit_state.dart';
import 'package:book_dctor/generated/l10n.dart';
import 'package:book_dctor/payment/strip_manger.dart';
import 'package:book_dctor/widgets/button.dart';
import 'package:book_dctor/widgets/daysbook.dart';
import 'package:book_dctor/widgets/hourbook.dart';
import 'package:book_dctor/widgets/show_dilog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MoreInfoDotor extends StatefulWidget {
  final List doctors;
  final int indexDoctors;

  const MoreInfoDotor({super.key, required this.doctors, required this.indexDoctors});

  @override
  State<MoreInfoDotor> createState() => _MoreInfoDotorState();
}

class _MoreInfoDotorState extends State<MoreInfoDotor> {
  bool redText = false; // for read more or less
  int? isSelected; // day 
  int? isSelectedHour; // hour
  bool trueDay = false;
  bool trueHour = false;
  // two value for to know what the user choose like day and hour to send them to server 
  String? daybookUser;
  String? hourbookUser;
  // for select index // DAY
  void ontapItem( int index , String selectDay){
    setState(() {
      isSelected = index;
      trueDay = true; // to make sure user choose any day before book
      daybookUser = selectDay;
      isSelectedHour = null; // if user change the day that will make it null
    });
  }
  // for select index // HOUR
    void ontapItemHour( int index ,String selectHour){
    setState(() {
      isSelectedHour = index;
      trueHour = true;
      hourbookUser = selectHour;
    });
  }
  // book successfully
  void showDialogFORBook(BuildContext context){
    showDialog( barrierDismissible: false,context: context, builder: (BuildContext context)=>
      ShowdialogSuccess(message: S.of(context).SuccessBook, onPressed: (){Navigator.of(context).pushNamedAndRemoveUntil("MainPage", (route)=> false);}, stateImage: "assets/true.blue.png", mainText: S.of(context).Success, buttomText: S.of(context).GoBack));
  }
  // error in book 
  void showDialogErrorBook(BuildContext context){
    showDialog(context: context, builder: (BuildContext context)=> 
    ShowdialogSuccess(message: S.of(context).ErrorBookl, onPressed: (){Navigator.of(context).pop();}, stateImage: "assets/cry.png", mainText: S.of(context).ErrorBookHeadline, buttomText: S.of(context).GoBack));
  }
  // if user have no profile
  void showDialogProfile(BuildContext context){
    showDialog(context: context, builder: (BuildContext context){
    return ShowdialogSuccess(message: S.of(context).messagecreate, onPressed: (){
    Navigator.of(context).pushNamed("InsideProfile");
    }, stateImage: "assets/person.png", mainText: S.of(context).create, buttomText: S.of(context).Profile);
                        });
  }



  @override
  Widget build(BuildContext context) {
    Locale currentLocale = Localizations.localeOf(context);
    final idDoctorA = widget.doctors[widget.indexDoctors]["id"];
    // to get the correct language from the server 
    String getBio(){
      switch(currentLocale.languageCode){
        case "en" : 
        return widget.doctors[widget.indexDoctors]["Bio"] ?? "";
        case "ar" : 
        return widget.doctors[widget.indexDoctors]["BioAR"] ?? "";
        case "ja" : 
        return widget.doctors[widget.indexDoctors]["BioJA"] ?? "";
        case "es" : 
        return widget.doctors[widget.indexDoctors]["BioES"] ?? "";
        default : return widget.doctors[widget.indexDoctors]["Bio"] ?? "";
      }
    }
    // get the current medical
    String getMedical(){
                          switch(currentLocale.languageCode){
                            case "ar" : 
                            return   widget.doctors[widget.indexDoctors]["MedicalAR"] ?? "";
                            case "ja" : 
                            return     widget.doctors[widget.indexDoctors]["MedicalJA"] ?? "";
                            case "es" : 
                            return     widget.doctors[widget.indexDoctors]["MedicalES"] ?? "";
                            default : return widget.doctors[widget.indexDoctors]["Medical"] ?? "";
                          }
                        }
    // To give the item the s



    return Scaffold(
      appBar: AppBar(backgroundColor: blueMain,title: Text(S.of(context).DoctorDetails , style: const TextStyle(fontWeight: FontWeight.bold), ) ,centerTitle: true,),
      body: ListView(
        children: [
          Stack(
            children: [
              // Blue Color
              Container(
                decoration: const BoxDecoration(
                  color: blueMain,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(22),
                    bottomRight: Radius.circular(22)
                  )
                ),
                height: 80,
                width: MediaQuery.of(context).size.width,
              ) ,
          
              // Colum for everything
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.03,
                  vertical: MediaQuery.of(context).size.height * 0.01
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                const SizedBox(height: 30),
                // Image
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child:  ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl:widget.doctors[widget.indexDoctors]["Image"] ,
                                    placeholder: (context , url) => const CircularProgressIndicator(color: blueMain),
                                    fit: BoxFit.cover,),
                                ),
                      ),
                      // Name 
                      const SizedBox(height: 10),
                      Text("Dr.${widget.doctors[widget.indexDoctors]["name"]} " , style: const TextStyle(fontWeight: FontWeight.bold , color: blueMain , fontSize: 22),  overflow: TextOverflow.ellipsis,),
                      // Mediacl work 
                      const SizedBox(height: 5,),
                      Text(getMedical() , style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 15),  overflow: TextOverflow.ellipsis,),
                    ],
                  ), // End or Colum for Image and name 
                ),
                const SizedBox(height: 35),
                Text(S.of(context).AboutDoctor , style: const TextStyle(fontSize: 20 , fontWeight: FontWeight.bold , color: blueMain),),
                const SizedBox(height: 5,),
                // Text for bio details
                Text( getBio() , style: const TextStyle(fontSize: 15), maxLines: redText ? null : 2),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      redText = !redText;
                    });
                  },
                  child: Text(redText ? S.of(context).readless :S.of(context).readMore , style: const TextStyle(fontWeight: FontWeight.w600, color:  blueMain),)
                ),
                // Specialty
                const SizedBox(height: 20),
                Text(S.of(context).Specialty , style: const TextStyle(fontSize: 20 , fontWeight: FontWeight.bold , color: blueMain),) ,
                const SizedBox(height: 10,),
                Column(children: [
                  // PRICE
                  Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text(S.of(context).price ,style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 16), ) , Text("\$${widget.doctors[widget.indexDoctors]["price"]}", style: const TextStyle(fontWeight: FontWeight.bold , color: blueMain,fontSize: 16) ,)],),
                  const SizedBox(height: 5) ,
                  // EXP
                  Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text(S.of(context).EXP ,style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 16), ) , Text(widget.doctors[widget.indexDoctors]["exp"], style: const TextStyle(fontWeight: FontWeight.bold , color: blueMain,fontSize: 16) ,)],),
                ],),
                // Schedules 
                const SizedBox(height: 20),
                Text(S.of(context).Schedule , style: const TextStyle(fontSize: 20 , fontWeight: FontWeight.bold , color: blueMain),) ,
                          
                // Days
                
                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("Doctors")
                  .where("id" , isEqualTo: idDoctorA).snapshots(),
                  builder: (context , snapshotDate){
                    if(snapshotDate.hasData){
                      final datedays = snapshotDate.data!.docs.first;
                      // check if monthTime is exsit oe not 
                      Map<String , dynamic> availability = datedays.data().containsKey("MonthTime") ?
                      datedays["MonthTime"] : {};
                      List days = [];
    // current date
                      DateTime currnetDate = DateTime(DateTime.now().year , DateTime.now().month , DateTime.now().day);
                      DateTime onlyMonthdate = currnetDate.add(const Duration(days: 30)); // to get only 30 days of date 
        // the value in every key for Days
                      for(final keyAVA in availability.keys){
      // Here you got the hours to check if true or not 
                          bool dayChecked = false; // this one to make sure that not the same day will add twice 
                          Map<String , dynamic> daySort = availability[keyAVA]; // hours and bool 
                          for(final keyHour in daySort.keys){
                            final boolK = daySort[keyHour]; // Bool for each hour if false or true
          // if day is true , that mean there someone booked the date 
                            if(boolK == false && !dayChecked){
        // Here you get the days and month 
                          List dateFor = keyAVA.split("-");
                          int monthint = int.parse(dateFor[0]); // month
                          int dayInt = int.parse(dateFor[1]); // day 
        // to get date that after currnet date or same day 
                          DateTime date = DateTime(currnetDate.year , monthint , dayInt);
        // check days 
                          if(date.isAfter(currnetDate) && date.isBefore(onlyMonthdate ) || date.isAtSameMomentAs(currnetDate)){
                          String finalday = "$monthint / $dayInt";
                          days.add({"day" : finalday , "key" : keyAVA});
                          dayChecked = true;
        }
        } // end of for hours
        }
        } // end of for days 
    // Sort the list
    days.sort((a, b) => a["key"].compareTo(b["key"]));

    // retrun days
                    return SizedBox(
                      height: 100,
                      child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: days.length,
                            itemBuilder: (context , index){
                              String idKey = days[index]["key"];
                              String day =  days[index]["day"];
                              return DaysBook( days: day, index: index ,
                                idDoctor: idDoctorA , keyDay: idKey,
                                isSelected: isSelected == index, onItemSelect: ontapItem);
                            }),
                    );}



                    else if(snapshotDate.hasError){return Center(child: Column(children: [Text(S.of(context).ErrorGetDays)],),);}
                    else if(snapshotDate.connectionState == ConnectionState.waiting){return Center(child: Lottie.asset("assets/loding.blue.json" , height: 100 , width: 100));}
                    return Container(); // if there nothing , will retrun this 
                  }),
                          
                          

                          
                 // Text Available 
                  const SizedBox(height: 20),
                  Text(S.of(context).AvailableTime , style: const TextStyle(fontSize: 20 , fontWeight: FontWeight.bold , color: blueMain),) ,
                  const SizedBox(height: 10),
                  // Hour
                  BlocBuilder<HourAvailableCubit,HourAvailableState>(
                    builder: (context , stateHour) {
                      // Loading
                      if(stateHour is HourAvailableLoaded){
                        final hoursList = stateHour.hours;
                        return SizedBox(height: 100, child:
                        ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: hoursList.length,
                          itemBuilder: (context, index){
                            String hour = hoursList[index];
                            return  Hourbook(hours: hour , index: index , isSelected: index == isSelectedHour, ontap: ontapItemHour);
                          }));
                      } 
                      return Container();
                    }
                  ) ,
                          
                          
                          
                          
                // Book Button 
                const SizedBox(height: 30,),
                BlocListener<BookDoctorCubit , BookDoctorState>(
                listener: (context , state) {
                    if(state is BookDoctorLoaded){
                  showDialogFORBook(context);
                  } else if (state is BookDoctorError){
                    showDialogErrorBook(context);
                  } 
                    // child for listner // Builder for loading 
                  },child: BlocBuilder<BookDoctorCubit, BookDoctorState>(
                    builder: (context, stateBloc) {
                      if(stateBloc is BookDoctorLoading){
                        return Center(child: Lottie.asset("assets/loding.blue.json" , height: 150 , width: 150));
                      } else {
                        return ClassButton(
                                      textbutton: S.of(context).Book, color: blueMain, onPressed: () async {
                                        // check if he have make account or not
                                        String userId = FirebaseAuth.instance.currentUser!.uid;
                                        final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
                                        try{
                                          QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("Users")
                                          .where("UserId" , isEqualTo:  userId).get();
                                          // if empty , show doilg to take him Porfile
                                          if(querySnapshot.docs.isEmpty){
                                            // ignore: use_build_context_synchronously
                                            showDialogProfile(context);
                                            // if user has account make the book
                                          } else{
                                            // check if he choose the hour and the day 
                                            if(trueDay == true && trueHour == true){
                                              // Get the payment way first 
                                              String payment = "";
                                              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                              bool? paymentState = sharedPreferences.getBool("VisaState");
                                              if(paymentState == null || paymentState == false){
                                                payment = "Cash";
                                              } else if(paymentState == true){
                                                payment = "Visa";
                                              } else{
                                                payment = "Cash";
                                              }
                  
                  
                                            final userDate = querySnapshot.docs.first;
                                            // Date of user 
                                            String name = userDate["name"];
                                            String address = userDate["Address"];
                                            String gender = userDate["Gender"];
                                            String medicalHistory = userDate["Medical History"];
                                            String currentMedical = userDate["Current Medical"];
                                            String phoneNumber = userDate["Phone Number"];
                                            // date of doctor 
                                            String doctorName = widget.doctors[widget.indexDoctors]["name"];
                                            String idDoctor = widget.doctors[widget.indexDoctors]["id"];
                                            String medical = widget.doctors[widget.indexDoctors]["Medical"];
                                            String medicalAR = widget.doctors[widget.indexDoctors]["MedicalAR"];
                                            String medicalES = widget.doctors[widget.indexDoctors]["MedicalES"];
                                            String medicalJA = widget.doctors[widget.indexDoctors]["MedicalJA"];
                                            String price = widget.doctors[widget.indexDoctors]["price"];
                                            String image = widget.doctors[widget.indexDoctors]["Image"]; // image to show the doctor in Schdual
                                            int pricePay = int.parse(price);
                  
                  
                  
                  
                  
                                                                        // Open Strip to write visa number 
                                              if(payment == "Visa"){
                                                bool result = await PaymentManger.makePayment(pricePay, "USD");
                                                // check if it success or not 
                                                if(result){
                                            // book a date and send the date to server 
                                            if(context.mounted){
                                              context.read<BookDoctorCubit>().bookDateDoctor(
                                              name,
                                              address, 
                                              gender, 
                                              medicalHistory, 
                                              currentMedical, 
                                              phoneNumber, 
                                              doctorName, 
                                              idDoctor, 
                                              medical, 
                                              medicalAR, 
                                              medicalES, 
                                              medicalJA, 
                                              price, 
                                              daybookUser!, 
                                              hourbookUser!, 
                                              image, payment);
                                            }
                                            // if there error in Visa 
                                                } else{
                                                  if(context.mounted){
                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).ErrorBook)));
                                                  }
                                                  
                                                }
                                                // using Cash 
                                              } else {
                                               // book a date and send the date to server 
                                            if(context.mounted){
                                              context.read<BookDoctorCubit>().bookDateDoctor(
                                              name,
                                              address, 
                                              gender, 
                                              medicalHistory, 
                                              currentMedical, 
                                              phoneNumber, 
                                              doctorName, 
                                              idDoctor, 
                                              medical, 
                                              medicalAR, 
                                              medicalES, 
                                              medicalJA, 
                                              price, 
                                              daybookUser!, 
                                              hourbookUser!, 
                                              image, payment);
                                            }
                                              }
                  
                  
                  
                                            // send the date to event 
                                            analytics.logEvent(name: "book" ,
                                            parameters: <String , Object>{
                                              "name" : name,
                                              "DoctorName" : doctorName,
                                              "gender" : gender,
                                              "day" : daybookUser! ,
                                              "hour" : hourbookUser! ,
                                              "category" : medical
                                            });
                  
                  
                  
                                            
                                              // if he didn't choose the day and hour , this message will appear 
                                            } else{
                                              if(context.mounted){
                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).ChooseDate)));
                                              }
                                              
                                            }
                                          }
                                        } 
                                        catch(e){
                                          // if there error while booking a date 
                                          if(context.mounted){
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).ErrorBook)));
                                          }
                                        }
                                      });
                      }
                      
                    },
                  ),
                )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}