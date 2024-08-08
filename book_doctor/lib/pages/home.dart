
import 'package:book_dctor/core/colors.dart';
import 'package:book_dctor/cubit/cubit_cubit.dart';
import 'package:book_dctor/cubit/cubit_state.dart';
import 'package:book_dctor/generated/l10n.dart';
import 'package:book_dctor/widgets/item_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  String? selectCategory;
  List? doctors;
  
  @override
  void initState(){
    super.initState();
    context.read<DoctorsdateCubit>().getDctorsList();
    
  }
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    selectCategory = S.of(context).All;
  }

  @override
  Widget build(BuildContext context) {


    Locale currentLocale = Localizations.localeOf(context);
    // List for category
    final List<String> categories = [
      S.of(context).All,
      S.of(context).Psychologist, 
      S.of(context).Orthopedist ,
      S.of(context).Physicaltherapy,
      S.of(context).Dermatologist,
      S.of(context).Pediatrician, // kids
      S.of(context).Cardiologist, // heart
      S.of(context).Neurologist // brain
      ];
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueMain,
        title: Text(S.of(context).FindDoctor , style: const TextStyle(fontWeight: FontWeight.bold ), overflow: TextOverflow.ellipsis,),
        actions: [
          // Button seach 
          IconButton(onPressed: (){
            showSearch(context: context, delegate: SearchDoctor(doctors!));
          }, icon: const Icon(Icons.search , size: 30,))
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04,
          vertical: MediaQuery.of(context).size.height * 0.02,
        ), child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             // Category 
            SizedBox(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context , index){
                  final currnetCategory = categories[index];
                  final isSelected = currnetCategory == selectCategory;
                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        selectCategory = currnetCategory;
                      });
                      context.read<DoctorsdateCubit>().getDctorsList();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? blueMain : const Color(0xFF8FA8C8),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(5),
                      height: 50,
                      width: 140,
                      child: Center(child: Text(categories[index] , style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),)),
                    ),
                  );
                }),
            ),





                        // Find a doctor
            const SizedBox(height: 10,),
            Text(S.of(context).OurDoctors, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
            const SizedBox(height: 15),
            // Listveiw for List of Doctors
            Expanded(
              child: BlocBuilder<DoctorsdateCubit,DoctorsdateState>(
                builder: (context , state) {
                  if(state is DoctorsdateLoading){
                    return Center(child: Lottie.asset("assets/loding.blue.json" , height: 200 , width: 200));
                  } else if(state is DoctorsdateError){
                    return  Center(child: Column( 
                      mainAxisAlignment: MainAxisAlignment.center,
                    children: [ 
                      SizedBox(height: 150, width: 150, child: Image.asset("assets/doctor.rest.png"),),
                      const SizedBox(height: 30,),
                      Text(S.of(context).ErrorMessage , style: const TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),],));
                  } // here the date of doctors
                  else if (state is DoctorsdateLoaded){
                    // a way to show what the user choose in category
                      doctors = state.doctorsList.where((item){
                        if(selectCategory == S.of(context).All) return true;
                        // get rhe current language so you can get the right name of medical
                            String getMedical(){
                          switch(currentLocale.languageCode){
                            case "ar" : 
                            return   "MedicalAR";
                            case "ja" : 
                            return    "MedicalJA";
                            case "es" : 
                            return    "MedicalES";
                            default : return "Medical";
                          }
                        }
                        
                        return item[getMedical()] == selectCategory;
                      }).toList();
                    return ListView.builder(
                      itemCount: doctors!.length,
                      itemBuilder: (context , index){
                        final indexDoctors = index;
                        return ItemHome(doctors: doctors!, indexDoctors: indexDoctors,);
                      });
                  }
                  return Container();
                }
              ),
            )
          ],
        ),)
        
    );
  }
}


// search 
class SearchDoctor extends SearchDelegate{
    List doctors;
  SearchDoctor(this.doctors);
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: (){
        query = "";
      }, icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: (){
      close(context, null);
    }, icon: const Icon(Icons.arrow_back_ios_new));
  }

  @override
  Widget buildResults(BuildContext context) {
    final filterDoctors = doctors.where((element) => element["name"].toLowerCase().contains(query.toLowerCase())).toList();
    // if there nothing in search
  if(query == ""){
    return const Text("");
  } else{
    return ListView.builder(
    itemCount:  filterDoctors.length,
    itemBuilder: (context , index){
      return ItemHome(doctors: filterDoctors, indexDoctors: index ,);
    } );
  }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filterDoctors = doctors.where((element) => element["name"].toLowerCase().contains(query.toLowerCase())).toList();
    // if there nothing in search
  if(query == ""){
    return const Text("");
  } else{
    return ListView.builder(
    itemCount:  filterDoctors.length,
    itemBuilder: (context , index){
      return ItemHome(doctors: filterDoctors, indexDoctors: index);
    } );
  }
  }
}