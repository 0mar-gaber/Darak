import 'package:flutter/material.dart';

import '../core/utils/app_color.dart';

class AppTheme{
  static ThemeData theme =ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      background: AppColors.backGroundColor,
      primary: AppColors.primaryColor,
      secondary: AppColors.secColor,
      tertiary: AppColors.thirdColor
    ),
    scaffoldBackgroundColor: AppColors.backGroundColor,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,



  );

}