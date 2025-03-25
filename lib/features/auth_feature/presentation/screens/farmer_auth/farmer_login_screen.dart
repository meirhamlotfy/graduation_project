import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/app/services/cache_service.dart';
import 'package:graduation_project/app/utils/get_it_injection.dart';
import 'package:graduation_project/app/widgets/button_widget.dart';
import 'package:graduation_project/app/widgets/custom_form_field.dart';
import 'package:graduation_project/app/widgets/text_button_widget.dart';
import 'package:graduation_project/features/auth_feature/presentation/presentation_logic_holder/auth_cubit.dart';
import 'package:graduation_project/features/bottom_navigation_feature/presentation/screens/bottom_navigation_screen.dart';
import 'package:graduation_project/features/home_feature/presentation/screens/home_screen.dart';

import '../../../../../app/utils/app_assets.dart';
import '../../../../../app/utils/app_colors.dart';
import '../../../../../app/utils/helper.dart';
import '../../../../../app/widgets/image_widget.dart';
import '../../../../../app/widgets/text_widget.dart';
import 'farmer_forget_password_screen.dart';
import 'farmer_register_screen.dart';

class FarmerLoginScreen extends StatefulWidget {
  const FarmerLoginScreen({super.key});

  @override
  State<FarmerLoginScreen> createState() => _FarmerLoginScreenState();
}

class _FarmerLoginScreenState extends State<FarmerLoginScreen> {
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
                  header: "اذخل الايميل",
                  controller: cu.loginEmailController,
                   errorText: cu.errorMsg,
                  keyboardType: TextInputType.emailAddress,
                ),
                25.verticalSpace,
                CustomFormField(
                  header: "ادخل كلمه المرور",
                  controller: cu.loginPasswordController,
                  suffixIcon: cu.passObscure==false?Icons.visibility:Icons.visibility_off,
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
                      navigateTo(const FarmerForgetPasswordScreen());
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
                    //getIt<CacheService>().clear();
                    if (formKey.currentState!.validate()) {
                      cu.farmerLogin();
                    }
                  },
                  text: "تسجيل الدخول",
                ),
                57.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      title: "لا يوجد لديك حساب؟",
                      titleSize: 20.sp,
                      titleColor: AppColors.black,
                      titleFontWeight: FontWeight.w400,
                    ),
                    CustomTextButton(
                      onPressed: () {
                        navigateTo(const FarmerRegisterScreen());
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
