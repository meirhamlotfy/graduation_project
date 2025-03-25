import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/app/utils/app_colors.dart';
import 'package:graduation_project/app/utils/helper.dart';
import 'package:graduation_project/app/widgets/custom_alert_dialog.dart';
import 'package:graduation_project/app/widgets/default_app_bar_widget.dart';
import 'package:graduation_project/app/widgets/list_tile_widget.dart';
import 'package:graduation_project/app/widgets/text_widget.dart';
import 'package:graduation_project/features/auth_feature/presentation/screens/choose_profile_type_screen.dart';
import 'package:graduation_project/features/chat_feature/data/models/messsage_model.dart';
import 'package:graduation_project/features/chat_feature/presentation/widgets/custom_chat_bubble_item.dart';
import 'package:graduation_project/features/profile_feature/presentation/screens/about_us_screen.dart';
import 'package:graduation_project/features/profile_feature/presentation/screens/edit_profile_screen.dart';
import 'package:graduation_project/features/profile_feature/presentation/screens/language_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/services/cache_service.dart';
import '../../../../app/utils/app_assets.dart';
import '../../../../app/utils/get_it_injection.dart';
import '../../../../app/widgets/custom_form_field.dart';
import '../../../../app/widgets/image_widget.dart';
import 'change_password_screen.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBarWidget(
        title: "الملف الشخصي",
        titleColor: AppColors.black,
        centerTitle: true,
        canBack: false,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
        children: [
          getIt<CacheService>().getUserImage()==null?
          ImageWidget(
            imageUrl: "https://cdn-icons-png.flaticon.com/128/149/149071.png",
            width: 100.w,
            height: 100.h,
            // fit: BoxFit.cover,
          )
              :
          CircleAvatar(
            radius: 60.r,
            backgroundImage: FileImage(File(getIt<CacheService>().getUserImage()??"")),
          ),
          5.verticalSpace,
          TextWidget(
            title:getIt<CacheService>().getUserData()?.name??"منار",
            titleColor: AppColors.mainColor,
            titleSize: 16.sp,
            titleFontWeight: FontWeight.w600,
          ),
          30.verticalSpace,
          ListTileWidget(
            onTap: (){
              navigateTo(EditProfileScreen());
            },
            title: "تعديل الحساب",
            image: true,
            imageUrl: AppImages.editProfile,
          ),
          35.verticalSpace,
          ListTileWidget(
            onTap: (){
              navigateTo(ChangPasswordScreen());
            },
            title: "تغيير كلمه المرور",
            image: false,
            icon: Icons.password,
            iconColor: AppColors.mainColor,
          ),
          // 35.verticalSpace,
          // ListTileWidget(
          //   onTap: (){
          //     //navigateTo(AboutUSScreen());
          //   },
          //   title: "الشهادات",
          //   image: false,
          //   icon: Icons.note,
          //   iconColor: AppColors.mainColor,
          // ),
          35.verticalSpace,
          ListTileWidget(
            onTap: (){
              navigateTo(AboutUSScreen());
            },
            title: "عن المطورين",
            image: true,
            imageUrl: AppImages.settings,
          ),
          35.verticalSpace,
          ListTileWidget(
            onTap: (){
              navigateTo(LanguageScreen());
            },
            title: "اللغه",
            image: true,
            imageUrl: AppImages.lang,
          ),
          35.verticalSpace,
          ListTileWidget(
            onTap: (){
              globalAlertDialogue("هل تريد تسجيل الخروج؟",
                onOk: () async {
                  getIt<CacheService>().clear();
                  navigateTo(ChooseProfileTypeScreen(fromGest: false),removeAll: true);
                },
                canCancel: true,
                onCancel: (){
                  Navigator.pop(context);
                },
                okButtonText: "نعم",
                cancelButtonText: "لا",
              );
            },
            title: "تسجيل خروج",
            image: true,
            iconColor: AppColors.red,
            imageUrl: AppImages.logout,
          ),
          // 35.verticalSpace,
          // ListTileWidget(
          //   onTap: (){},
          //   title: "حذف الحساب",
          //   icon: Icons.delete_forever,
          // ),
          35.verticalSpace,
        ],
      ),
    );
  }
}
