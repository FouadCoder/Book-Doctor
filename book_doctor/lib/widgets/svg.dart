import 'package:book_dctor/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ColorableSvg extends StatelessWidget {
  final String svgAsset;
  final bool isSelected;
  final Color selectedColor;

  const ColorableSvg({
    super.key,
    required this.svgAsset,
    this.isSelected = false,
    this.selectedColor = blueMain, // Default selected color
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context); 
    return SvgPicture.asset(
      svgAsset,
      // ignore: deprecated_member_use
      color: isSelected ? selectedColor : themeData.disabledColor, // Set color if selected
    );
  }
}