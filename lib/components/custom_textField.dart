import 'package:flutter/material.dart';
import 'package:jmm_task/contstants/color_config.dart';
import 'package:jmm_task/contstants/strings.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool obscureText;
  final TextEditingController controller;

  const CustomTextField(
      {required this.hint,
      required this.controller,
      required this.icon,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          focusColor: ColorConfig.kenableBorder,
          prefixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(13, 0, 0, 0),
            child: SizedBox(
              width: size.width * 0.15,
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: size.height * 0.04,
                    color: ColorConfig.kenableBorder,
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      height: size.height * 0.04,
                      width: 2,
                      color: ColorConfig.kenableBorder),
                ],
              ),
            ),
          ),
          hintStyle: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: ColorConfig.kenableBorder),
          hintText: hint,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 22.0, horizontal: 10.0),
          border: InputBorder.none,
          focusedBorder: _buildOutlineBorder(ColorConfig.kfocusBorder),
          enabledBorder: _buildOutlineBorder(ColorConfig.kenableBorder)),
    );
  }

  OutlineInputBorder _buildOutlineBorder(Color color) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: color, width: 2));
  }
}
