import 'dart:io';

import 'package:flutter/material.dart';
import 'package:olx_tequila/views/widgets/NextButtonWidget.dart';

class ShowPickerWidget {
  ShowPickerWidget.removeImageDialog({
    required context,
    required File image,
    required Function fnExclude,
  }) {
    final file = Image.file(image);
    final double p20 = MediaQuery.of(context).size.height * 0.20;
    final double max = MediaQuery.of(context).size.height - p20;
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
                constraints: BoxConstraints(maxHeight: max), child: file),
            NextButtonWidget(
              label: 'Excluir',
              backgroundColor: Colors.transparent,
              borderColor: Colors.transparent,
              fontColor: Colors.red,
              onTap: () {
                fnExclude(image);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  ShowPickerWidget.showPicker({
    required context,
    VoidCallback? selectGarely,
    VoidCallback? selectCamera,
  }) : assert(selectCamera == null && selectGarely == null ? false : true) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: [
                  if (selectCamera != null)
                    ListTile(
                      leading: Icon(Icons.photo_camera),
                      title: Text('Câmera'),
                      onTap: () {
                        selectCamera();
                        Navigator.of(context).pop();
                      },
                    ),
                  if (selectGarely != null)
                    ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Galeria'),
                      onTap: () {
                        selectGarely();
                        Navigator.of(context).pop();
                      },
                    ),
                ],
              ),
            ),
          );
        });
  }
}
