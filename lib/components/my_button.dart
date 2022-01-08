import 'package:flutter/material.dart';
import 'package:jmm_task/contstants/color_config.dart';

class MyButton extends StatelessWidget {
  final Widget child;
  final Function()? onTap;
  MyButton({required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(stops: const [
              0.2,
              0.9
            ], colors: [
              ColorConfig.kPrimaryColor,
              ColorConfig.kPrimaryColor2
            ]),
            borderRadius: BorderRadius.circular(size.width * 0.03),
            color: ColorConfig.kPrimaryColor2),
        height: size.height * 0.089,
        child: child,
      ),
    );
  }
}
