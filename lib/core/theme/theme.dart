import 'package:blog_app/core/theme/app_pallet.dart';
import 'package:flutter/material.dart';

class AppTheme {
  // border function  change the color of the feild when going from focused border to enabled border
  static _border({Color color = AppPallet.borderColor}) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10),
      ) ;
  //copy with extends the darktheme with addtion options 
  // done due to the dark theme is not equal to correct color provoided 
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallet.backgroundColor,
    // here we are defining the genral input theme for all the input feild across app
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(25),
      enabledBorder: _border(),
      focusedBorder: _border(color: AppPallet.gradient2),
    ),
    chipTheme: ChipThemeData(
      color: WidgetStatePropertyAll(
        AppPallet.backgroundColor,
      ),
      side: BorderSide.none
    ),
    appBarTheme: AppBarTheme(
      color: const Color.fromARGB(255, 12, 2, 2),
      elevation: 0,
    ),
  );
}

