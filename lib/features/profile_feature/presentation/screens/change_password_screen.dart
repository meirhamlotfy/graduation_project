import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/app/utils/app_assets.dart';
import 'package:graduation_project/app/widgets/button_widget.dart';
import 'package:graduation_project/features/profile_feature/presentation/widgets/custom_sheet_profile.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../app/services/cache_service.dart';
import '../../../../app/services/image_picker_service/image_picker_service.dart';
import '../../../../app/utils/app_colors.dart';
import '../../../../app/utils/get_it_injection.dart';
import '../../../../app/utils/helper.dart';
import '../../../../app/widgets/custom_form_field.dart';
import '../../../../app/widgets/default_app_bar_widget.dart';
import '../../../../app/widgets/text_widget.dart';
import '../widgets/custom_edit_button.dart';


class ChangPasswordScreen extends StatefulWidget {
  const ChangPasswordScreen({super.key});

  @override
  State<ChangPasswordScreen> createState() => _ChangPasswordScreenState();
}

class _ChangPasswordScreenState extends State<ChangPasswordScreen> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.mainColor,
        resizeToAvoidBottomInset: true,
        appBar: const DefaultAppBarWidget(
          canBack: true,
          titleColor: AppColors.white,
          leadingColor: AppColors.white,
          title: "تغيير كلمة السر",
        ),
        body: Column(
          children: [
            50.verticalSpace,
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.sp),
                    topLeft: Radius.circular(20.sp),
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.all(16),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        50.verticalSpace,
                        CustomFormField(
                          header: "ادخل كلمه المرور الجديده",
                        ),
                        16.verticalSpace,
                        CustomFormField(
                          header: "اعد ادخال كلمه المرور الجديده",
                        ),
                        100.verticalSpace,
                        ButtonWidget(
                          onPressed: () {},
                          text: "تأكيد",
                          textSize: 20.sp,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        )

    );
  }
}
