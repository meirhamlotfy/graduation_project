import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/app/widgets/button_widget.dart';
import 'package:graduation_project/app/widgets/custom_form_field.dart';
import 'package:graduation_project/app/widgets/text_button_widget.dart';
import 'package:graduation_project/features/auth_feature/presentation/presentation_logic_holder/auth_cubit.dart';
import 'package:graduation_project/features/auth_feature/presentation/screens/engineer_auth/engineer_login_screen.dart';
import 'package:graduation_project/features/bottom_navigation_feature/presentation/screens/bottom_navigation_screen.dart';
import '../../../../../app/utils/app_assets.dart';
import '../../../../../app/utils/app_colors.dart';
import '../../../../../app/utils/helper.dart';
import '../../../../../app/widgets/custom_drop_down.dart';
import '../../../../../app/widgets/image_widget.dart';
import '../../../../../app/widgets/text_widget.dart';

class EngineerRegisterScreen extends StatefulWidget {
  const EngineerRegisterScreen({super.key});

  @override
  State<EngineerRegisterScreen> createState() => _EngineerRegisterScreenState();
}

class _EngineerRegisterScreenState extends State<EngineerRegisterScreen> {
  List <String>  governorates = ["الشرقيه","القاهره","الاسكندريه","الدقهلية"];
  List <String>  cities = ["شرق الزقازيق","ابو كبير","غرب الزقازيق","فاقوس"];
  List <String>  departments = ["بكتريا","امراض","مساحه"];
  List <String>  faculties = ["كليه الزراعه جامعة الزقازيق","كليه الزراعه جامعة المنصوره","كليه الزراعه جامعة عين شمس"];
  String ? selectedGovernorate;
  String ? selectedCity;
  String ? selectedDepart;
  String ? selectedFac;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(
  builder: (context, state) {
    var cubit = AuthCubit.get();
    return Form(
      key: formKey,
      child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 21.sp,vertical: 50),
          children: [
            ImageWidget(
              imageUrl: AppImages.appLogo,
              width: 163.w,
              height: 82.h,
            ),
            35.verticalSpace,
            TextWidget(
              title: "انشاء حساب",
              titleSize: 24.sp,
              titleColor: AppColors.mainColor,
              titleFontWeight: FontWeight.w400,
            ),
            40.verticalSpace,
            CustomFormField(
              header: "ادخل الاسم",
              controller: cubit.signUpFullNameController,
            ),
            16.verticalSpace,
            CustomFormField(
              header: "ادخل رقم التلفون",
              keyboardType: TextInputType.phone,
              controller: cubit.signUpPhoneController,
            ),
            16.verticalSpace,
            CustomFormField(
              header: "ادخل البريد الالكتروني",
              keyboardType: TextInputType.emailAddress,
              controller: cubit.signUpEmailController,
            ),
            16.verticalSpace,
            CustomFormField(
              header: "ادخل الرقم التعريفي",
              keyboardType: TextInputType.phone,
              controller: cubit.signUpNationalIDController,
            ),
            16.verticalSpace,
            CustomFormField(
              header: "ادخل كلمه المرور",
              suffixIcon:Icons.visibility_off,
              controller: cubit.signUpPasswordController,
              //cubit.passObscure==false?Icons.visibility:Icons.visibility_off,
              //obscure:cubit.passObscure,
              iconPressed: () {
                //cubit.changeVisible();
              },
            ),
            16.verticalSpace,
            CustomFormField(
              header: "ادخل القيمه المدفوعه",
              controller: cubit.signUpPriceController,
              keyboardType: TextInputType.numberWithOptions(),
            ),
            16.verticalSpace,
            CustomDropDown(
              height: 56.h,
              onItemChanged: (val) {

                setState(() {
                  selectedGovernorate = val;
                  cubit.government=val;
                });
              },
              items: governorates,
              dropDownHint: selectedGovernorate ?? "المحافظه",
              headLine: "اختار محافظتك",
            ),
            16.verticalSpace,
            CustomDropDown(
              height: 56.h,
              onItemChanged: (val) {
                selectedCity = val;
                cubit.city=val;
                setState(() {

                });
              },
              items: cities,
              dropDownHint: selectedCity ?? "المدينه",
              headLine: "اختار مدينتك",
            ),
            16.verticalSpace,
            // CustomDropDown(
            //   onItemChanged: (val) {
            //     selectedFac = val;
            //     print(selectedFac);
            //   },
            //   items: faculties,
            //   dropDownHint: selectedFac ?? "الجامعة",
            //   headLine: "اختار جامعتك",
            // ),
            //16.verticalSpace,
            CustomDropDown(
              height: 56.h,
              onItemChanged: (val) {
                selectedDepart = val;
                cubit.department=val;
                setState(() {

                });
              },
              items: departments,
              dropDownHint: selectedDepart ?? "اختار التخصص",
              headLine: "اختار تخصصك",
            ),
            55.verticalSpace,
            ButtonWidget(
              loading: state is LoadingState,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  cubit.engineerRegister();
                }
              },
              text: "انشاء الحساب",
            ),
            20.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                  title: "لديك حساب بالفعل ؟",
                  titleSize: 20.sp,
                  titleColor: AppColors.black,
                  titleFontWeight: FontWeight.w400,
                ),
                CustomTextButton(
                  onPressed: () {
                    navigateTo(EngineerLoginScreen());
                  },
                  title: "تسجيل الدخول",
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
