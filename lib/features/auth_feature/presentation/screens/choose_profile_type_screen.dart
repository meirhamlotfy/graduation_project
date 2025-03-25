import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/app/utils/app_assets.dart';
import 'package:graduation_project/app/utils/app_colors.dart';
import 'package:graduation_project/app/utils/app_fonts.dart';
import 'package:graduation_project/app/utils/helper.dart';
import 'package:graduation_project/app/widgets/button_widget.dart';
import 'package:graduation_project/app/widgets/image_widget.dart';
import 'package:graduation_project/app/widgets/text_widget.dart';
import 'package:graduation_project/features/auth_feature/presentation/screens/engineer_auth/engineer_login_screen.dart';
import 'package:graduation_project/features/auth_feature/presentation/screens/farmer_auth/farmer_login_screen.dart';
import 'package:graduation_project/features/bottom_navigation_feature/presentation/screens/bottom_navigation_screen.dart';

class ChooseProfileTypeScreen extends StatelessWidget {
  const ChooseProfileTypeScreen({super.key, required this.fromGest});
 final bool fromGest ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sp),
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
              ),
              212.verticalSpace,
              ButtonWidget(
                onPressed: () {
                  navigateTo(const FarmerLoginScreen());
                },
                text: "تسجيل حساب ك مستخدم",
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              20.verticalSpace,
              ButtonWidget(
                onPressed: () {
                  navigateTo(const EngineerLoginScreen());
                },
                text: "تسجيل حساب ك بشمهندس",
                color: AppColors.white,
                outlined: false,
                border: Border.all(color: AppColors.grey455),
                textColor:  AppColors.grey455,
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              !fromGest?20.verticalSpace:0.verticalSpace,
             !fromGest? ButtonWidget(
                onPressed: () {
                  navigateTo(const BNBScreen(),removeAll: true);
                },
                text: "الدخول كضيف",
                mainAxisAlignment: MainAxisAlignment.center,
              )
                 :
             0.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
