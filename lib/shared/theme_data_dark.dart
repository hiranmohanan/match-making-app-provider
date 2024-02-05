import 'package:flutter/material.dart';

import 'font_size.dart';
import 'theme.dart';

final darkTheme = ThemeData(
  brightness: Brightness.dark,
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
  // Add your dark mode theme properties here
);
