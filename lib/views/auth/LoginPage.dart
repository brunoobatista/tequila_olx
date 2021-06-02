import 'package:flutter/material.dart';
import 'package:olx_tequila/core/AppImages.dart';
import 'package:olx_tequila/repositories/FirebaseAuthRepository.dart';
import 'package:olx_tequila/views/widgets/BtnElevetedCustomWidget.dart';
import 'package:olx_tequila/views/widgets/NextButtonWidget.dart';
import 'package:olx_tequila/views/widgets/TextFieldCustomWidget.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final FirebaseAuthRepository firebaseAuthRepository =
      FirebaseAuthRepository();

  @override
  Widget build(BuildContext context) {
    _login() async {
      await firebaseAuthRepository
          .login(_controllerEmail.text, _controllerPassword.text)
          .then((value) {
        print(value.getMessage);
        if (!value.isError) {
          print('@@@@@@@@@@@@@');
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        }
      }).catchError((error) {
        print(error);
      });
    }

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                    AppImages.logo,
                    width: 200,
                    height: 150,
                  ),
                ),
                TextFieldCustomWidget(
                  controller: _controllerEmail,
                  hint: "Email",
                  autofocus: true,
                  type: TextInputType.emailAddress,
                ),
                SizedBox(height: 4),
                TextFieldCustomWidget(
                  controller: _controllerPassword,
                  hint: 'Senha',
                  obscure: true,
                ),
                SizedBox(height: 8),
                BtnElevetedCustomWidget.defaultBtn(
                  text: 'Entrar',
                  onTap: _login,
                ),
                SizedBox(height: 8),
                NextButtonWidget.onlytext(
                    label: 'Registrar-se',
                    onTap: () => Navigator.pushNamed(context, '/registrar'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
