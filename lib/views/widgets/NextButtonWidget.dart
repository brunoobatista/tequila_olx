import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:olx_tequila/core/AppColors.dart';

class NextButtonWidget extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color fontColor;
  final Color borderColor;
  final VoidCallback onTap;

  NextButtonWidget({
    required this.label,
    required this.backgroundColor,
    required this.borderColor,
    required this.fontColor,
    required this.onTap,
  });

  NextButtonWidget.onlytext({
    required this.label,
    required this.onTap,
  })  : this.backgroundColor = Colors.transparent,
        this.borderColor = Colors.transparent,
        this.fontColor = AppColors.sDeepPurpleDark;

  NextButtonWidget.green({
    required this.label,
    required this.onTap,
  })  : this.backgroundColor = AppColors.darkGreen,
        this.borderColor = AppColors.green,
        this.fontColor = AppColors.white;

  NextButtonWidget.white({
    required this.label,
    required this.onTap,
  })  : this.backgroundColor = AppColors.white,
        this.borderColor = AppColors.border,
        this.fontColor = AppColors.grey;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      child: TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(backgroundColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            side: MaterialStateProperty.all(
              BorderSide(color: borderColor),
            )),
        onPressed: onTap,
        child: Text(
          label,
          style: GoogleFonts.notoSans(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: fontColor,
          ),
        ),
      ),
    );
  }
}
