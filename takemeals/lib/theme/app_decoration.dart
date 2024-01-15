import 'package:flutter/material.dart';
import 'package:takemeals/core/app_export.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillOnPrimaryContainer => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
      );
  static BoxDecoration get fillOnPrimaryContainer1 => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer,
      );

  // Gradient decorations
  static BoxDecoration get gradientPrimaryToOnPrimaryContainer => BoxDecoration(
        border: Border.all(
          color: appTheme.gray6007f,
          width: 8,
          strokeAlign: strokeAlignOutside,
        ),
        gradient: LinearGradient(
          begin: Alignment(0.5, 0),
          end: Alignment(0.5, 0.68),
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.onPrimaryContainer.withOpacity(1),
          ],
        ),
      );

  // Outline decorations
  static BoxDecoration get outlineBlack => BoxDecoration(
        border: Border(
          top: BorderSide(
            color: appTheme.black900.withOpacity(0.15),
            width: 1,
          ),
        ),
      );
  static BoxDecoration get outlineBlack900 => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        border: Border.all(
          color: appTheme.black900.withOpacity(0.25),
          width: 1,
          strokeAlign: strokeAlignOutside,
        ),
      );
  static BoxDecoration get outlineBlack9001 => BoxDecoration(
        border: Border(
          top: BorderSide(
            color: appTheme.black900.withOpacity(0.1),
            width: 2,
          ),
        ),
      );
  static BoxDecoration get outlineGrayF => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        border: Border.all(
          color: appTheme.gray6007f,
          width: 8,
          strokeAlign: strokeAlignOutside,
        ),
      );
}

class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder20 => BorderRadius.circular(
        20,
      );
  // Custom borders
  static BorderRadius get customBorderTL15 => BorderRadius.vertical(
        top: Radius.circular(15),
      );

  // Rounded borders
  static BorderRadius get roundedBorder15 => BorderRadius.circular(
        15,
      );
  static BorderRadius get roundedBorder35 => BorderRadius.circular(
        35,
      );
  static BorderRadius get roundedBorder8 => BorderRadius.circular(
        8,
      );
}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
