import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/app/utils/app_assets.dart';
import 'package:graduation_project/app/utils/app_colors.dart';
import 'package:graduation_project/app/utils/get_it_injection.dart';
import 'package:graduation_project/app/utils/helper.dart';
import 'package:graduation_project/app/widgets/image_widget.dart';
import 'package:graduation_project/app/widgets/text_widget.dart';
import 'package:graduation_project/features/auth_feature/presentation/screens/choose_profile_type_screen.dart';
import 'package:graduation_project/features/home_feature/presentation/screens/home_item_details_screen.dart';
import 'package:graduation_project/features/home_feature/presentation/widgets/custom_home_item.dart';

import '../../../../app/services/cache_service.dart';
import '../../../../app/widgets/carousel_widget/carousel_widget.dart';
import '../../../../app/widgets/loading.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
//8076505cdc0840e5a27225259242906
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal:16.sp),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.verticalSpace,
                getIt<CacheService>().getUserToken()==null?
                Row(
                  children: [
                    ImageWidget(
                      imageUrl: "https://cdn-icons-png.flaticon.com/128/149/149071.png",
                      width: 30.w,
                      height: 30.h,
                      // fit: BoxFit.cover,
                    ),
                    5.horizontalSpace,
                    InkWell(
                      onTap: (){
                        navigateTo(ChooseProfileTypeScreen(fromGest: true));
                      },
                      child: TextWidget(
                        title: "تسجيل الدخول",
                        titleColor: AppColors.mainColor,
                        titleSize: 20.sp,
                      ),
                    ),
                  ],
                )
                    :
                Row(
                  children: [
                    getIt<CacheService>().getUserImage()==null?
                    ImageWidget(
                      imageUrl: "https://cdn-icons-png.flaticon.com/128/149/149071.png",
                      width: 30.w,
                      height: 30.h,
                      // fit: BoxFit.cover,
                    )
                        :
                    CircleAvatar(
                      radius: 25.r,
                      backgroundImage: FileImage(File(getIt<CacheService>().getUserImage()??"")),
                    ),
                    5.horizontalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                            title: "Welcome",
                          titleFontWeight: FontWeight.bold,
                          titleColor: AppColors.mainColor,
                          titleSize: 20.sp,
                        ),
                        TextWidget(
                            title: getIt<CacheService>().getUserData()?.name??"",
                          titleColor: AppColors.mainColor,
                          titleSize: 19.sp,
                          titleFontWeight: FontWeight.bold,
                        ),
                      ],
                    )
            
                  ],
                ),
                30.verticalSpace,
                Container(
                  height: 132.h,
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  padding: EdgeInsets.symmetric(horizontal: 22.w,vertical: 5.h),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(24),
                    // gradient: LinearGradient(
                    //   begin: AlignmentDirectional.centerStart,
                    //   end: AlignmentDirectional.centerEnd,
                    //   colors:[
                    //     //Color(0xffD4E5D3),
                    //     Color(0xff85994D),
                    //     Color(0xff504C44),
                    //   ]
                    // )
                  ),
                  child:Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: ImageWidget(
                          imageUrl: "assets/images/sky.png",
                          width: 80.w,
                          height: 100.h,
                        ),
                      ),
                      5.horizontalSpace,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextWidget(
                            title: "الحرارة",
                            titleColor: AppColors.black,
                            titleSize: 18.sp,
                          ),
                          TextWidget(
                            title: "30°C",
                            titleColor: AppColors.black,
                            titleFontWeight: FontWeight.bold,
                            titleSize: 18.sp,
                          ),
                        ],
                      ),
                      3.horizontalSpace,
                      SizedBox(
                        height: 30.h,
                        child: VerticalDivider(
                          color: AppColors.black,
                        ),
                      ),
                      3.horizontalSpace,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextWidget(
                            title: "الرطوبة",
                            titleColor: AppColors.black,
                            titleSize: 18.sp,
                          ),
                          TextWidget(
                            title: "73%",
                            titleColor: AppColors.black,
                            titleFontWeight: FontWeight.bold,
                            titleSize: 18.sp,
                          ),
                        ],
                      ),
                      3.horizontalSpace,
                      SizedBox(
                        height: 30.h,
                        child: VerticalDivider(
                          color: AppColors.black,
                        ),
                      ),
                      3.horizontalSpace,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextWidget(
                            title: "الامطار",
                            titleColor: AppColors.black,
                            titleSize: 18.sp,
                          ),
                          TextWidget(
                            title: "0%",
                            titleColor: AppColors.black,
                            titleSize: 18.sp,
                            titleFontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      3.horizontalSpace,
                      SizedBox(
                        height: 30.h,
                        child: VerticalDivider(
                          color: AppColors.black,
                        ),
                      )

            
                    ],
                  ),
                ),
                16.verticalSpace,
                CarouselWidget(
                  items: List<Widget>.generate(
                        10,
                        (index) =>
                            Container(
                              height: 132.h,
                              padding: EdgeInsets.symmetric(horizontal: 22.w,vertical: 5.h),
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(157, 182, 104, .53),
                                  //AppColors.mainColor.withOpacity(.65),
                                  borderRadius: BorderRadius.circular(24)
                              ),
                              child:Row(
                                children: [
                                  ImageWidget(
                                    imageUrl: AppImages.frame,
                                    width: 86.w,
                                    height: 140.h,
                                  ),
                                  Expanded(
                                    child: TextWidget(
                                      title: "اجعل نباتاتك اكثر صحه لتحصل علي انتاجيه افضل",
                                      titleColor: AppColors.black,
                                      titleSize: 20.sp,
                                    ),
                                  )
            
                                ],
                              ),
                            ),
                  ),
                ),
                20.verticalSpace,
                TextWidget(
                  title: "افضل الادوية : ",
                  titleColor: AppColors.black,
                  titleSize: 20.sp,
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("scan").snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          20.verticalSpace,
                          SizedBox(
                            height: 250.h,
                            child: ListView.separated(
                              itemCount: 3,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 270.w,
                                      height: 150.h,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                            snapshot.data?.docs[index]["image"]??"",
                                          ),
                                        ),
                                        borderRadius: BorderRadius.circular(16.r),
                                        border: Border.all(
                                          color: AppColors.mainColor,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        TextWidget(
                                          title:"اسم العلاج : ".tr(),
                                          titleSize: 15.sp,
                                          titleColor: AppColors.black,
                                          titleFontWeight: FontWeight.bold,
                                        ),
                                        TextWidget(
                                          title:snapshot.data?.docs[index]["name"]??"",
                                          titleSize: 16.sp,
                                          titleColor: AppColors.mainColor,
                                          titleFontWeight: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        TextWidget(
                                          title:"الماده الفعالة : ".tr(),
                                          titleSize: 15.sp,
                                          titleColor: AppColors.black,
                                          titleFontWeight: FontWeight.bold,
                                        ),
                                        TextWidget(
                                          title:snapshot.data?.docs[index]["effective"]??"",
                                          titleSize: 16.sp,
                                          titleColor: AppColors.mainColor,
                                          titleFontWeight: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        TextWidget(
                                          title:"طريقه الاستعمال : ".tr(),
                                          titleSize: 15.sp,
                                          titleColor: AppColors.black,
                                          titleFontWeight: FontWeight.bold,
                                        ),
                                        TextWidget(
                                          title:snapshot.data?.docs[index]["use"]??"",
                                          titleSize: 16.sp,
                                          titleColor: AppColors.mainColor,
                                          titleFontWeight: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        TextWidget(
                                          title:"يستخدم لعلاج :".tr(),
                                          titleSize: 15.sp,
                                          titleColor: AppColors.black,
                                          titleFontWeight: FontWeight.bold,
                                        ),
                                        TextWidget(
                                          title:"${snapshot.data?.docs[index]["type"]??""} (${snapshot.data?.docs[index]["name2"]??""})".tr(),
                                          titleSize: 16.sp,
                                          titleColor: AppColors.mainColor,
                                          titleFontWeight: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) => 16.horizontalSpace,
                            ),
                          ),
                          32.verticalSpace,
                        ],
                      );
                    }else{
                      return Center(
                        child: Loading(),
                      );
                    }
                  },
                ),
                // SizedBox(
                //   height: 250.h,
                //   child: GridView.builder(
                //     itemCount: 20,
                //       physics: const AlwaysScrollableScrollPhysics(),
                //       gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                //         crossAxisCount: 2,
                //         mainAxisSpacing: 16.w,
                //         crossAxisSpacing: 16.h
                //       ),
                //       itemBuilder: (context, index) {
                //         return InkWell(
                //           onTap: () async{
                //          //7hkPBx0LmsUXi0zo5ymRLuelO7C2
                //             navigateTo(HomeItemDetailsScreen());
                //           },
                //             child: CustomHomeItem(image: AppImages.frame,));
                //       },
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),

    );
  }
}
