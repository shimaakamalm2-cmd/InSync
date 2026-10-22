import 'package:flutter/material.dart';

/// InSyncColors is an extension on Flutter's base Colors class
/// with additional Colors and the app primary Color Scheme

class InSyncColors {

  static const Color dividerColor = Color.fromARGB(99, 55, 55, 55);

  // MARK: - Backgrounds

  static _PrimaryBackground primaryBackground = _PrimaryBackground();
  static _SecondaryBackground secondaryBackground = _SecondaryBackground();
  static _TertiaryBackground tertiaryBackground = _TertiaryBackground();

  // MARK: - Component Colors

  static const Color prominentItemColor = Color.fromARGB(215, 34, 34, 34);
  static const Color primaryTransparent = Color.fromARGB(215, 255, 165, 62);
  static const Color tabBarSelectionBackground = Color.fromARGB(164, 24, 24, 24);
  static _GenericIconColor genericIconColor = _GenericIconColor();
  static _GenericProminentComponent genericProminentComponent = _GenericProminentComponent();
  static _GenericSecondaryComponent genericSecondaryComponent = _GenericSecondaryComponent();

  // MARK: - Brand Colors

  static const Color primary = Color.fromARGB(255, 255, 162, 62);
  static const Color secondary = Color.fromARGB(255, 255, 177, 99);
  static const Color contenderSecondary = Color.fromARGB(255, 31, 31, 31);
  static const Color tertiary = Color.fromARGB(255, 255, 213, 166);
  static const Color quaternary = Color.fromARGB(255, 255, 229, 200);

  // MARK: - Text Colors

  static _PrimaryText primaryText = _PrimaryText();
  static _SecondaryText secondaryText = _SecondaryText();
  static _TertiaryText tertiaryText = _TertiaryText();
  static Color onPrimaryText = Color.fromARGB(255, 255, 255, 255);
  static Color onSecondaryText = quaternary;
  static Color onTertiaryText = Color.fromARGB(255, 255, 255, 255);

  // MARK: - Generic Colors

  static Color red = Color.fromARGB(255, 255, 57, 57);
  static Color blue = Color.fromARGB(255, 29, 139, 249);
  static Color yellow = Color.fromARGB(255, 251, 209, 0);
  static Color green = Color.fromARGB(255, 0, 206, 34);
  static Color lime = Color.fromARGB(255, 149, 255, 0);
  static Color magenta = Color.fromARGB(255, 249, 87, 255);
  static Color black = Color.fromARGB(255, 0, 0, 0);
  static Color white = Color.fromARGB(255, 255, 255, 255);
}

abstract class AdaptiveColors {

  Color get light;
  Color get dark;
}

// MARK: - Backgrounds

class _PrimaryBackground implements AdaptiveColors {
  @override
  Color get light => Color.fromARGB(255, 255, 255, 255);
  @override
  Color get dark => Color.fromARGB(255, 0, 0, 0);
}

class _SecondaryBackground implements AdaptiveColors {
  @override
  Color get light => Color.fromARGB(215, 239, 239, 239);
  @override
  Color get dark => Color.fromARGB(215, 43, 43, 43);
}

class _TertiaryBackground implements AdaptiveColors {
  @override
  Color get light => Color.fromARGB(215, 209, 209, 209);
  @override
  Color get dark => Color.fromARGB(215, 54, 54, 54);
}

// MARK: - Component Colors

class _GenericIconColor implements AdaptiveColors {
  @override
  Color get light => Color.fromARGB(215, 0, 0, 0);
  @override
  Color get dark => Color.fromARGB(215, 255, 255, 255);
}

class _GenericProminentComponent implements AdaptiveColors {
  @override
  Color get light => Color.fromARGB(215, 255, 255, 255);
  @override
  Color get dark => Color.fromARGB(215, 54, 54, 54);
}

class _GenericSecondaryComponent implements AdaptiveColors {
  @override
  Color get light => Color.fromARGB(164, 206, 206, 206);
  @override
  Color get dark => Color.fromARGB(164, 84, 84, 84);
}

// MARK: - Text Colors

class _PrimaryText implements AdaptiveColors {
  @override
  Color get light => Color.fromARGB(255, 0, 0, 0);
  @override
  Color get dark => Color.fromARGB(255, 255, 255, 255);
}

class _SecondaryText implements AdaptiveColors {
  @override
  Color get light => Color.fromARGB(164, 93, 93, 93);
  @override
  Color get dark => Color.fromARGB(151, 172, 172, 172);
}

class _TertiaryText implements AdaptiveColors {
  @override
  Color get light => Color.fromARGB(215, 48, 48, 48);
  @override
  Color get dark => Color.fromARGB(151, 247, 247, 247);
}

/// Use ExclusionFilter in place of ColoredFilter and BackdropFilter
/// to get the same blend mode used in the app's mockups.

class ExclusionFilter extends Widget {

  final Widget? child;

  const ExclusionFilter({super.key, this.child});

  @override
  Element createElement() {
    return BackdropFilter(blendMode: .exclusion, filterConfig: .blur(),child: child).createElement();
  }
}