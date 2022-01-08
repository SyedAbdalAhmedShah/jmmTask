import 'package:flutter/material.dart';
import 'package:jmm_task/contstants/color_config.dart';
import 'package:jmm_task/repository/database.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        ClipPath(
          child: Container(
            height: 110,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                  ColorConfig.kPrimaryColor2,
                  ColorConfig.kPrimaryColor.withOpacity(0.8),
                ])),
          ),
          clipper: HomeBottomBorderClipper(60),
        ),
        ClipPath(
          child: Container(
            height: 80,
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
          clipper: HomeBottomBorderClipper(40),
        ),
        Positioned(
            left: (size.width / 2) - 50,
            child: const Text(
              'Meet',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 50),
            )),
        Positioned(
            left: 0,
            child: IconButton(
              onPressed: () {
                FirestoreDatabase().getCardDetailDocument();
              },
              icon: Icon(
                Icons.menu,
                color: Colors.white,
                size: size.height * 0.05,
              ),
            ))
      ],
    );
  }
}

class HomeBottomBorderClipper extends CustomClipper<Path> {
  int scale;
  HomeBottomBorderClipper(this.scale);
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - scale);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 10);
    path.quadraticBezierTo(size.width, size.height, size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
