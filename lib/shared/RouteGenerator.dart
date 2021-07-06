import 'package:flutter/material.dart';
import 'package:olx_tequila/views/SplashPage.dart';
import 'package:olx_tequila/views/anuncios/MeusAnunciosWidget.dart';
import 'package:olx_tequila/views/anuncios/NovoAnuncioWidget.dart';
import 'package:olx_tequila/views/auth/LoginPage.dart';
import 'package:olx_tequila/views/auth/RegisterPage.dart';
import 'package:olx_tequila/views/home/HomePageWidget.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomePageWidget());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/registrar':
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case '/meus-anuncios':
        return MaterialPageRoute(builder: (_) => MeusAnunciosWidget());
      case '/novo-anuncio':
        return MaterialPageRoute(builder: (_) => NovoAnuncioWidget(obj: args));
      default:
        return _erroRoute();
    }
  }

  static Route<dynamic> _erroRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Tela não encontrada'),
        ),
        body: Center(
          child: Text('Tela não encontrada'),
        ),
      );
    });
  }
}
