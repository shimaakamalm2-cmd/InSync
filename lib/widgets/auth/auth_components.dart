import 'package:cupertino_native_better/components/button.dart';
import 'package:cupertino_native_better/style/sf_symbol.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inspire_blur/inspire_blur.dart';
import 'package:insync/colors.dart';
import 'package:native_liquid_glass/native_liquid_glass.dart';

/// Shared building blocks for the onboarding / auth flow (Figma "Pages":
/// Onboarding, Auth, Create an org).
///
/// Note on blending: the mockups use `mix-blend-mode: screen` with grey fills.
/// Screen-blending a grey of value g at opacity a is mathematically identical
/// to a normal white overlay at opacity a * g, so those fills are expressed
/// as plain white overlays here (no blend layers needed).

const _logoAsset = 'assets/images/logo_sync.svg';

/// Figma canvas width every measurement in the mockups is relative to.

class OnboardingSkeleton extends StatefulWidget {
  /// Frosted panel content (title, fields, buttons).
  final List<Widget> children;

  const OnboardingSkeleton({
    super.key,
    required this.children,
  });

  @override
  State<OnboardingSkeleton> createState() => _OnboardingSkeletonState();
}

class _OnboardingSkeletonState extends State<OnboardingSkeleton>
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

  double opacity = 0;

  @override
  void initState() {
    Inspire.warmUp();
    super.initState();
    Future.delayed(Duration(microseconds: 1), () {
      setState(() {
        opacity = 1;
      });
    });
  }

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

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
          children: [
            AnimatedOpacity(
              opacity: opacity,
              duration: Duration(milliseconds: 1200),
              child: Container(
                // width: 200,
                // height: 200,
                decoration: BoxDecoration(borderRadius: .all(.circular(0)), gradient: LinearGradient(begin: .bottomCenter, end: .topCenter, colors: [InSyncColors.secondary, Theme.of(context).scaffoldBackgroundColor])),
                clipBehavior: .hardEdge,
              ),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              extendBodyBehindAppBar: true,

              appBar: AppBar(
                forceMaterialTransparency: true,
                leadingWidth: 58,
                toolbarHeight: 44,
                leading: Navigator.canPop(context) && NativeLiquidGlassUtils.supportsLiquidGlass ? Container(

                  padding: .directional(start: 14),
                  // width: 120,
                  // color: Colors.green,
                  child: CNButton.icon(icon: CNSymbol('chevron.left', size: 16), config: .new(width: 20, minHeight: 40, shrinkWrap: false), onPressed: () {
                    Navigator.pop(context);
                  },),
                ) : null,
              ),
              resizeToAvoidBottomInset: true,
              body: GestureDetector(
                behavior: .translucent,
                onTap: () => FocusScope.of(context).unfocus(),
                child:
                Column(
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
                          size = media.size.width + 80;

                        }

                        return Stack(
                          clipBehavior: Clip.none,
                          children: [
                            AnimatedPositioned(
                              duration: const Duration(milliseconds: 1250),
                              curve: Curves.easeOutCubic,
                              left: (w - size) / 2,
                              top: media.padding.top + 24,
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
                      borderRadius: BorderRadius.only(topLeft: radius, topRight: radius),

                      child: Stack(
                        children: [
                          Positioned.fill(
                            child:
                            IgnorePointer(
                                child: Inspire.backdropBlur(
                                    config: InspireBlurConfig.bottomToTop(sigmaX: 20, sigmaY: 55)
                                )
                            ),
                          ),
                          SafeArea(
                            top: false,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                  25, 9, 25, keyboardOpen ? 20 : 0),
                              child: Column(
                                spacing: 25,
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: widget.children,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]
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
    return ScreenFilter(
      child: Text(
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
