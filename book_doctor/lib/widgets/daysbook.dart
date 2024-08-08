import 'package:book_dctor/cubit/cubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DaysBook extends StatefulWidget {
  final String days;
  final int index;
  final String idDoctor;
  final String keyDay; // this one for Hourbook
  final Function onItemSelect;
  final bool isSelected;
  const DaysBook({super.key, required this.days, required this.index, required this.idDoctor, required this.keyDay , required this.onItemSelect , required this.isSelected});

  @override
  State<DaysBook> createState() => _DaysBookState();
}

class _DaysBookState extends State<DaysBook> {
    late HourAvailableCubit _hourAvailableCubit;

  @override
  void initState(){
    _hourAvailableCubit = context.read<HourAvailableCubit>();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          widget.onItemSelect(widget.index , widget.days); // To know the day when user book 
        });
        _hourAvailableCubit.workStream(widget.idDoctor, widget.keyDay,);
      },
      child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
            color:widget.isSelected ? Colors.grey : Colors.blueAccent,
            borderRadius: BorderRadius.circular(17)
                            ),
                            width: 80, height: 50,
                            child: Center(child: Text(widget.days.toString() , style: const TextStyle(fontWeight: FontWeight.bold),)),
                          ),
    );
  }
  // dispose //  stop stream
  @override
  void dispose(){
    if(widget.isSelected){
      _hourAvailableCubit.stopStream();
    }
    super.dispose();
  }
}