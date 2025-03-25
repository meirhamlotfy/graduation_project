import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/features/intro_feature/data/models/onboard_model.dart';

import '../../../../app/utils/app_assets.dart';
import '../../../../app/utils/app_colors.dart';
import '../../../../app/utils/app_fonts.dart';
import '../../../../app/widgets/image_widget.dart';
import '../../../../app/widgets/text_widget.dart';

class CustomOnboardBody extends StatelessWidget {
  const CustomOnboardBody({super.key, required this.onBoardModel});
  final OnBoardModel onBoardModel;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.symmetric(horizontal: 21.w),
      child: Column(
        children: [
          ImageWidget(
            imageUrl:onBoardModel.image?? AppImages.onBoard,
            width: 340.w,
            height: 252.h,
          ),
          40.verticalSpace,
          TextWidget(
            title: onBoardModel.title1?? "grow the plants",
            titleSize: 20.sp,
            titleColor: AppColors.mainColor,
            titleFontWeight: FontWeight.w400,
          ),
          20.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.sp),
            child:  TextWidget(
              title:onBoardModel.title2,
              titleMaxLines: 5,
              fontFamily: AppFonts.regular,
            ),
          ),
        ],
      ),
    );
  }
}
