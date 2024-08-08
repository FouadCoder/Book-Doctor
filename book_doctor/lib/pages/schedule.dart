import 'package:book_dctor/core/colors.dart';
import 'package:book_dctor/cubit/cubit_cubit.dart';
import 'package:book_dctor/cubit/cubit_state.dart';
import 'package:book_dctor/generated/l10n.dart';
import 'package:book_dctor/widgets/item_schedule.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  String currnetState = "Upcoming";
  bool upcomingTure = true;
  List scheduleUpcoming = [];
  List scheduleComplelet = [];
  @override
  Widget build(BuildContext context) {

    Locale currentLocale = Localizations.localeOf(context);
    String userId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            S.of(context).Schedule,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        // Container for all page
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      currnetState = "Upcoming";
                      upcomingTure = true;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(5),
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(
                        color: blueMain,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Text(
                      S.of(context).Upcoming,
                      style: TextStyle(
                          fontWeight: currnetState == "Upcoming"
                              ? FontWeight.bold
                              : FontWeight.w600,
                          fontSize: currnetState == "Upcoming" ? 20 : 15),
                    )),
                  ),
                ),
                // complate
                GestureDetector(
                  onTap: () {
                    setState(() {
                      currnetState = "Compete";
                      upcomingTure = false;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(5),
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Text(
                      S.of(context).Complete,
                      style: TextStyle(
                          fontWeight: currnetState == "Upcoming"
                              ? FontWeight.w600
                              : FontWeight.bold,
                          fontSize: currnetState == "Upcoming" ? 15 : 20),
                    )),
                  ),
                ),
              ],
            ),

            // Stream for date
            BlocListener<CancelScheduleCubit, CancelScheduleState>(
              listener: (context, stateLS) {
                if(stateLS is CancelScheduleLoaded){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).SuccessDeleteSchedule) , backgroundColor: Colors.green,));
                } else if(stateLS is CancelScheduleError){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).ErrorDeleteSchedule) , backgroundColor: Colors.red,));
                }
              },
              child: StreamBuilder<QuerySnapshot>(
                  // sort by user Id user, and sort by day and hour
                  stream: FirebaseFirestore.instance
                      .collection("Books")
                      .where("userId", isEqualTo: userId)
                      .orderBy("dayBook")
                      .orderBy("hourBook")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: Lottie.asset("assets/loding.blue.json",
                              height: 200, width: 200));
                    } else if (snapshot.hasError) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.width * 0 * 10,
                            horizontal:
                                MediaQuery.of(context).size.height * 0.05),
                        child: Center(
                          child: SizedBox(
                            height: 160,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/cry.png",
                                  height: 80,
                                  width: 80,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(S.of(context).ErrorSchedule)
                              ],
                            ),
                          ),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      List scheduleDate;
                      // to delete the last date
                      scheduleComplelet.clear();
                      scheduleUpcoming.clear();
                      // check
                      if (snapshot.data == null) {
                        scheduleDate = [];
                      } else {
                        scheduleDate = snapshot.data!.docs;
                      }
                      // Time now
                      DateTime now = DateTime(DateTime.now().year,
                          DateTime.now().month, DateTime.now().day);
                          

                      // for
                      for (int i = 0; i < scheduleDate.length; i++) {
                            // get the current medical
    String getMedical(){
                          switch(currentLocale.languageCode){
                            case "ar" : 
                            return scheduleDate[i]["MedicalAR"] ?? "";
                            case "ja" : 
                            return     scheduleDate[i]["MedicalJA"] ?? "";
                            case "es" : 
                            return     scheduleDate[i]["MedicalES"] ?? "";
                            default : return scheduleDate[i]["Medical"] ?? "";
                          }
                        }
                        // all thie to know the date so I can add them in Upcomint or complete
                        List dayDate = scheduleDate[i]["dayBook"].split(" / ");
                        int monthDate = int.parse(dayDate[0]);
                        int day = int.parse(dayDate[1]);
                        DateTime realBook = DateTime(now.year, monthDate, day);
                        // map for date
                        // to add the date in every list like upcoming or compelete
                        Map<String, dynamic> scheduleItem = {
                          "DoctorName": scheduleDate[i]["DoctorName"],
                          "category": getMedical(),
                          "dayBook": scheduleDate[i]["dayBook"],
                          "hourBook": scheduleDate[i]["hourBook"],
                          "Image": scheduleDate[i]["Image"],
                          "DoctorId" : scheduleDate[i]["DoctorId"]
                        };
                        // after we get the date , we make a check to see the date
                        if (realBook.isAfter(now) ||
                            realBook.isAtSameMomentAs(now)) {
                          scheduleUpcoming.add(scheduleItem);
                        } else {
                          scheduleComplelet.add(scheduleItem);
                        }
                      }
                      List schedule =
                          upcomingTure ? scheduleUpcoming : scheduleComplelet;
                      return Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.02,
                            vertical: MediaQuery.of(context).size.height * 0.02,
                          ),
                          child: ListView.builder(
                              itemCount: schedule.length,
                              itemBuilder: (context, index) {
                                String docId = scheduleDate[index]
                                    .id; // to get the id if user user want to cancel the date

                                // the value will be
                                return ItemSchedule(
                                    name: schedule[index]["DoctorName"],
                                    category: schedule[index]["category"],
                                    day: schedule[index]["dayBook"],
                                    hour: schedule[index]["hourBook"],
                                    image: schedule[index]["Image"],
                                    isUpcomingTrue:
                                        upcomingTure, // to show button of cancal
                                    textbutton: S.of(context).Cancel,
                                    isThereDate: true, // to show the date icons
                                    // delete Button
                                    cancel: () async {
                                      String dayBook =
                                          schedule[index]["dayBook"];
                                      String hourBook =
                                          schedule[index]["hourBook"];
                                      String idDoctor = schedule[index]["DoctorId"];
                                      context.read<CancelScheduleCubit>().cancelDate(dayBook, hourBook,idDoctor, docId);
                                    });
                              }),
                        ),
                      );
                    }

                    return Container();
                  }),
            ),
          ],
        ));
  }
}
