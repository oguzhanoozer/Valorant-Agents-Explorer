import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum AppImageExt { svg, webp }

enum AppImages {
  slogan(),
  dialog_sos(),
  dialog_success(),
  dialog_info(),
  dialog_warning(),
  splash_background(ext: AppImageExt.webp);

  final AppImageExt ext;
  const AppImages({this.ext = AppImageExt.svg});

  String get _path => 'assets/images/$name.${ext.name}';

  Widget call({
    BoxFit? fit,
    Color? color,
  }) {
    return FittedBox(
      fit: fit ?? BoxFit.contain,
      clipBehavior: Clip.hardEdge,
      child: switch (ext) {
        AppImageExt.svg => SvgPicture.asset(
            _path,
            fit: fit ?? BoxFit.contain,
            colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
          ),
        AppImageExt.webp => Image.asset(
            _path,
            fit: BoxFit.contain,
            color: color,
          ),
      },
    );
  }
}
