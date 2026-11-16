import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insync/colors.dart';

/// Shared building blocks for the onboarding / auth flow (Figma "Pages":
/// Onboarding, Auth, Create an org).
///
/// Note on blending: the mockups use `mix-blend-mode: screen` with grey fills.
/// Screen-blending a grey of value g at opacity a is mathematically identical
/// to a normal white overlay at opacity a * g, so those fills are expressed
/// as plain white overlays here (no blend layers needed).

const _logoAsset = 'assets/images/logo_sync.svg';

/// Figma canvas width every measurement in the mockups is relative to.
const _designWidth = 402.0;
const _bigLogoDesignSize = 476.0;

/// Breathing room above the title so its glow isn't clipped by the panel's
/// rounded top edge.
const _panelTopPadding = 30.0;

class AuthScaffold extends StatefulWidget {
  /// Frosted panel content (title, fields, buttons).
  final List<Widget> children;

  /// How far the big logo dips behind the panel when the keyboard is closed.
  final double logoOverlap;

  /// Opacity of the panel's frosted gradient at its bottom edge
  /// (0.85 for Onboarding / Create an org, 0.15 for Auth screens).
  final double panelOpacity;

  const AuthScaffold({
    super.key,
    required this.children,
    this.logoOverlap = 30,
    this.panelOpacity = 0.15,
  });

  @override
  State<AuthScaffold> createState() => _AuthScaffoldState();
}

class _AuthScaffoldState extends State<AuthScaffold>
    with SingleTickerProviderStateMixin {
  // Figma motion: rotate 0 → 60° with a spring ease over the first 75% of a
  // ~2s timeline, then hold; plays alternate, infinite.
  late final AnimationController _spin = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1998),
  )..repeat(reverse: true);

  late final Animation<double> _turns = Tween<double>(begin: 0, end: 1 / 6)
      .animate(CurvedAnimation(
        parent: _spin,
        curve: const Interval(0, 0.75, curve: Curves.easeOutBack),
      ));

  @override
  void dispose() {
    _spin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final keyboardOpen = media.viewInsets.bottom > 0;
    final radius = const Radius.circular(62);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: true,
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).unfocus(),
          child: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, InSyncColors.secondary],
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: LayoutBuilder(builder: (context, constraints) {
                    final w = constraints.maxWidth;
                    final h = constraints.maxHeight;

                    double size;
                    double top;
                    if (keyboardOpen) {
                      top = media.padding.top + 25;
                      size = (h - top - 20).clamp(0.0, 200.0);
                    } else {
                      size = w * _bigLogoDesignSize / _designWidth;
                      // Keep the logo in the same place relative to the title.
                      top = h + widget.logoOverlap + _panelTopPadding - size;
                    }

                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeOutCubic,
                          left: (w - size) / 2,
                          top: top,
                          width: size,
                          height: size,
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 200),
                            opacity: size < 40 ? 0 : 1,
                            child: RotationTransition(
                              turns: _turns,
                              child: SvgPicture.asset(_logoAsset),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
                ClipRRect(
                  // Bottom corners follow the device's own screen corners.
                  borderRadius:
                      BorderRadius.only(topLeft: radius, topRight: radius),
                  child: BackdropFilter(
                    // CSS backdrop-blur(40px) is a radius; Flutter's sigma ≈ radius / 2.
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white.withValues(alpha: 0),
                            // screen(rgba(136,136,136,a)) == white @ a*136/255
                            Colors.white.withValues(
                                alpha: widget.panelOpacity * 136 / 255),
                          ],
                        ),
                      ),
                      child: SafeArea(
                        top: false,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              25, _panelTopPadding, 25, keyboardOpen ? 20 : 38),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: widget.children,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Large bold heading ("Sign back into your account.").
class AuthTitle extends StatelessWidget {
  final String text;

  const AuthTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        height: 1.0,
        color: const Color.fromRGBO(232, 232, 232, 0.85),
        shadows: [
          Shadow(color: Colors.black.withValues(alpha: 0.15), blurRadius: 30),
        ],
      ),
    );
  }
}

/// Regular 16pt supporting copy under the title.
class AuthSubtitle extends StatelessWidget {
  final String text;

  const AuthSubtitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, height: 1.0, color: Colors.white),
    );
  }
}

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

class AuthTextField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final ValueChanged<String>? onSubmitted;

  const AuthTextField({
    super.key,
    required this.hint,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: _glassPill(),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        autofillHints: autofillHints,
        onSubmitted: onSubmitted,
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
    );
  }
}

enum AuthButtonStyle { primary, secondary }

class AuthButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AuthButtonStyle style;

  /// 60 on the Onboarding screen, 45 everywhere else.
  final double height;

  const AuthButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.style = AuthButtonStyle.primary,
    this.height = 45,
  });

  @override
  Widget build(BuildContext context) {
    final primary = style == AuthButtonStyle.primary;

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

    return Container(
      height: height,
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
                fontSize: height > 50 ? 18 : 16,
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
