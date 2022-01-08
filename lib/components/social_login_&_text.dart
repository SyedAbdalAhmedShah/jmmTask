import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jmm_task/contstants/color_config.dart';

class SocialLoginWithText extends StatelessWidget {
  final String title;
  final Function()? fbOnTap;
  final Function()? goOnTap;

  const SocialLoginWithText({required this.title, this.fbOnTap, this.goOnTap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 39, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        Spacer(),
        _buildSocialLogin(
            size: size,
            imagePath: 'assets/Icon simple-facebook.svg',
            onTap: fbOnTap),
        SizedBox(width: size.width * 0.02),
        _buildSocialLogin(
            size: size,
            imagePath: 'assets/Icon awesome-google.svg',
            onTap: goOnTap),
      ],
    );
  }

  Container _buildSocialLogin(
      {required Size size, required String imagePath, Function()? onTap}) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.width * 0.036),
          border: Border.all(color: ColorConfig.kPrimaryColor2, width: 2)),
      child: SvgPicture.asset(
        imagePath,
        height: size.height * 0.03,
      ),
    );
  }
}
