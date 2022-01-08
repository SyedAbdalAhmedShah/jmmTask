import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class CustomPlaceHolder extends StatelessWidget {
  final String imageUrl;
  CustomPlaceHolder({required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(size.width * 0.05),
      child: CachedNetworkImage(
        height: size.height * 0.2,
        imageUrl: imageUrl,
        placeholder: (context, string) => const Center(
          child: CupertinoActivityIndicator(
            animating: true,
          ),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.fill,
      ),
    );
  }
}
