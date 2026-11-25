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
    duration: const Duration(milliseconds: 3000),
  )..repeat(reverse: true);

  late final Animation<double> _turns = Tween<double>(begin: 0, end: 1 / 6)
      .animate(CurvedAnimation(
    parent: _spin,
    curve: const Interval(0.5, 1, curve: Curves.easeInCubic),
  ));

  double opacity = 0;
  int logoOffset = 0;

  @override
  void initState() {
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
      decoration: BoxDecoration(borderRadius: .all(.circular(0)), gradient: LinearGradient(begin: .bottomCenter, end: .topCenter, colors: [InSyncColors.secondary, Theme.of(context).scaffoldBackgroundColor])),
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
                toolbarHeight: media.orientation == .portrait ? 44 : 52,
                leading: Navigator.canPop(context) && NativeLiquidGlassUtils.supportsLiquidGlass ? Container(

                  padding: .directional(start: 14, top: media.orientation == .landscape ? 10 : 0),
                  // width: 120,
                  // color: Colors.green,
                  child: CNButton.icon(icon: CNSymbol('chevron.left', size: 16), config: .new(width: 20, minHeight: 40, shrinkWrap: false), onPressed: () {
                    Navigator.maybePop(context).then((onValue) {
                      if (onValue) {
                        if (Navigator.canPop(context)) {
                          logoOffset = 250;
                          setState(() {});
                          Navigator.pop(context);
                        }
                      }
                    });
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
                    Flexible(
                      child: LayoutBuilder(builder: (context, constraints) {
                        final w = constraints.maxWidth;
                        final h = constraints.maxHeight;

                        double size;
                        if (keyboardOpen) {
                          if (media.orientation == .portrait) {
                            size = h / 1.45;
                          } else {
                            size = w / 4.5;
                          }
                        } else {
                          if (media.orientation == .portrait) {
                            size = h / 1.05;
                          } else {
                            size = w / 4.5;
                          }
                        }

                        return Stack(
                          clipBehavior: Clip.none,
                          alignment: media.orientation == .landscape ? Alignment.topRight : .topStart,
                          children: [
                            media.orientation == .landscape ?
                            AnimatedPositioned(
                                duration: const Duration(milliseconds: 1250),
                                curve: Curves.easeOutCubic,
                                right: 25,
                                top: media.padding.top + 20,
                                child: Row(
                                  crossAxisAlignment: .end,
                                  children: [
                                    RotationTransition(
                                      turns: _turns,
                                      child: SizedBox(
                                        width: size,
                                        child: SvgPicture.asset(_logoAsset),
                                      ),
                                    ),
                                  ],
                                )
                            ) : AnimatedPositioned(
                              duration: const Duration(milliseconds: 1250),
                              curve: Curves.easeOutCubic,
                              left: ((w - size) / 2) + logoOffset,
                              top: media.padding.top + 24,
                              width: size,
                              child: RotationTransition(
                                turns: _turns,
                                child: SvgPicture.asset(_logoAsset),
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
                                child: Inspire.backdropBlur(config: InspireBlurConfig.bottomToTop(sigmaY: 27, extent: 1.2, fadeCurve: Curves.linear)
                                )
                            ),
                          ),
                          SafeArea(
                            top: false,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                  media.orientation == .landscape && Navigator.of(context).canPop() ? 70 : 25, 9, 25, keyboardOpen ? 20 : 0),
                              child: SingleChildScrollView(
                                child: Column(
                                  spacing: 25,
                                  // mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: widget.children,
                                ),
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
