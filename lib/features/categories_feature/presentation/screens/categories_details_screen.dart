import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:graduation_project/app/utils/app_colors.dart';
import 'package:graduation_project/app/widgets/default_app_bar_widget.dart';

import '../../../../app/utils/app_assets.dart';
import '../../../../app/utils/consts.dart';
import '../../../../app/widgets/image_widget.dart';
import '../../../../app/widgets/text_widget.dart';

class CategoriesDetailsScreen extends StatefulWidget {
  const CategoriesDetailsScreen({super.key});

  @override
  State<CategoriesDetailsScreen> createState() => _CategoriesDetailsScreenState();
}

class _CategoriesDetailsScreenState extends State<CategoriesDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBarWidget(
        title: "cat Name",
        titleColor: AppColors.mainColor,
        leadingColor: AppColors.mainColor,
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.sp),
        children: [
          Container(
            height: 270.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.greyD9D9D9
            ),
            child: ImageWidget(
                imageUrl: AppImages.frame,
                width: 182.w,
                height: 259.h
            ),
          ),
          20.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                title: " About",
                titleColor: AppColors.mainColor,
                titleAlign: TextAlign.start,
                titleSize: 20.sp,
              ),
              IconButton(
                  onPressed: (){
                    speak('مرحبا بكم في فريقنا ، نتمنى لكم يوما سعيداََ');
                  },
                  icon: Icon(
                    Icons.headset_mic_rounded,
                    size: 25.sp,
                    color: AppColors.mainColor,
                  ),
              )
            ],
          ),
          const TextWidget(
            title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's",
            titleAlign: TextAlign.start,
            titleMaxLines: 100,
          ),
          20.verticalSpace,
          20.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                title: " Details",
                titleColor: AppColors.mainColor,
                titleAlign: TextAlign.start,
                titleSize: 20.sp,
              ),
              IconButton(
                onPressed: (){
                  speak('مرحبا بكم في فريقنا ، نتمنى لكم يوما سعيداََ');
                },
                icon: Icon(
                  Icons.headset_mic_rounded,
                  size: 25.sp,
                  color: AppColors.mainColor,
                ),
              )
            ],
          ),
          TextWidget(
            title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's",
            titleAlign: TextAlign.start,
            titleMaxLines: 100,
          ),
          20.verticalSpace,

        ],
      ),
    );
  }
}
