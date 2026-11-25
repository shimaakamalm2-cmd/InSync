import 'package:cupertino_native_better/style/glass_effect.dart';
import 'package:flutter/material.dart';
import 'package:native_liquid_glass/native_liquid_glass.dart';

import '../../colors.dart';

class GlassSnackBar extends SnackBar {

  final String text;
  final Color? color;

  GlassSnackBar({super.key, required this.text, super.animation, this.color}) :
        super(
        clipBehavior: .none,
        padding: .symmetric(horizontal: 25, vertical: 22),
        elevation: NativeLiquidGlassUtils.supportsLiquidGlass ? 0 : null,
        backgroundColor: NativeLiquidGlassUtils.supportsLiquidGlass ? Colors.transparent : color,
        behavior: !NativeLiquidGlassUtils.supportsLiquidGlass ? .floating : null,
        content: NativeLiquidGlassUtils.supportsLiquidGlass ?
        Padding(
          padding: .all(13),
          child: Text(text,
            style:
                .new(
                color: InSyncColors.white,
                fontWeight: .w600)
            ,
          ),
        ).liquidGlass(
            shape: .rect,
            cornerRadius: 25,
            interactive: true,
            effect: .clear,
            tint: color ?? Colors.black.withAlpha(50)
        )
            :
        Text(text)
      );
}