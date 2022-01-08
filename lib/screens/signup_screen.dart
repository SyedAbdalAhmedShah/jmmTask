import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jmm_task/bloc/signup_bloc/signup_bloc.dart';
import 'package:jmm_task/bloc/signup_bloc/signup_event.dart';
import 'package:jmm_task/bloc/signup_bloc/signup_state.dart';
import 'package:jmm_task/components/alert.dart';
import 'package:jmm_task/components/custom_textField.dart';
import 'package:jmm_task/components/header.dart';
import 'package:jmm_task/components/my_button.dart';
import 'package:jmm_task/components/social_login_&_text.dart';
import 'package:jmm_task/contstants/color_config.dart';
import 'package:jmm_task/contstants/strings.dart';
import 'package:jmm_task/repository/authentiation_reposirtory.dart';
import 'package:jmm_task/screens/home_screen.dart';
import 'package:jmm_task/screens/login_screen.dart';

class SignUpScreen extends StatelessWidget {
  final SignUpBloc _bloc = SignUpBloc();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(size.width, 250),
          child: const Header(),
        ),
        body: BlocConsumer(
          bloc: _bloc,
          builder: (context, state) {
            return _buildBody(size, context);
          },
          listener: (context, state) {
            print('state is $state');
            if (state is UserRegistedState) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => HomeScreen()));
            }
            if (state is FailureSignupState) {
              Alerts.showMessage(context, state.error);
            }
          },
        ),
      ),
    );
  }

  SingleChildScrollView _buildBody(Size size, BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
          vertical: size.height * 0.04, horizontal: size.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SocialLoginWithText(title: Strings.signUp),
          verticalGap(size, 0.02),
          _buildHeading(size, Strings.email),
          verticalGap(size, 0.01),
          CustomTextField(
            icon: Icons.email,
            hint: Strings.email,
            obscureText: false,
            controller: _emailController,
          ),
          verticalGap(size, 0.02),
          _buildHeading(size, Strings.password),
          CustomTextField(
            icon: Icons.lock,
            hint: Strings.password,
            controller: _passController,
            obscureText: false,
          ),
          verticalGap(size, 0.1),
          MyButton(
            child: _bloc.state is LoadingSignupState
                ? _cupertinoIndicator()
                : _signupText(),
            onTap: () {
              _bloc.add(UserRegisterationEvent(
                  email: _emailController.text.trim(),
                  password: _passController.text.trim()));
            },
          ),
          verticalGap(size, 0.05),
          _alreadyAccount(context)
        ],
      ),
    );
  }

  Row _alreadyAccount(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(Strings.alreadyAccount, style: _textStyle()),
        GestureDetector(
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => LoginScreen())),
          child: Text(Strings.login,
              style: _textStyle(color: ColorConfig.kPrimaryColor2)),
        )
      ],
    );
  }

  Text _signupText() {
    return const Text(
      Strings.signUp,
      style: TextStyle(
          fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
    );
  }

  Center _cupertinoIndicator() {
    return const Center(
      child: CupertinoActivityIndicator(),
    );
  }

  Row _buildHeading(Size size, String title) {
    return Row(
      children: [
        SizedBox(width: size.width * 0.02),
        Text(
          title,
          style: _textStyle(),
        ),
      ],
    );
  }

  TextStyle _textStyle({Color? color}) {
    return TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: color ?? ColorConfig.kenableBorder);
  }

  SizedBox verticalGap(Size size, double gap) {
    return SizedBox(
      height: size.height * gap,
    );
  }
}
