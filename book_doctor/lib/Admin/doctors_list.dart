import 'package:book_dctor/Admin/cubit_admin.dart/cubit_cubit_admin.dart';
import 'package:book_dctor/Admin/cubit_admin.dart/cubit_state_admin.dart';
import 'package:book_dctor/cubit/cubit_cubit.dart';
import 'package:book_dctor/cubit/cubit_state.dart';
import 'package:book_dctor/generated/l10n.dart';
import 'package:book_dctor/widgets/item_schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class DoctorsList extends StatefulWidget {
  const DoctorsList({super.key});

  @override
  State<DoctorsList> createState() => _DoctorsListState();
}

class _DoctorsListState extends State<DoctorsList> {
  @override
  void initState() {
    super.initState();
    context.read<DoctorsdateCubit>().getDctorsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<DoctorsdateCubit, DoctorsdateState>(
          builder: (context, state) {
        // Loading
        if (state is DoctorsdateLoading) {
          return Center(
              child: Lottie.asset("assets/loding.blue.json",
                  height: 200, width: 200));
          // Error
        } else if (state is DoctorsdateError) {
          return Container(
            margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.width * 0 * 10,
                horizontal: MediaQuery.of(context).size.height * 0.05),
            child: Center(
              child: SizedBox(
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: Column(
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
        } else if (state is DoctorsdateLoaded) {
          final doctors = state.doctorsList;
          // List of doctors
          return BlocListener<CreateDateDoctorCubit, CreateDateDoctorState>(
            listener: (context, stateLis) {
              // Error
              if(stateLis is CreateDateDoctorError){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).tryLater , style: const TextStyle(fontWeight: FontWeight.bold ),) , backgroundColor: Colors.red,));
                // Success
              } else if(stateLis is CreateDateDoctorLoaded){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).SuccessAddDATE , style: const TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,)  , backgroundColor: Colors.green,));
              }
            },
            child: ListView.builder(
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  return ItemSchedule(
                      name: doctors[index]["name"],
                      category: doctors[index]["Medical"],
                      day: "",
                      hour: "",
                      cancel: () {
                        String idDoctor = doctors[index]["id"];
                        context
                            .read<CreateDateDoctorCubit>()
                            .getAvailableDays(idDoctor);
                      },
                      textbutton: S.of(context).Addschdule,
                      isThereDate: false,
                      isUpcomingTrue: true,
                      image: doctors[index]["Image"]);
                }),
          );
        }
        return Container();
      }),
    );
  }
}
