import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:tsahel/app/utils/app_fonts.dart';
import '../utils/app_colors.dart';

  ThemeData graduationProjectTheme() {
  return ThemeData(
    /// main colors of the app
    //   primaryColor: ColorManager.primary,
    //   primaryColorLight: ColorManager.primaryTwentyPercentLighter,
    //   primaryColorDark: ColorManager.success,
    //   disabledColor: ColorManager.lightColor,
    scaffoldBackgroundColor: AppColors.white,
    //fontFamily: "Itim",
    bottomNavigationBarTheme:const BottomNavigationBarThemeData(
      backgroundColor: AppColors.black,

    ) ,
     canvasColor: Colors.transparent,
     // fontFamily: AppFonts.poppins,
      useMaterial3: true,
      /// App bar theme
    appBarTheme: AppBarTheme(
      systemOverlayStyle: const SystemUiOverlayStyle(
        // Status bar color
        //statusBarColor: AppColors.black,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light
      ),
      centerTitle: false,
      backgroundColor: AppColors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
        // fontFamily: AppFonts.poppins,
        fontSize: 22.sp,
        color: AppColors.white,
      ),
    ),
  );
}
