import 'package:jmm_task/contstants/strings.dart';

abstract class SignupEvent {}

class UserRegisterationEvent extends SignupEvent {
  final String email;
  final String password;
  UserRegisterationEvent({required this.email, required this.password});
}
