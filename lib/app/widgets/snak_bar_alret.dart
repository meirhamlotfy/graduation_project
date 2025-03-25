import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/app/widgets/text_widget.dart';

import '../utils/app_colors.dart';
import '../utils/get_it_injection.dart';
import '../utils/navigation_helper.dart';


showSnackBar({
  String? message,
  IconData ? icon,
  Color? color,
  double? margin,
  double? padding,
  SnackBarBehavior? behavior
}) {
  ScaffoldMessenger.of(getIt<NavHelper>().navigatorKey.currentState!.context).showSnackBar(
    SnackBar(
      backgroundColor:color?? AppColors.red,
      duration:const Duration(seconds: 2),
      behavior:behavior?? SnackBarBehavior.floating,
      padding: EdgeInsets.symmetric(vertical: padding??17.h,horizontal:padding?? 16.w),
      margin: EdgeInsets.symmetric(horizontal:margin?? 20.sp,vertical:margin?? 60.h),
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      content: Align(
        alignment: AlignmentDirectional.center,
        child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWidget(
                title:message??"Text Copied".tr(),
                titleSize: 16.sp,
                titleFontWeight: FontWeight.w500,
                titleColor: AppColors.white,
              ),
              8.horizontalSpace,
              Icon(
                icon?? Icons.check_circle,
                color: AppColors.white,
                size: 18.sp,
              ),


            ]
        ),
      ),
    ),
  );
}