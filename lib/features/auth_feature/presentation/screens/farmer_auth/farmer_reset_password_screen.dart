import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/app/widgets/button_widget.dart';
import 'package:graduation_project/app/widgets/custom_form_field.dart';
import 'package:graduation_project/app/widgets/text_button_widget.dart';

import '../../../../../app/utils/app_assets.dart';
import '../../../../../app/utils/app_colors.dart';
import '../../../../../app/widgets/image_widget.dart';
import '../../../../../app/widgets/text_widget.dart';

class FarmerResetPasswordScreen extends StatelessWidget {
  const FarmerResetPasswordScreen({super.key});

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
            title: "تغيير كلمه المرور",
            titleSize: 24.sp,
            titleColor: AppColors.mainColor,
            titleFontWeight: FontWeight.w400,
          ),
          40.verticalSpace,
           CustomFormField(
            header: "ادخل كلمه المرور الحديده",
            suffixIcon:Icons.visibility_off,
            //cubit.passObscure==false?Icons.visibility:Icons.visibility_off,
            //obscure:cubit.passObscure,
            iconPressed: () {
              //cubit.changeVisible();
            },
          ),
          16.verticalSpace,
          CustomFormField(
            header: "اعد ادخال كلمه المرور الجديده",
            suffixIcon:Icons.visibility_off,
            //cubit.passObscure==false?Icons.visibility:Icons.visibility_off,
            //obscure:cubit.passObscure,
            iconPressed: () {
              //cubit.changeVisible();
            },
          ),
          50.verticalSpace,
          ButtonWidget(
            onPressed: () {},
            text: "تغيير",
          ),
        ],
      ),
    );
  }
}
