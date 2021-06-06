import 'package:flutter/material.dart';
import 'package:olx_tequila/modelview/UserTequila.dart';
import 'package:olx_tequila/repositories/FirebaseAuthRepository.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    FirebaseAuthRepository _firebaseAuthRepository = FirebaseAuthRepository();

    _verifyUserLogged() async {
      UserTequila userTequila = await _firebaseAuthRepository.getCurrentUser();
      if (userTequila.isLogged) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    }

    super.initState();
    print("testando");

    _verifyUserLogged();
    // Future.delayed(Duration(seconds: 3))
    //     .then((value) => {Navigator.pushReplacementNamed(context, '/login')});
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
