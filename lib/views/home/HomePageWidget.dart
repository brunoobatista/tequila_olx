import 'package:flutter/material.dart';
import 'package:olx_tequila/core/AppColors.dart';
import 'package:olx_tequila/models/UserTequila.dart';
import 'package:olx_tequila/repositories/FirebaseAuthRepository.dart';
import 'package:olx_tequila/services/HomeService.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePageWidget extends StatefulWidget {
  HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final pageViewController = PageController();
  final FirebaseAuthRepository firebaseRepository = FirebaseAuthRepository();
  final HomeService homeService = HomeService();

  UserTequila userTequila = UserTequila.logOff();

  List<String> itensMenu = [];

  _escolhaMenuItem(String itemEscolhido) async {
    switch (itemEscolhido.parse) {
      case ItemMenus.meus_anuncios:
        Navigator.pushReplacementNamed(context, '/meus-anuncios');
        break;
      case ItemMenus.cadastrar:
        Navigator.pushNamed(context, '/registrar');
        break;
      case ItemMenus.entrar:
        Navigator.pushNamed(context, '/login');
        break;
      case ItemMenus.deslogar:
        await firebaseRepository.logout();
        Navigator.pushReplacementNamed(context, '/home');
        break;
    }
  }

  verifyUserIsLogged() async {
    userTequila = await firebaseRepository.getCurrentUser();
    itensMenu = homeService.getMenuItens(userTequila.isLogged);
  }

  @override
  void initState() {
    super.initState();
    verifyUserIsLogged();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tequilla'),
        backgroundColor: AppColors.pPurple,
        // automaticallyImplyLeading: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: _escolhaMenuItem,
            itemBuilder: (context) {
              return itensMenu.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          )
        ],
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: 500,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                child: PageView(
                  controller: pageViewController,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (value) {
                    print(value);
                  },
                  children: [
                    Image.network(
                      'https://picsum.photos/seed/492/600',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    Image.network(
                      'https://picsum.photos/seed/672/600',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    Image.network(
                      'https://picsum.photos/seed/534/600',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment(0, 1),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: SmoothPageIndicator(
                    controller: pageViewController,
                    count: 3,
                    axisDirection: Axis.horizontal,
                    onDotClicked: (i) {
                      pageViewController.animateToPage(
                        i,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    effect: ExpandingDotsEffect(
                      expansionFactor: 2,
                      spacing: 8,
                      radius: 16,
                      dotWidth: 16,
                      dotHeight: 16,
                      dotColor: Color(0xFF9E9E9E),
                      activeDotColor: AppColors.sDeepPurpleLight,
                      paintStyle: PaintingStyle.fill,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
