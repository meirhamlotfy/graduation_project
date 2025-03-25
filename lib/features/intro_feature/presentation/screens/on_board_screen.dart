import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/app/utils/app_fonts.dart';
import 'package:graduation_project/app/widgets/button_widget.dart';
import 'package:graduation_project/app/widgets/text_button_widget.dart';
import 'package:graduation_project/features/auth_feature/presentation/screens/choose_profile_type_screen.dart';
import 'package:graduation_project/features/auth_feature/presentation/screens/farmer_auth/farmer_login_screen.dart';
import 'package:graduation_project/features/chat_feature/presentation/presentation_logic_holder/chat_cubit.dart';
import 'package:graduation_project/features/intro_feature/presentation/widgets/custom_onboard_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../app/services/cache_service.dart';
import '../../../../app/utils/app_assets.dart';
import '../../../../app/utils/app_colors.dart';
import '../../../../app/utils/helper.dart';
import '../../../../app/widgets/image_widget.dart';
import '../../../../app/widgets/text_widget.dart';
import '../../data/models/onboard_model.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  final PageController controller = PageController();
  List<OnBoardModel> list = [
    OnBoardModel(
      image: AppImages.onBoard,
      title1: "حافظ علي نباتاتك",
      title2: "اجعل نباتاتك اكثر صحه لتحصل علي انتاجيه افضل",
    ),
    OnBoardModel(
      image: AppImages.onBoard,
      title1: "حافظ علي نباتاتك",
      title2: "اجعل نباتاتك اكثر صحه لتحصل علي انتاجيه افضل",
    ),
    OnBoardModel(
      image: AppImages.onBoard,
      title1: "حافظ علي نباتاتك",
      title2: "اجعل نباتاتك اكثر صحه لتحصل علي انتاجيه افضل",
    ),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body:PageView.builder(
        controller: controller,
       onPageChanged: (value) {
         setState(() {
           currentIndex = value;
         });
       },
        itemCount: list.length,
        itemBuilder:(context, index) {
          return CustomOnboardBody(onBoardModel: list[index]);
        },
      ),
      bottomNavigationBar:Container(
        padding: EdgeInsets.only(bottom: 60.h,left: 19),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonWidget(
              onPressed: () {
                if(currentIndex < list.length-1){
                  setState(() {
                    currentIndex ++;
                    controller.animateToPage(
                      currentIndex, duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOutSine,
                    );
                  });
                } else{
                  print("finish next");
                  navigateTo(const ChooseProfileTypeScreen(fromGest: false,));
                  // CacheService().setOnBoarding().then((value) {
                  //
                  //   //navigateTo(const LoginScreen(),replace: true)
                  //   });
                }
              },
              text: "التالي",
              width: 100.w,
              height: 62.h,
              mainAxisAlignment: MainAxisAlignment.center,
              borderRadiusObject: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomLeft: Radius.circular(50)
              ),
            ),
            SmoothPageIndicator(
              controller: controller,
              count: list.length,
              effect:const ExpandingDotsEffect(
                  activeDotColor: AppColors.mainColor,
                  dotColor:  Color(0xffD9D9D9),
                  radius: 10,
                  spacing: 8,
                  expansionFactor: 5,
                  dotHeight: 8,
                  dotWidth: 10
              ),
            ),
            CustomTextButton(
              onPressed: () {
                navigateTo(const ChooseProfileTypeScreen(fromGest: false,));
                print("finish Skip");
                // CacheService().setOnBoarding().then((value) {
                //   //navigateTo(const LoginScreen(),replace: true)
                //   ;});
              },
              title:"تخطي",
            )


          ],
        ),
      ) ,
    );
  }
}
