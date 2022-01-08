import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jmm_task/bloc/signup_bloc/signup_event.dart';
import 'package:jmm_task/bloc/signup_bloc/signup_state.dart';
import 'package:jmm_task/repository/authentiation_reposirtory.dart';

class SignUpBloc extends Bloc<SignupEvent, SignUpState> {
  AuthenticationRepository repo = AuthenticationRepository();

  SignUpBloc() : super(InitialSignupState()) {
    on<UserRegisterationEvent>((event, emit) async {
      emit(LoadingSignupState());
      try {
        final userCredential = await repo.singupWithEmailAndPassword(
            email: event.email, password: event.password);
        print('user credntials $userCredential');

        emit(UserRegistedState());
      } catch (error) {
        emit(FailureSignupState(error: error.toString()));
      }
    });
  }
}
