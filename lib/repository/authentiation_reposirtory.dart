import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthenticationRepository {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserCredential> singupWithEmailAndPassword(
      {required String email, required String password}) async {
    UserCredential user = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    print(user);
    return user;
  }

  Future<UserCredential> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    UserCredential user =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    print(user);
    return user;
  }
}
