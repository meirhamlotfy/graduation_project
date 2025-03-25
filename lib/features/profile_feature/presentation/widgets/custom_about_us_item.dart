import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/app/utils/app_assets.dart';
import 'package:graduation_project/app/utils/app_colors.dart';
import 'package:graduation_project/app/widgets/default_app_bar_widget.dart';
import 'package:graduation_project/app/widgets/image_widget.dart';
import 'package:graduation_project/features/profile_feature/data/models/about_us_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/widgets/text_widget.dart';
class CustomAboutUsItem extends StatelessWidget {
  const CustomAboutUsItem({super.key, required this.aboutUsModel});
   final AboutUsModel aboutUsModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      margin: EdgeInsets.only(bottom :16.sp),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.25),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ]
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: ImageWidget(
                  imageUrl: aboutUsModel.image,
                  width: 100.w,
                  height: 150.h,
                  fit: BoxFit.cover,
                ),
              ),
              10.horizontalSpace,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      title: aboutUsModel.name,
                      titleColor: AppColors.mainColor,
                      titleAlign: TextAlign.start,
                      titleSize: 20.sp,
                    ),
                    3.verticalSpace,
                    TextWidget(
                      title: aboutUsModel.job,
                      titleColor: AppColors.gery455,
                      titleAlign: TextAlign.start,
                      titleSize: 15.sp,
                    ),
                    10.verticalSpace,
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: ImageWidget(
                            imageUrl: AppImages.whatsapp,
                            width: 35.w,
                            height: 35.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        10.horizontalSpace,
                        InkWell(
                          onTap: ()async {
                            await _launchWhatsapp(phone: aboutUsModel.phone);
                          },
                          child: TextWidget(
                            title: aboutUsModel.phone,
                            titleColor: AppColors.mainColor,
                            titleSize: 16.sp,
                            textDecoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: ImageWidget(
                            imageUrl: AppImages.google,
                            width: 30.w,
                            height: 30.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        10.horizontalSpace,
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                                await _launchEmail(url: "mailto:${aboutUsModel.emil}");
                            },
                            child: TextWidget(
                              title: aboutUsModel.emil,
                              titleColor: AppColors.mainColor,
                              titleSize: 15.sp,
                              titleAlign: TextAlign.start,  
                              textDecoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),

            ],
          )
        ],
      ),
    );
  }


   Future<void> _launchWhatsapp({required String phone}) async{
     String url = 'https://wa.me/$phone/?text=${Uri.parse("Hello, this is a test message!")}';
     if (!await launchUrl(Uri.parse(url))){
        throw Exception('Could not launch $url');
     }
   }

   Future<void> _launchEmail({required String url}) async{
     if (!await launchUrl(Uri.parse(url))){
        throw Exception('Could not launch $url');
     }
   }
}
