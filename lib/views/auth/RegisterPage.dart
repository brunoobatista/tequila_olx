import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:olx_tequila/core/AppColors.dart';
import 'package:olx_tequila/models/ReturnMessage.dart';
import 'package:olx_tequila/models/UserTequila.dart';
import 'package:olx_tequila/repositories/FirebaseAuthRepository.dart';
import 'package:olx_tequila/views/widgets/BtnElevetedCustomWidget.dart';
import 'package:olx_tequila/views/widgets/TextFormFieldCustomWidget.dart';

class RegisterPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final FirebaseAuthRepository authRepository = FirebaseAuthRepository();
  String? name;
  @override
  Widget build(BuildContext context) {
    _registerUser() async {
      UserTequila userTequila = UserTequila(
        email: _controllerEmail.text,
        name: _controllerNome.text,
        password: _controllerPassword.text,
      );
      ReturnMessage message = ReturnMessage();
      await authRepository.createUser(userTequila).then((value) {
        message = value;
      });
      userTequila = await authRepository.getCurrentUser();
      if (userTequila.hasId) {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      } else {
        Navigator.pushReplacementNamed(context, '/');
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.pPurple,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormFieldCustomWidget(
                    controller: _controllerNome,
                    hint: "Nome",
                    autofocus: true,
                    type: TextInputType.text,
                    // onSaved: (value) => name = value,
                    validator: MultiValidator(
                        [RequiredValidator(errorText: 'Nome é obrigatório')]),
                  ),
                  SizedBox(height: 6),
                  TextFormFieldCustomWidget(
                    controller: _controllerEmail,
                    hint: "Email",
                    autofocus: false,
                    type: TextInputType.emailAddress,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'E-mail é obrigatório'),
                      EmailValidator(errorText: 'Não é um e-mail válido')
                    ]),
                  ),
                  SizedBox(height: 6),
                  TextFormFieldCustomWidget(
                    controller: _controllerPassword,
                    hint: 'Senha',
                    obscure: true,
                    validator: MultiValidator(
                        [RequiredValidator(errorText: 'Senha é obrigatório')]),
                  ),
                  SizedBox(height: 10),
                  BtnElevetedCustomWidget.defaultBtn(
                    text: 'Registrar',
                    onTap: _registerUser,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
