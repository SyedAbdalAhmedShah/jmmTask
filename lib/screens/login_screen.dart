import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jmm_task/bloc/login_bloc/login_bloc.dart';
import 'package:jmm_task/bloc/login_bloc/login_event.dart';
import 'package:jmm_task/bloc/login_bloc/login_state.dart';
import 'package:jmm_task/bloc/signup_bloc/signup_state.dart';
import 'package:jmm_task/components/alert.dart';
import 'package:jmm_task/components/custom_textField.dart';
import 'package:jmm_task/components/header.dart';
import 'package:jmm_task/components/my_button.dart';
import 'package:jmm_task/components/social_login_&_text.dart';
import 'package:jmm_task/contstants/color_config.dart';
import 'package:jmm_task/contstants/strings.dart';
import 'package:jmm_task/screens/signup_screen.dart';

import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  final LOginBloc _bloc = LOginBloc();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(size.width, 250),
          child: Header(),
        ),
        body: BlocConsumer(
          bloc: _bloc,
          builder: (context, state) {
            return _buildBody(size, context);
          },
          listener: (context, state) {
            print('state is $state');
            if (state is UserLogedInState) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => HomeScreen()));
            }
            if (state is FailureLoginState) {
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
          const SocialLoginWithText(title: Strings.login),
          verticalGap(size, 0.02),
          _buildHeading(size, Strings.email),
          verticalGap(size, 0.01),
          CustomTextField(
            icon: Icons.email,
            hint: Strings.email,
            controller: _emailController,
            obscureText: false,
          ),
          verticalGap(size, 0.02),
          _buildHeading(size, Strings.password),
          CustomTextField(
            icon: Icons.lock,
            hint: Strings.password,
            controller: _passController,
            obscureText: true,
          ),
          verticalGap(size, 0.1),
          MyButton(
            child: _bloc.state is LoadingLoginState
                ? _cupertinoIndicator()
                : _loginText(),
            onTap: () {
              _bloc.add(UserLogingInEvent(
                  email: _emailController.text.trim(),
                  password: _passController.text.trim()));
            },
          ),
          verticalGap(size, 0.05),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(Strings.dontHaveAccount, style: _textStyle()),
              GestureDetector(
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => SignUpScreen())),
                child: Text(Strings.signUp,
                    style: _textStyle(color: ColorConfig.kPrimaryColor2)),
              )
            ],
          )
        ],
      ),
    );
  }

  Text _loginText() {
    return const Text(
      Strings.login,
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
