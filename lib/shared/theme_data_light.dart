import 'package:flutter/material.dart';
import 'package:match_making_test/shared/colors.dart';

import 'font_size.dart';
import 'theme.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: KLightStyle.primaryButtonColor,
  canvasColor: KLightStyle.mainBackgroundColor,
  fontFamily: KLightStyle.mainFontFamily,
  scaffoldBackgroundColor: KLightStyle.secondaryBackgroundColor,
  appBarTheme: AppBarTheme(
    iconTheme: const IconThemeData(color: KLightStyle.textFieldIconColor),
    backgroundColor: KLightStyle.secondaryBackgroundColor,
    titleTextStyle: TextStyle(
      color: KLightStyle.primaryTextColor,
      fontSize: FontSize.kLarge,
      fontWeight: FontWeight.w500,
    ),
    elevation: 0,
  ),
  useMaterial3: true,
  colorScheme: const ColorScheme.light(
    primary: KConstantColors.greyColor,
    secondary: KLightStyle.secondaryButtonColor,
    surface: KLightStyle.secondaryBackgroundColor,
    background: KLightStyle.mainBackgroundColor,
    error: KLightStyle.dangerColor,
    onPrimary: KLightStyle.primaryButtonTextColor,
    onSecondary: KLightStyle.secondaryButtonTextColor,
    onSurface: KLightStyle.regularTextColor,
    onBackground: KLightStyle.primaryTextColor,
    onError: KLightStyle.lightTextColor,
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
        color: KLightStyle.primaryTextColor, fontSize: FontSize.kLarge),
    headlineLarge: TextStyle(
        color: KLightStyle.primaryTextColor, fontSize: FontSize.kLarge),
    headlineMedium: TextStyle(
        color: KLightStyle.regularTextColor, fontSize: FontSize.kReguler),
    headlineSmall:
        TextStyle(color: KLightStyle.lightTextColor, fontSize: FontSize.kSmall),
    labelLarge: TextStyle(
        color: KLightStyle.primaryTextColor, fontSize: FontSize.kLarge),
    labelMedium: TextStyle(
        color: KLightStyle.regularTextColor, fontSize: FontSize.kReguler),
    labelSmall:
        TextStyle(color: KLightStyle.lightTextColor, fontSize: FontSize.kSmall),
    bodyLarge: TextStyle(
        color: KLightStyle.primaryTextColor, fontSize: FontSize.kLarge),
    bodyMedium: TextStyle(
        color: KLightStyle.regularTextColor, fontSize: FontSize.kReguler),
    bodySmall:
        TextStyle(color: KLightStyle.lightTextColor, fontSize: FontSize.kSmall),
    displayMedium: TextStyle(
        color: KLightStyle.primaryTextColor, fontSize: FontSize.kReguler),
    displaySmall:
        TextStyle(color: KLightStyle.lightTextColor, fontSize: FontSize.kSmall),
    titleLarge: TextStyle(
        color: KLightStyle.primaryTextColor, fontSize: FontSize.kLarge),
    titleMedium: TextStyle(
        color: KLightStyle.regularTextColor, fontSize: FontSize.kReguler),
    titleSmall:
        TextStyle(color: KLightStyle.lightTextColor, fontSize: FontSize.kSmall),
  ),
  buttonTheme: const ButtonThemeData(
    colorScheme:
        ColorScheme.light(primary: KLightStyle.textFieldBackgroundColor),
    buttonColor: KLightStyle.primaryButtonColor,
    textTheme: ButtonTextTheme.primary,
    alignedDropdown: true,
    shape: BeveledRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(7)),
    ),
    splashColor: KLightStyle.regularButtonColor,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: KLightStyle.floatingActionButtonBackgroundColor,
    foregroundColor: KLightStyle.floatingActionButtonTextColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.all(10),
    focusColor: KLightStyle.primaryTextColor,
    activeIndicatorBorder: const BorderSide(
      color: KLightStyle.primaryTextColor,
      width: 2,
    ),
    border: OutlineInputBorder(
      gapPadding: 5,
      borderSide: const BorderSide(
          color: KLightStyle.textFieldTextColor,
          width: 2,
          style: BorderStyle.solid),
      borderRadius: BorderRadius.circular(5),
    ),
    alignLabelWithHint: true,
    hintStyle: TextStyle(
      color: KLightStyle.textFieldPlaceholderColor,
      fontWeight: KLightStyle.textFieldTextFontWeight,
      fontSize: FontSize.kReguler,
    ),
    labelStyle: TextStyle(
      color: KLightStyle.textFieldTextColor,
      fontWeight: KLightStyle.textFieldTextFontWeight,
      fontSize: FontSize.kReguler,
    ),
    errorStyle: TextStyle(
      color: KLightStyle.regularTextColor,
      fontWeight: KLightStyle.textFieldTextFontWeight,
      fontSize: FontSize.kReguler,
    ),
  ),
  expansionTileTheme: const ExpansionTileThemeData(
    iconColor: KLightStyle.primaryTextColor,
    backgroundColor: KLightStyle.listBackground,
    textColor: KLightStyle.primaryTextColor,
    collapsedIconColor: KLightStyle.primaryTextColor,
    collapsedBackgroundColor: KLightStyle.listBackground,
    collapsedTextColor: KLightStyle.primaryTextColor,
    tilePadding: EdgeInsets.all(10),
    childrenPadding: EdgeInsets.all(10),
    shape: BeveledRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(7)),
    ),
  ),
  cardTheme: const CardTheme(
    shadowColor: KLightStyle.tagBackgroundColor,
    elevation: 3,
    color: KLightStyle.listBackground,
  ),
);
