import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/app/utils/app_assets.dart';
import 'package:graduation_project/app/utils/app_colors.dart';
import 'package:graduation_project/app/widgets/image_widget.dart';

class CustomScanButton extends StatelessWidget {
  const CustomScanButton({super.key, this.icon, this.color, this.onTap});
 final Widget ? icon;
 final Color ? color;
 final VoidCallback ? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap??(){},
      child: Container(
        width: 60.w,
        height: 60.h,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:color?? AppColors.mainColor
        ),
        child:icon?? ImageWidget(
          imageUrl: AppImages.qrScan,
          width: 25.w,
          height: 25.h,
          color: AppColors.white,
        ),
      ),
    );
  }
}
