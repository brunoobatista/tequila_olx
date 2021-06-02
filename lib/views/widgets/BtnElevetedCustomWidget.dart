import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:olx_tequila/core/AppColors.dart';

class BtnElevetedCustomWidget extends StatelessWidget {
  final String text;
  final double textFontSize;
  final FontWeight textFontWeight;
  final double radius;
  final Color backgroundColor;
  final Color fontColor;
  final Color borderColor;
  final VoidCallback onTap;

  BtnElevetedCustomWidget({
    Key? key,
    required this.text,
    required this.onTap,
    required this.textFontSize,
    required this.textFontWeight,
    required this.radius,
    required this.backgroundColor,
    required this.fontColor,
    required this.borderColor,
  }) : super(key: key);

  BtnElevetedCustomWidget.defaultBtn({
    Key? key,
    required this.text,
    required this.onTap,
  })  : this.textFontSize = 18,
        this.textFontWeight = FontWeight.w800,
        this.radius = 5,
        this.backgroundColor = AppColors.pPurpleDark,
        this.fontColor = AppColors.pText,
        this.borderColor = AppColors.pPurple;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 38,
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(text,
            style: GoogleFonts.notoSans(
                fontSize: textFontSize, fontWeight: textFontWeight)),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(horizontal: 22, vertical: 12)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
          ),
          side: MaterialStateProperty.all(BorderSide(color: borderColor)),
        ),
      ),
    );
  }
}
