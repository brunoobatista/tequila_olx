import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    print("testando");
    Future.delayed(Duration(seconds: 3))
        .then((value) => {Navigator.pushReplacementNamed(context, '/login')});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Text('Testando splash')),
      ),
    );
  }
}
