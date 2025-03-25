import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/app/widgets/button_widget.dart';
import 'package:graduation_project/app/widgets/custom_form_field.dart';
import 'package:graduation_project/app/widgets/text_button_widget.dart';
import 'package:graduation_project/features/auth_feature/presentation/presentation_logic_holder/auth_cubit.dart';
import 'package:graduation_project/features/auth_feature/presentation/screens/engineer_auth/engineer_forget_password_screen.dart';
import 'package:graduation_project/features/auth_feature/presentation/screens/engineer_auth/engineer_register_screen.dart';
import 'package:graduation_project/features/bottom_navigation_feature/presentation/screens/bottom_navigation_screen.dart';

import '../../../../../app/utils/app_assets.dart';
import '../../../../../app/utils/app_colors.dart';
import '../../../../../app/utils/helper.dart';
import '../../../../../app/widgets/image_widget.dart';
import '../../../../../app/widgets/text_widget.dart';

class EngineerLoginScreen extends StatefulWidget {
  const EngineerLoginScreen({super.key});

  @override
  State<EngineerLoginScreen> createState() => _EngineerLoginScreenState();
}

class _EngineerLoginScreenState extends State<EngineerLoginScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          var cu = AuthCubit.get();
          return Form(
            key: formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 21.sp, vertical: 50),
              children: [
                ImageWidget(
                  imageUrl: AppImages.appLogo,
                  width: 163.w,
                  height: 82.h,
                ),
                35.verticalSpace,
                TextWidget(
                  title: "تسجيل الدخول",
                  titleSize: 24.sp,
                  titleColor: AppColors.mainColor,
                  titleFontWeight: FontWeight.w400,
                ),
                40.verticalSpace,
                CustomFormField(
                  header: "ادخل البريد الايكتروني",
                  keyboardType: TextInputType.emailAddress,
                  controller: cu.engLoginEmailController,
                  errorText: cu.errorMsg,
                ),
                25.verticalSpace,
                CustomFormField(
                  header: "ادخل كلمه المرور",
                  suffixIcon: cu.passObscure==false?Icons.visibility:Icons.visibility_off,
                  controller: cu.engLoginPassController,
                  obscure:cu.passObscure,
                  errorText: cu.errorMsg,
                  iconPressed: () {
                    cu.changeVisible();
                  },
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: CustomTextButton(
                    onPressed: () {
                      navigateTo(EngineerForgetPasswordScreen());
                    },
                    title: "نسيت كلمه المرور؟",
                    titleColor: AppColors.mainColor,
                    titleFontWeight: FontWeight.w400,
                    titleSize: 14.sp,
                  ),
                ),
                19.verticalSpace,
                ButtonWidget(
                  loading: state is LoadingState,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      cu.engineerLogin();
                    }
                  },
                  text: "تسجيل الدخول",
                ),
                57.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      title: "لا يوجد لديك حساب؟ ",
                      titleSize: 20.sp,
                      titleColor: AppColors.black,
                      titleFontWeight: FontWeight.w400,
                    ),
                    CustomTextButton(
                      onPressed: () {
                        navigateTo(EngineerRegisterScreen());
                      },
                      title: "انشاء حساب",
                      titleColor: AppColors.mainColor,
                      titleFontWeight: FontWeight.w400,
                      titleSize: 20.sp,
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
