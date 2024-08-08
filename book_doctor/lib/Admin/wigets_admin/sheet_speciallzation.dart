// import 'package:book_dctor/Admin/cubit_admin.dart/cubit_cubit_admin.dart';
// import 'package:book_dctor/core/colors.dart';
// import 'package:book_dctor/generated/l10n.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class SheetSpeciallzation extends StatefulWidget {

//   SheetSpeciallzation({super.key});

//   @override
//   State<SheetSpeciallzation> createState() => _SheetSpeciallzationState();
// }

// class _SheetSpeciallzationState extends State<SheetSpeciallzation> {
//   String categtory = "";

//   void updateCategoyr(String newCatgory){
//     setState(() {
//       categtory = newCatgory;
//     });
//     context.read<CategoryCubit>().addcategory(categtory);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(5),
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//                         RadioListTile(
//               title: Text(S.of(context).Orthopedist),activeColor: blueMain,
//               value: S.of(context).Orthopedist, groupValue: categtory, onChanged: (val){updateCategoyr(val!);}),
//                           RadioListTile(
//               title: Text(S.of(context).Psychologist),activeColor: blueMain,
//               value: S.of(context).Psychologist, groupValue: categtory, onChanged: (val){updateCategoyr(val!);}),
//                           RadioListTile(
//               title: Text(S.of(context).Physicaltherapy),activeColor: blueMain,
//               value: S.of(context).Physicaltherapy, groupValue: categtory, onChanged: (val){updateCategoyr(val!);}),
//                           RadioListTile(
//               title: Text(S.of(context).Dermatologist),activeColor: blueMain,
//               value: S.of(context).Dermatologist, groupValue: categtory, onChanged: (val){updateCategoyr(val!);}),
//               RadioListTile(
//               title: Text(S.of(context).Pediatrician),activeColor: blueMain,
//               value: S.of(context).Pediatrician, groupValue: categtory, onChanged: (val){updateCategoyr(val!);}),
//               RadioListTile(
//               title: Text(S.of(context).Cardiologist), activeColor: blueMain,
//               value: S.of(context).Cardiologist, groupValue: categtory, onChanged: (val){updateCategoyr(val!);}),
//               RadioListTile(
//               title: Text(S.of(context).Neurologist),activeColor: blueMain,
//               value: S.of(context).Neurologist, groupValue: categtory, onChanged: (val){updateCategoyr(val!);}),
              
//           ],
//         ),
//       ),
//     );
//   }
// }