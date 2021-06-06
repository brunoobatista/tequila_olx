import 'package:firebase_auth/firebase_auth.dart';
import 'package:olx_tequila/models/ReturnMessage.dart';
import 'package:olx_tequila/modelview/UserTequila.dart';

class FirebaseAuthRepository {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<ReturnMessage> login(String email, String password) async {
    ReturnMessage returnMessage = ReturnMessage();
    await auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      returnMessage.setMessage = 'Login evetuado com sucesso';
    }).onError((error, stackTrace) {
      returnMessage.isError = true;
      returnMessage.setMessage = error.toString();
    });

    return returnMessage;
  }

  Future<ReturnMessage> createUser(UserTequila userTequila) async {
    ReturnMessage returnMessage = ReturnMessage();

    await auth
        .createUserWithEmailAndPassword(
      email: userTequila.email!,
      password: userTequila.password!,
    )
        .then((firebaseUser) {
      returnMessage.setMessage = 'Usuário cadastrado com sucesso';
    }).catchError((error) {
      returnMessage.isError = true;
      returnMessage.setMessage = error;
    });
    return returnMessage;
  }

  Future<UserTequila> logout() async {
    print('Deslogando...');
    await auth.signOut();
    print('Deslogado.');
    return UserTequila.logOff();
  }

  Future verifyUserIsLogged() async {}

  Future<UserTequila> getCurrentUser() async {
    User? user = await auth.currentUser;
    if (user != null) {
      return UserTequila.logOn(id: user.uid, email: user.email);
    } else
      return UserTequila.logOff();
  }
}
