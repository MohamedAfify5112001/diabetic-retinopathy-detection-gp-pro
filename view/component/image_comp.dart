import 'package:flutter/material.dart';

class AssetImageComponent extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const AssetImageComponent(
      {Key? key, required this.path, this.width, this.height, this.fit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage(path),
      width: width,
      height: height,
      fit: fit,
    );
  }
}
