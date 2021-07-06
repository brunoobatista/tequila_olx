import 'package:flutter/material.dart';
import 'package:olx_tequila/core/AppColors.dart';
import 'package:olx_tequila/models/Anuncio.dart';
import 'package:olx_tequila/utils/Converter.dart';

class CardAnuncioWidget extends StatelessWidget {
  final Anuncio anuncio;
  final VoidCallback? onPressedRemove;
  const CardAnuncioWidget(
      {Key? key, required this.anuncio, this.onPressedRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                SizedBox(
                    width: 120,
                    height: 120,
                    child: Image.network(
                      this.anuncio.fotos[0],
                      fit: BoxFit.cover,
                    )),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          this.anuncio.titulo,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                            "R\$ ${Converter.fromDoubleToBRL(value: this.anuncio.preco)}"),
                      ],
                    ),
                  ),
                ),
                if (this.onPressedRemove != null)
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.pRedLight),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      onPressed: () {},
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ));
  }
}
