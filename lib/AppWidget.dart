import 'package:flutter/material.dart';
import 'package:olx_tequila/core/AppColors.dart';
import 'package:olx_tequila/shared/RouteGenerator.dart';
import 'package:olx_tequila/views/SplashPage.dart';

final ThemeData temaPadrao = ThemeData(
  primaryColor: AppColors.pPurple,
  colorScheme: ColorScheme.light(onSecondary: AppColors.sDeepPurple),
);

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tequilla Olx',
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: temaPadrao,
      home: SplashPage(),
    );
  }
}
