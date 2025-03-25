import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/app/utils/app_assets.dart';
import 'package:graduation_project/app/utils/app_colors.dart';
import 'package:graduation_project/app/widgets/default_app_bar_widget.dart';
import 'package:graduation_project/app/widgets/image_widget.dart';
import 'package:graduation_project/features/profile_feature/presentation/widgets/custom_about_us_item.dart';

import '../../../../app/widgets/text_widget.dart';
import '../../data/models/about_us_model.dart';

class AboutUSScreen extends StatefulWidget {
  const AboutUSScreen({super.key});

  @override
  State<AboutUSScreen> createState() => _AboutUSScreenState();
}

class _AboutUSScreenState extends State<AboutUSScreen> {
  List<AboutUsModel> aboutUSList = [
    AboutUsModel(
        image: AppImages.mohamedKhalid,
        name: "Eng Mohamed Khalid",
        job: "Flutter Developer",
        phone: "+201016738840",
        emil: "mohamedkhalidshawky@gmail.com",
    ),
    AboutUsModel(
      image: AppImages.ahamedGamal,
      name: "Eng Ahmed Gamal",
      job: "AI Developer",
      phone: "+201103785157",
      emil: "ahmedgmal172002@gmail.com",
    ),
    AboutUsModel(
      image: AppImages.moatasem,
      name: "Eng Moatasem Mohamed",
      job: "Back-end Developer",
      phone: "+201064309940",
      emil: "mooddabs4@gmail.com",
    ),
    AboutUsModel(
      image: AppImages.meirhanLotfy,
      name: "Eng Meirhan lotfy",
      job: "AI Developer",
      phone: "+201033960610",
      emil: "Merylotfy151@gmail.com ",
    ),
    AboutUsModel(
      image: AppImages.esraa,
      name: "Eng Esraa Hany",
      job: "Back-end Developer",
      phone: "+201024033970",
      emil: "esraakaf3@gmail.com",
    ),
    AboutUsModel(
      image: AppImages.mena,
      name: "Eng Mena Mohamed",
      job: "Machine learning Developer",
      phone: "+201011766817",
      emil: "menamahdy.010@gmail.com",
    ),
    AboutUsModel(
      image: AppImages.esraa_ahmed,
      name: "Eng Esraa Ahmed",
      job: "System and Data analysis Developer",
      phone: "+201064617893",
      emil: "ea1543347@gmail.com",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: const DefaultAppBarWidget(
         title: "عن المطورين",
         titleColor: AppColors.black,
         leadingColor: AppColors.black,
       ),
        body: ListView.builder(
          itemCount: aboutUSList.length,
          padding: EdgeInsets.all(16.sp),
          itemBuilder: (context, index) {
            return CustomAboutUsItem(
                aboutUsModel: aboutUSList[index],
            );
          },
        ),
    );
  }
}
