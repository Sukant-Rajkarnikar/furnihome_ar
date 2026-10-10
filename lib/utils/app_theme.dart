import 'package:flutter/material.dart';
import 'package:furnihome_ar/utils/colors.dart';

@immutable
class AppTheme {
  static const colors = AppColors();

  const AppTheme._();

  static ThemeData define() {
    return ThemeData(
        fontFamily: 'HankenGrotesk',
        primaryColor: colors.backGroundColor,
        scaffoldBackgroundColor: colors.secondaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(scrolledUnderElevation: 0, backgroundColor: Colors.transparent,),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: colors.secondaryColor)
            .copyWith(surface: colors.backGroundColor));
  }
}
