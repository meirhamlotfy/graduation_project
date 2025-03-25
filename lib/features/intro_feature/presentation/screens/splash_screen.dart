import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/app/utils/app_assets.dart';
import 'package:graduation_project/app/utils/app_colors.dart';
import 'package:graduation_project/app/utils/app_fonts.dart';
import 'package:graduation_project/app/utils/helper.dart';
import 'package:graduation_project/app/widgets/image_widget.dart';
import 'package:graduation_project/app/widgets/text_widget.dart';
import 'package:graduation_project/features/intro_feature/presentation/screens/on_board_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      navigateTo(const OnBoardScreen(), replace: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageWidget(
              imageUrl: AppImages.appLogo,
              width: 309.w,
              height: 200.h,
            ),
            TextWidget(
              title: "Grow.Ai",
              titleSize: 24.sp,
              titleColor: AppColors.mainColor,
              titleFontWeight: FontWeight.w400,
            )
          ],
        ),
      ),
    );
  }
}
