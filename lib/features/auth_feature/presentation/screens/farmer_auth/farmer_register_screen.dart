import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/app/widgets/button_widget.dart';
import 'package:graduation_project/app/widgets/custom_form_field.dart';
import 'package:graduation_project/app/widgets/text_button_widget.dart';
import 'package:graduation_project/features/auth_feature/presentation/presentation_logic_holder/auth_cubit.dart';
import 'package:graduation_project/features/auth_feature/presentation/screens/farmer_auth/farmer_login_screen.dart';
import 'package:graduation_project/features/bottom_navigation_feature/presentation/screens/bottom_navigation_screen.dart';

import '../../../../../app/utils/app_assets.dart';
import '../../../../../app/utils/app_colors.dart';
import '../../../../../app/utils/helper.dart';
import '../../../../../app/widgets/custom_drop_down.dart';
import '../../../../../app/widgets/image_widget.dart';
import '../../../../../app/widgets/text_widget.dart';

class FarmerRegisterScreen extends StatefulWidget {
  const FarmerRegisterScreen({super.key});

  @override
  State<FarmerRegisterScreen> createState() => _FarmerRegisterScreenState();
}

class _FarmerRegisterScreenState extends State<FarmerRegisterScreen> {
  List <String> governorates = ["الشرقيه", "القاهره", "الاسكندريه", "الدقهلية"];
  List <String> cities = ["شرق الزقازيق", "ابو كبير", "غرب الزقازيق", "فاقوس"];
  String ? selectedGovernorate;
  String ? selectedCity;
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
                  title: "انشاء الحساب",
                  titleSize: 24.sp,
                  titleColor: AppColors.mainColor,
                  titleFontWeight: FontWeight.w400,
                ),
                40.verticalSpace,
                CustomFormField(
                  header: "الاسم",
                  controller:  cu.farmerRegisterNameController,
                  errorText: cu.errorMsg==null?null:"لازم يكون علي الاقل 4 حروف",
                ),
                16.verticalSpace,
                CustomFormField(
                  header: "رقم التلفون",
                  controller: cu.farmerRegisterPhoneController,
                  keyboardType: TextInputType.phone,
                  errorText: cu.errorMsg==null?null:"لازم يكون 11 رقم",
                ),
                16.verticalSpace,
                CustomFormField(
                  header: "اذخل الايميل",
                  controller: cu.farmerRegisterEmailController,
                  keyboardType: TextInputType.emailAddress,
                  errorText: cu.errorMsg==null?null:"لازم يكون بشكل صحيح",
                ),
                16.verticalSpace,
                CustomFormField(
                  header: "كلمه المرور",
                  controller: cu.farmerRegisterPassController,
                  errorText: cu.errorMsg==null?null:"كلمه المرور لازم تكون اكبر من 6 حروف او ارقام",
                  suffixIcon: cu.passObscure==false?Icons.visibility:Icons.visibility_off,
                  obscure:cu.passObscure,
                  iconPressed: () {
                    cu.changeVisible();
                  },
                ),
                16.verticalSpace,
                CustomDropDown(
                  height: 56.h,
                  onItemChanged: (val) {
                    selectedGovernorate = val;
                    setState(() {
                      cu.government = val;
                    });
                  },
                  items: governorates,
                  dropDownHint: selectedGovernorate ?? "المحافظه",
                  headLine: "محافظتك",
                ),
                16.verticalSpace,
                CustomDropDown(
                  height: 56.h,
                  onItemChanged: (val) {
                    selectedCity = val;
                    setState(() {
                      cu.city = val;
                    });
                  },
                  items: cities,
                  dropDownHint: selectedCity ?? "المدينه",
                  headLine: "مدينتك",
                ),
                55.verticalSpace,
                ButtonWidget(
                  loading: state is LoadingState,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      cu.farmerRegister();
                    }
                  },
                  text: "انشاء الحساب",
                ),
                20.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      title: "انت بالفعل عندك حساب ؟",
                      titleSize: 20.sp,
                      titleColor: AppColors.black,
                      titleFontWeight: FontWeight.w400,
                    ),
                    CustomTextButton(
                      onPressed: () {
                        navigateTo(FarmerLoginScreen());
                      },
                      title: "سجل دخول",
                      titleColor: AppColors.mainColor,
                      titleFontWeight: FontWeight.w400,
                      titleSize: 20.sp,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
