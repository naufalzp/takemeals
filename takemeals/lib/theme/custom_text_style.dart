import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodyLargeBlack900 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.black900,
      );
  static get bodyLargeInter => theme.textTheme.bodyLarge!.inter;
  static get bodyLargeMiriamLibreOnPrimaryContainer =>
      theme.textTheme.bodyLarge!.miriamLibre.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        fontSize: 17,
      );
  static get bodyLarge_1 => theme.textTheme.bodyLarge!;
  static get bodySmallInter => theme.textTheme.bodySmall!.inter;
  static get bodySmallInterOnPrimary =>
      theme.textTheme.bodySmall!.inter.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(0.75),
      );
  static get bodySmallOnPrimary => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(0.5),
      );
  static get bodySmallRedA700 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.redA700,
      );
  static get bodySmallRobotoOnPrimary =>
      theme.textTheme.bodySmall!.roboto.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(0.5),
      );
  // Headline text style
  static get headlineLargeSemiBold => theme.textTheme.headlineLarge!.copyWith(
        fontWeight: FontWeight.w600,
      );
  static get headlineSmall24 => theme.textTheme.headlineSmall!.copyWith(
        fontSize: 24,
      );
  // Label text style
  static get labelLargeOnPrimary => theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(0.25),
      );
  static get labelLargeOnPrimary_1 => theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(0.25),
      );
  static get labelLargeRedA700 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.redA700,
        fontWeight: FontWeight.w600,
      );
  static get labelMediumOnPrimary => theme.textTheme.labelMedium!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
        fontWeight: FontWeight.w600,
      );
  // Title text style
  static get titleLargeBlack900 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.black900,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      );
  static get titleLargeMiriamLibreOnPrimaryContainer =>
      theme.textTheme.titleLarge!.miriamLibre.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        fontSize: 23,
      );
  static get titleLargeSemiBold => theme.textTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.w600,
      );
  static get titleMedium18 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 18,
      );
  static get titleMedium3f232323 => theme.textTheme.titleMedium!.copyWith(
        color: Color(0X3F232323),
      );
  static get titleMediumBlack900 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
      );
  static get titleMediumBlack900Bold => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w700,
      );
  static get titleMediumBlack900_1 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
      );
  static get titleMediumOnPrimary => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimary,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumPrimary => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get titleMediumff232323 => theme.textTheme.titleMedium!.copyWith(
        color: Color(0XFF232323),
      );
  static get titleSmallBlack900 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.black900,
      );
  static get titleSmallInter => theme.textTheme.titleSmall!.inter;
  static get titleSmallOnPrimary => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(0.75),
      );
  static get titleSmallOnPrimary_1 => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(0.5),
      );
  static get titleSmallOnPrimary_2 => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onPrimary,
      );
  static get titleSmallOnPrimary_3 => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(0.35),
      );
  static get titleSmallPrimary => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get titleSmallPrimary_2 => theme.textTheme.titleSmall!.copyWith(
        color: Color(0XFF232323),
      );
}

extension on TextStyle {
  TextStyle get miriamLibre {
    return copyWith(
      fontFamily: 'Miriam Libre',
    );
  }

  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }

  TextStyle get roboto {
    return copyWith(
      fontFamily: 'Roboto',
    );
  }

  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }
}
