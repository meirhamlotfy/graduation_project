import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/app/utils/app_assets.dart';
import 'package:graduation_project/app/utils/helper.dart';
import 'package:graduation_project/features/auth_feature/presentation/screens/choose_profile_type_screen.dart';
import 'package:graduation_project/features/scan_feature/presentation/screens/scan_screen.dart';

import '../../../../app/services/cache_service.dart';
import '../../../../app/utils/app_colors.dart';
import '../../../../app/utils/get_it_injection.dart';
import '../../../../app/widgets/custom_alert_dialog.dart';
import '../../../../app/widgets/image_widget.dart';
import '../presentation_logic_holder/bottom_navigation_cubit.dart';
import '../presentation_logic_holder/bottom_navigation_state.dart';
class BNBScreen extends StatefulWidget {
  const BNBScreen({super.key,  this.fromEng = false});
 final bool fromEng ;
  @override
  State<BNBScreen> createState() => _BNBScreenState();
}

class _BNBScreenState extends State<BNBScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavigationCubit(),
      child: BlocBuilder<BottomNavigationCubit, BottomNavigationStats>(
        builder: (context, state) {
          var cubit = BottomNavigationCubit.get(context);
          return Scaffold(
            bottomNavigationBar: AnimatedBottomNavigationBar(
                activeIndex: cubit.currentIndex,
              gapLocation: GapLocation.center,
              borderColor: Colors.grey,
              height: 70.h,
              iconSize: 28.sp,
              activeColor: AppColors.mainColor,
              elevation: 100,
              notchSmoothness: NotchSmoothness.smoothEdge,
              leftCornerRadius: 32,
              rightCornerRadius: 32,
                onTap: (index) {
                  if (getIt<CacheService>().getUserData() == null) {
                    if( index == 2 || index == 3){
                      globalAlertDialogue("من فضلك قم بتسجيل الدخول اولأ",
                        onOk: () async {
                          navigateTo(ChooseProfileTypeScreen(fromGest: true),removeAll: true);
                        },
                        canCancel: true,
                        onCancel: (){
                          Navigator.pop(context);
                        },
                        okButtonText: "نعم",
                        cancelButtonText: "لا",
                      );
                    }else{
                      cubit.changeCurrent(index);
                    }
                  }else{
                    cubit.changeCurrent(index);
                  }
                },
              icons: [
                Icons.home,
                Icons.grid_view_rounded,
                Icons.chat,
                Icons.person,

              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            floatingActionButton: InkWell(
              onTap: () {
                if (getIt<CacheService>().getUserData() == null) {
                  globalAlertDialogue("من فضلك قم بتسجيل الدخول اولأ",
                    onOk: () async {
                      navigateTo(ChooseProfileTypeScreen(fromGest: true),removeAll: true);
                    },
                    canCancel: true,
                    onCancel: (){
                      Navigator.pop(context);
                    },
                    okButtonText: "نعم",
                    cancelButtonText: "لا",
                  );
                }else{
                  navigateTo(ScanScreen());
                }
              },
              child: Container(
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.r),
                    topRight: Radius.circular(25.r),
                    bottomLeft: Radius.circular(25.r),
                    bottomRight: Radius.circular(25.r),
                  ),
                ),
                child: Icon(
                  Icons.qr_code_scanner_outlined,
                  color: AppColors.white,
                )
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          );
        },
      ),
    );
  }
}
