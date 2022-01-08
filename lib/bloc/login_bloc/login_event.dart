import 'package:jmm_task/contstants/strings.dart';

abstract class LoginEvent {}

class UserLogingInEvent extends LoginEvent {
  final String email;
  final String password;
  UserLogingInEvent({required this.email, required this.password});
}
