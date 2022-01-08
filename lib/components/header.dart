import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:flutter_svg/svg.dart';
import 'package:jmm_task/contstants/color_config.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        ClipPath(
          child: Container(
            height: 200,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                  ColorConfig.kPrimaryColor2,
                  ColorConfig.kPrimaryColor.withOpacity(0.8),
                ])),
          ),
          clipper: MyBottomBorderClipper(145),
        ),
        ClipPath(
          child: Container(
            height: 170,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 5.0,
                    offset: Offset(3.0, 0),
                  ),
                ],
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      ColorConfig.kPrimaryColor2,
                      ColorConfig.kPrimaryColor,
                    ])),
          ),
          clipper: MyBottomBorderClipper(95),
        ),
        Positioned(
            top: 15,
            left: (size.width / 2) - 90,
            child: SvgPicture.asset('assets/sggs.svg')),
        cloudPicture(size, 0.1, 0.1),
        cloudPicture(size, 0.1, 0.02),
        cloudPicture(size, 0.8, 0.02),
        cloudPicture(size, 0.7, 0.1),
        Positioned(
            top: 45,
            left: (size.width / 2) - 50,
            child: const Text(
              'Meet',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 50),
            ))
      ],
    );
  }

  Positioned cloudPicture(Size size, double left, double top) {
    return Positioned(
        top: size.height * top,
        left: size.width * left,
        child: SvgPicture.asset('assets/cloud.svg'));
  }
}

/// Oval bottom clipper to clip widget in oval shape at the bottom side
class MyBottomBorderClipper extends CustomClipper<Path> {
  int scale;
  MyBottomBorderClipper(this.scale);
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - scale);
    path.quadraticBezierTo(
        size.width / 2, size.height + 40, size.width, size.height - 10);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - 10);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
