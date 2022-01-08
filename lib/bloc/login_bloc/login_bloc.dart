import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jmm_task/bloc/login_bloc/login_event.dart';
import 'package:jmm_task/bloc/login_bloc/login_state.dart';
import 'package:jmm_task/repository/authentiation_reposirtory.dart';

class LOginBloc extends Bloc<LoginEvent, LoginState> {
  AuthenticationRepository repo = AuthenticationRepository();
  String errorMessage = '';
  LOginBloc() : super(InitialLoginState()) {
    on<UserLogingInEvent>((event, emit) async {
      emit(LoadingLoginState());
      try {
        UserCredential userCredential = await repo.loginWithEmailAndPassword(
            email: event.email, password: event.password);
        emit(UserLogedInState());
      } on FirebaseAuthException catch (e) {
        emit(FailureLoginState(error: e.code.toString()));
      } catch (error) {
        emit(FailureLoginState(error: error.toString()));
      }
    });
  }
}
