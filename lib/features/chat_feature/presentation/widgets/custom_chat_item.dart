import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/app/utils/app_colors.dart';
import '../../../../app/utils/app_assets.dart';
import '../../../../app/widgets/image_widget.dart';
import '../../../../app/widgets/text_widget.dart';

class CustomEngChatItem extends StatelessWidget {
  const CustomEngChatItem({super.key,  this.userName,  this.payAmount, this.phone});
  final String? userName ;
  final String? phone ;
  final String ?payAmount ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageWidget(
            imageUrl: "https://cdn-icons-png.flaticon.com/128/3135/3135715.png",
            width: 51.w,
            height: 51.h,
          ),
          16.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                title:userName?? "Manar Maher",
                titleColor: AppColors.mainColor,
                titleFontWeight: FontWeight.w600,
                titleSize: 17.sp,
              ),
              TextWidget(
                title:phone?? "01016738840",
                titleColor: AppColors.black,
                titleSize: 15.sp,
              ),
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                title:"الخدمه",
                titleColor: AppColors.mainColor,
                titleSize: 15.sp,
              ),
              TextWidget(
                title: "${payAmount??50} جنيه",
                titleColor: AppColors.black,
                titleSize: 14.sp,
              ),
            ],
          ),


        ],
      ),
    );
  }
}

class CustomUserChatItem extends StatelessWidget {
  const CustomUserChatItem({super.key,  this.userName, this.phone, this.city});
  final String? userName ;
  final String? phone ;
  final String? city ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageWidget(
            imageUrl: "https://cdn-icons-png.flaticon.com/128/149/149071.png",
            width: 51.w,
            height: 51.h,
          ),
          16.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                title:userName?? "Manar Maher",
                titleColor: AppColors.mainColor,
                titleFontWeight: FontWeight.w600,
                titleSize: 17.sp,
              ),
              TextWidget(
                title:phone?? "01016738840",
                titleColor: AppColors.black,
                titleSize: 15.sp,
              ),
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                title:"المدينة",
                titleColor: AppColors.mainColor,
                titleSize: 15.sp,
              ),
              TextWidget(
                title: city?? "القاهرة",
                titleColor: AppColors.black,
                titleSize: 14.sp,
              ),
            ],
          ),


        ],
      ),
    );
  }
}
