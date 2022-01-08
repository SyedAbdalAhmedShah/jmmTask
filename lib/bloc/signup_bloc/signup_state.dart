abstract class SignUpState {}

class InitialSignupState extends SignUpState {}

class LoadingSignupState extends SignUpState {}

class UserRegistedState extends SignUpState {}

class FailureSignupState extends SignUpState {
  final String error;

  FailureSignupState({required this.error});
}
