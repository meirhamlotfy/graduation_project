import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/app/widgets/button_widget.dart';
import 'package:graduation_project/app/widgets/custom_form_field.dart';
import 'package:graduation_project/app/widgets/text_button_widget.dart';
import 'package:graduation_project/features/auth_feature/presentation/screens/engineer_auth/engineer_reset_password_screen.dart';

import '../../../../../app/utils/app_assets.dart';
import '../../../../../app/utils/app_colors.dart';
import '../../../../../app/utils/helper.dart';
import '../../../../../app/widgets/image_widget.dart';
import '../../../../../app/widgets/text_widget.dart';

class EngineerForgetPasswordScreen extends StatelessWidget {
  const EngineerForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 21.sp,vertical: 50),
        children: [
          ImageWidget(
            imageUrl: AppImages.appLogo,
            width: 163.w,
            height: 82.h,
          ),
          35.verticalSpace,
          TextWidget(
            title: "نسيت كلمه المرور ؟",
            titleSize: 24.sp,
            titleColor: AppColors.mainColor,
            titleFontWeight: FontWeight.w400,
          ),
          40.verticalSpace,
          const CustomFormField(
            header: "ادخل البريد الالكتروني",
            keyboardType: TextInputType.emailAddress,
          ),
          25.verticalSpace,
          19.verticalSpace,
          ButtonWidget(
            onPressed: () {
              navigateTo(EngineerResetPasswordScreen());
            },
            text: "ارسال",
            mainAxisAlignment: MainAxisAlignment.start,
            icon:const ImageWidget(
              imageUrl: AppImages.send,
            ),
          ),
          57.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageWidget(
                imageUrl: AppImages.resend,
                width: 20.w,
                height: 20.h,
              ),
              10.horizontalSpace,
              CustomTextButton(
                onPressed: () {},
                title: "اعاده ارسال الرمز",
                titleColor: AppColors.gery455,
                titleFontWeight: FontWeight.w400,
                titleSize: 16.sp,
              ),
            ],
          )
        ],
      ),
    );
  }
}
