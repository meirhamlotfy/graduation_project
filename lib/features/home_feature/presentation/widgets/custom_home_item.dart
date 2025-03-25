import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/app/utils/app_colors.dart';
import 'package:graduation_project/app/widgets/image_widget.dart';
import 'package:graduation_project/app/widgets/text_widget.dart';

import '../../../../app/utils/consts.dart';
class CustomHomeItem extends StatelessWidget {
  const CustomHomeItem({super.key, required this.image, this.name});
  final String image;
  final String? name;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 10.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.gery455.withOpacity(.25))
      ),
      child:Column(
        children: [
          ImageWidget(
            imageUrl: image,
            width: 100.w,
            height: 100.h,
          ),
          10.verticalSpace,
          TextWidget(
              title:name?? "الاسم",
            titleColor: AppColors.mainColor,
            titleSize: 17.sp,
          )
        ],
      ),
    );
  }
}


class CustomCategoryItem extends StatelessWidget {
  const CustomCategoryItem({super.key, required this.image, this.name});
  final String image;
  final String? name;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 10.w),
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.gery455.withOpacity(.25)),
        boxShadow: [
          BoxShadow(
            color: AppColors.gery455.withOpacity(.25),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ]
      ),
      child:Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: ImageWidget(
              imageUrl: image,
              width: double.infinity.w,
              height: 150.h,
              fit: BoxFit.fill,
            ),
          ),
          10.verticalSpace,
          TextWidget(
            title:name?? "الاسم",
            titleColor: AppColors.mainColor,
            titleSize: 17.sp,
          )
        ],
      ),
    );
  }
}


class CustomSubCategoryItem extends StatelessWidget {
  const CustomSubCategoryItem({super.key, required this.image, this.name, this.benefit});
  final String image;
  final String? name;
  final String? benefit;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 10.w),
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.gery455.withOpacity(.25)),
        boxShadow: [
          BoxShadow(
            color: AppColors.gery455.withOpacity(.25),
            spreadRadius: 5,
            blurRadius: 7,
            //offset: const Offset(0, 3), // changes position of shadow
          ),
        ]
      ),
      child:Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: ImageWidget(
              imageUrl: image,
              width: double.infinity.w,
              height: 140.h,
              fit: BoxFit.fill,
            ),
          ),
          TextWidget(
            title:name?? "الاسم",
            titleColor: AppColors.black,
            titleSize: 20.sp,
            titleFontWeight: FontWeight.w500,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                title: "الفوائد",
                titleColor: AppColors.mainColor,
                titleAlign: TextAlign.start,
                titleSize: 20.sp,
              ),
              IconButton(
                onPressed: (){
                  speak(benefit??'ز الجسم تحسين عمليات الايض الحماية من حصى المرارة تحسين جهاز الدوران-المساهمة في خفض احتمالية الإصابة بمرض السكرى من النمط 2 ََ');
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
            title: benefit??"",
            titleAlign: TextAlign.start,
            titleMaxLines: 200,
          ),
        ],
      ),
    );
  }
}

class CustomSubCategoryBackItem extends StatelessWidget {
  const CustomSubCategoryBackItem({super.key, this.details, this.vits});
  final String? details;
  final String? vits;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 5.w),
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.gery455.withOpacity(.25)),
          boxShadow: [
            BoxShadow(
              color: AppColors.gery455.withOpacity(.25),
              spreadRadius: 5,
              blurRadius: 7,
              //offset: const Offset(0, 3), // changes position of shadow
            ),
          ]
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                title: "التفاصيل",
                titleColor: AppColors.mainColor,
                titleAlign: TextAlign.start,
                titleSize: 20.sp,
              ),
              IconButton(
                onPressed: (){
                  speak(details??'مرحبا بكم في فريقنا ، نتمنى لكم يوما سعيداََ');
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
            title:details?? "",
            titleAlign: TextAlign.start,
            titleMaxLines: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                title: "الاملاح المعدنية",
                titleColor: AppColors.mainColor,
                titleAlign: TextAlign.start,
                titleSize: 20.sp,
              ),
              IconButton(
                onPressed: (){
                  speak(vits??'الحديد، الكالسيوم، الفسفور، المغنسيوم، الصوديوم، البوتاسيوم، فيتامين ب 6، فيتامين ج، الزنك، حمض الفوليكََ');
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
            title:vits?? "",
            titleAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            titleMaxLines: 100,
          ),
        ],
      ),
    );
  }
}

