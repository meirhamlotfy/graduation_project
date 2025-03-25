import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/app/utils/app_assets.dart';
import 'package:graduation_project/app/utils/app_colors.dart';
import 'package:graduation_project/app/widgets/image_widget.dart';

class CustomEditButton extends StatelessWidget {
  const CustomEditButton({super.key, this.onPressed, this.icon, this.backColor, this.iconColor, this.size,this.iconSize});
 final void Function()? onPressed;
 final IconData? icon;
 final Color ? backColor;
 final double ? iconSize;
 final double ? size;
 final Color ? iconColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size??30.w,
      height: size??30.h,
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
          color:backColor??AppColors.mainColor2.withOpacity(.2),
          borderRadius: BorderRadius.circular(8)
      ),
      child: IconButton(
          padding: EdgeInsets.zero,
          onPressed:onPressed??() {},
          icon:const ImageWidget(imageUrl: AppImages.editProfile)
      ),
    );
  }
}
