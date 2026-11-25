import 'package:cupertino_native_better/components/button.dart';
import 'package:flutter/material.dart';
import 'package:native_liquid_glass/native_liquid_glass.dart';

import '../colors.dart';

BoxDecoration _glassPill() => BoxDecoration(
  // screen(rgba(34,34,34,0.85)) == white @ 0.85*34/255
  color: Colors.white.withValues(alpha: 0.85 * 34 / 255),
  borderRadius: BorderRadius.circular(80),
  border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
  boxShadow: [
    BoxShadow(color: Colors.black.withValues(alpha: 0.07), blurRadius: 10),
  ],
);

enum ActionButtonStyle { primary, secondary }
enum ActionButtonSize { normal, expanded }

class ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final ActionButtonStyle style;
  final bool disabled;

  /// 60 on the Onboarding screen, 45 everywhere else.
  final ActionButtonSize size;

  const ActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.style = ActionButtonStyle.primary,
    this.disabled = false,
    this.size = .normal,
  });

  @override
  Widget build(BuildContext context) {
    final primary = style == ActionButtonStyle.primary;

    final decoration = primary
        ? BoxDecoration(
      color: const Color.fromRGBO(242, 169, 83, 0.85),
      borderRadius: BorderRadius.circular(80),
      border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      boxShadow: [
        BoxShadow(
            color: Colors.black.withValues(alpha: 0.12), blurRadius: 12),
      ],
    )
        : _glassPill();

    return NativeLiquidGlassUtils.supportsLiquidGlass ?
    CNButton(
        enabled: !disabled,
        label: label,
        onPressed: onPressed,
        config:
            .new(
                minHeight: size == .expanded ? 60 : 45,
                style: style == .primary ? .prominentGlass : .clearGlass,
                labelFontWeight: .bold,
                labelFontSize: size == .expanded ? 18 : 16,
                labelColor: style == .secondary ? InSyncColors.white : null
            )
    ) :

    Container(
      height: size == .expanded ? 60 : 45,
      decoration: decoration,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(80),
          onTap: onPressed,
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: size == .expanded ? 18 : 16,
                fontWeight: FontWeight.bold,
                color: primary
                    ? Colors.white.withValues(alpha: 0.85)
                    : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}