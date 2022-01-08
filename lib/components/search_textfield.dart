import 'package:flutter/material.dart';
import 'package:jmm_task/contstants/color_config.dart';
import 'package:jmm_task/contstants/strings.dart';

class SearchTextfield extends StatelessWidget {
  const SearchTextfield({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return TextFormField(
      decoration: InputDecoration(
          focusColor: ColorConfig.kenableBorder,
          suffixIcon: Icon(
            Icons.filter_alt_outlined,
            size: size.height * 0.04,
            color: ColorConfig.kPrimaryColor2,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(13, 0, 0, 0),
            child: Icon(
              Icons.search,
              size: size.height * 0.04,
              color: ColorConfig.kPrimaryColor2,
            ),
          ),
          hintStyle:
              const TextStyle(fontSize: 17, color: ColorConfig.kPrimaryColor2),
          hintText: Strings.search,
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(18),
          focusedBorder: _buildOutlineBorder(ColorConfig.kfocusBorder),
          enabledBorder: _buildOutlineBorder(ColorConfig.kfocusBorder)),
    );
  }

  OutlineInputBorder _buildOutlineBorder(Color color) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: color, width: 2));
  }
}
