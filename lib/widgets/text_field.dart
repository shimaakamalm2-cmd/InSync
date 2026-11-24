import 'package:flutter/material.dart';
import 'package:native_liquid_glass/native_liquid_glass.dart';

import '../colors.dart';

/// Translucent pill used by both the "Text Field" and secondary
/// "Wide Prominiant Button" components.
BoxDecoration _glassPill() => BoxDecoration(
  // screen(rgba(34,34,34,0.85)) == white @ 0.85*34/255
  color: Colors.white.withValues(alpha: 0.85 * 34 / 255),
  borderRadius: BorderRadius.circular(80),
  border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
  boxShadow: [
    BoxShadow(color: Colors.black.withValues(alpha: 0.07), blurRadius: 10),
  ],
);

class ActionTextField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final ValueChanged<String>? onSubmit;
  final String? Function(String?)? validator;

  final FocusNode _focusNode = FocusNode();

  ActionTextField({
    super.key,
    required this.hint,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.validator,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {

    if (NativeLiquidGlassUtils.supportsLiquidGlass) {
      return LiquidGlassContainer(
        // animateChanges: true,
        config: .new(shape: .capsule, interactive: true),
        height: 45,
        onTap: () {
          _focusNode.requestFocus();
        },
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            autofillHints: autofillHints,
            onFieldSubmitted: onSubmit,
            validator: validator,
            cursorColor: InSyncColors.primary,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            decoration: InputDecoration(
              isCollapsed: true,
              border: InputBorder.none,
              hintText: hint,
              hintStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white.withValues(alpha: 0.45),
              ),
            ),
          ),
        )
      );
    }

    return InkResponse(
      containedInkWell: true,
      borderRadius: .circular(80),
      onTap: () {
        _focusNode.requestFocus();
      },
      child:
      Container(
        height: 45,
        decoration: _glassPill(),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          autofillHints: autofillHints,
          onFieldSubmitted: onSubmit,
          validator: validator,
          cursorColor: InSyncColors.primary,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            isCollapsed: true,
            border: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white.withValues(alpha: 0.45),
            ),
          ),
        ),
      )
    );
  }
}