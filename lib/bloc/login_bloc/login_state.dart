abstract class LoginState {}

class InitialLoginState extends LoginState {}

class LoadingLoginState extends LoginState {}

class UserLogedInState extends LoginState {}

class FailureLoginState extends LoginState {
  final String error;

  FailureLoginState({required this.error});
}
