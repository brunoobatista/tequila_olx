import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:olx_tequila/views/widgets/CircleAvatarWidget.dart';
import 'package:olx_tequila/views/widgets/NextButtonWidget.dart';
import 'package:olx_tequila/views/widgets/ShowPickerWidget.dart';

class ListViewCustomWidget extends StatefulWidget {
  final List<File> listImages;

  ListViewCustomWidget({
    Key? key,
    required this.listImages,
  }) : super(key: key);

  @override
  _ListViewCustomWidgetState createState() => _ListViewCustomWidgetState();
}

class _ListViewCustomWidgetState extends State<ListViewCustomWidget> {
  _selecionarImagemGaleria() async {
    final imageSelecionada =
        await ImagePicker().getImage(source: ImageSource.gallery);

    if (imageSelecionada != null) {
      setState(() {
        this.widget.listImages.add(File(imageSelecionada.path));
      });
    }
  }

  _selecionarImagemCamera() async {
    final imageSelecionada =
        await ImagePicker().getImage(source: ImageSource.camera);

    if (imageSelecionada != null) {
      setState(() {
        this.widget.listImages.add(File(imageSelecionada.path));
      });
    }
  }

  _removeImage(File image) {
    setState(() {
      this.widget.listImages.remove(image);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: this.widget.listImages.length + 1,
      itemBuilder: (context2, index) {
        if (index == this.widget.listImages.length) {
          return CircleAvatarWidget.mock(
            onTap: () {
              ShowPickerWidget.showPicker(
                context: context,
                selectGarely: _selecionarImagemGaleria,
                selectCamera: _selecionarImagemCamera,
              );
            },
            hint: 'Adicionar',
            icon: Icons.add_a_photo,
          );
        }
        if (this.widget.listImages.length > 0)
          return CircleAvatarWidget.image(
            onTap: () {
              // _removeImagea(context, index);
              ShowPickerWidget.removeImageDialog(
                  context: context,
                  image: this.widget.listImages[index],
                  fnExclude: _removeImage);
            },
            image: this.widget.listImages[index],
          );
        return Container();
      },
    );
  }
}
