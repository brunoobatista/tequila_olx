import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:olx_tequila/core/AppColors.dart';
import 'package:olx_tequila/core/AppPadding.dart';
import 'package:olx_tequila/models/Anuncio.dart';
import 'package:olx_tequila/utils/Converter.dart';
import 'package:olx_tequila/utils/UtilArguments.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailAnuncioWidget extends StatefulWidget {
  final Anuncio anuncio;
  DetailAnuncioWidget({Key? key, required this.anuncio}) : super(key: key);

  @override
  _DetailAnuncioWidgetState createState() => _DetailAnuncioWidgetState();
}

class _DetailAnuncioWidgetState extends State<DetailAnuncioWidget> {
  final CarouselController _controller = CarouselController();
  Anuncio _anuncio = Anuncio();
  List<String> _imgList = [];
  List<Widget> _imageSliders = [];
  int _currentPage = 0;
  void onPageChange(int index, CarouselPageChangedReason changeReason) {
    setState(() {
      this._currentPage = index;
      print(index);
    });
  }

  _filledList() {
    List<String> fotos = this._anuncio.fotos;
    fotos.forEach((url) {
      this._imgList.add(url);
    });
    this._imageSliders = this
        ._imgList
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(item), fit: BoxFit.scaleDown),
                ),
                // child: ClipRRect(
                //   borderRadius: BorderRadius.all(Radius.circular(4.0)),
                //   child: Image.network(item, fit: BoxFit.cover, width: 1000.0),
                // ),
              ),
            ))
        .toList();
  }

  _ligarTelefone(String telefone) async {
    if (await canLaunch("tel:$telefone")) {
      await launch("tel:$telefone");
    } else {
      print('Não pode efetuar a licação');
    }
  }

  @override
  void initState() {
    super.initState();
    this._anuncio = widget.anuncio;
    _filledList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anúncio'),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              CarouselSlider(
                items: this._imageSliders,
                options: CarouselOptions(
                  aspectRatio: 16 / 9,
                  viewportFraction: 1.0,
                  onPageChanged: onPageChange,
                  autoPlay: false,
                  disableCenter: true,
                ),
                carouselController: _controller,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: this._imgList.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(
                      entry.key,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease,
                    ),
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusGeometry.lerp(
                          null,
                          BorderRadius.circular(5.0),
                          2.0,
                        ),
                        // shape: BoxShape.circle,
                        color: (AppColors.pPurpleDark).withOpacity(
                            this._currentPage == entry.key ? 0.9 : 0.4),
                      ),
                    ),
                  );
                }).toList(),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: 70,
                    left: AppPadding.all8,
                    right: AppPadding.all8,
                    top: AppPadding.all8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "R\$ ${Converter.fromDoubleToBRL(value: this._anuncio.preco)}",
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: AppColors.pPurpleDark),
                    ),
                    Text(
                      "${this._anuncio.titulo}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(),
                    ),
                    Text(
                      "Descrição",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${this._anuncio.descricao}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(),
                    ),
                    Text(
                      "Contato",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${this._anuncio.telefone}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            left: AppPadding.all,
            right: AppPadding.all,
            bottom: AppPadding.all,
            child: GestureDetector(
              child: Container(
                padding: EdgeInsets.all(AppPadding.all12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.pPurple,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  'Ligar',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
              ),
              onTap: () {
                _ligarTelefone(this._anuncio.telefone);
              },
            ),
          )
        ],
      ),
    );
  }
}
