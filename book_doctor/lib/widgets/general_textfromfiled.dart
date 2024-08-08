import 'package:flutter/material.dart';


class GeneralTextfromfiled extends StatelessWidget{
  final Color color;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final int? maxLength;
  final double heightText;
  final TextInputType textInputType;

  const GeneralTextfromfiled({super.key, required this.controller, this.validator, required this.color, this.maxLength, required this.textInputType, required this.heightText});
  @override
  Widget build(BuildContext context) {
  return Container(
            height: heightText,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.01, // 2% of screen height
            ),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10)
            ),
            child: TextFormField(
              keyboardType: textInputType,
              maxLength: maxLength,
              controller: controller,
              validator: validator,
              expands: true,
              maxLines: null,
              decoration: const InputDecoration(
                counterText: "",
                contentPadding: EdgeInsets.all(7),
                border: InputBorder.none),
            ),
          );
  }
  
}