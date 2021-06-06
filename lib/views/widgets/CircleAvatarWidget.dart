import 'dart:io';

import 'package:flutter/material.dart';
import 'package:olx_tequila/core/AppColors.dart';

class CircleAvatarWidget extends StatelessWidget {
  final String? hint;
  final Color? colorHint;
  final Color? colorIcon;
  final IconData? icon;
  final Color? backgroundAvatar;
  final File? image;
  final VoidCallback onTap;
  // CircleAvatarWidget({
  //   Key? key,
  //   required this.onTap,
  //   this.hint,
  //   this.colorHint,
  //   this.colorIcon,
  //   this.icon,
  //   this.backgroundAvatar,
  //   this.image,
  // }) : super(key: key);

  CircleAvatarWidget.mock({
    Key? key,
    required this.onTap,
    required this.hint,
    required this.icon,
    this.colorHint,
    this.colorIcon,
    this.backgroundAvatar,
  }) : this.image = null;

  CircleAvatarWidget.image({
    Key? key,
    required this.onTap,
    required this.image,
  })  : this.hint = null,
        this.colorHint = null,
        this.colorIcon = null,
        this.icon = null,
        this.backgroundAvatar = null;

  Widget _returnCircleAvatar() {
    if (this.image == null)
      return CircleAvatar(
        radius: 50,
        backgroundColor: this.backgroundAvatar != null
            ? this.backgroundAvatar
            : AppColors.backGroundGreyAcent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              this.icon,
              size: 40,
              color: this.colorIcon != null
                  ? this.colorIcon
                  : AppColors.backGroundGrey,
            ),
            Text(
              this.hint!,
              style: TextStyle(
                color: this.colorHint != null
                    ? this.colorHint
                    : AppColors.backGroundGrey,
                fontSize: 14,
              ),
            )
          ],
        ),
      );
    else
      return CircleAvatar(
        radius: 50,
        backgroundImage: FileImage(this.image!),
        child: Container(
          alignment: Alignment.center,
          color: Color.fromRGBO(255, 255, 255, 0.3),
          child: Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: this.onTap,
        child: _returnCircleAvatar(),
      ),
    );
  }
}
