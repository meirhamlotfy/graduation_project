import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/app/utils/app_assets.dart';
import 'package:graduation_project/app/widgets/button_widget.dart';
import 'package:graduation_project/app/widgets/flutter_toast.dart';
import 'package:graduation_project/features/profile_feature/presentation/widgets/custom_sheet_profile.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../app/services/cache_service.dart';
import '../../../../app/services/image_picker_service/image_picker_service.dart';
import '../../../../app/utils/app_colors.dart';
import '../../../../app/utils/get_it_injection.dart';
import '../../../../app/utils/helper.dart';
import '../../../../app/widgets/custom_form_field.dart';
import '../../../../app/widgets/default_app_bar_widget.dart';
import '../../../../app/widgets/text_widget.dart';
import '../widgets/custom_edit_button.dart';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  XFile? userImage;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    nameController.text=getIt<CacheService>().getUserData()?.name??"";
    phoneController.text=getIt<CacheService>().getUserData()?.phone??"";
    emailController.text=getIt<CacheService>().getUserData()?.email??"";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: const DefaultAppBarWidget(
          canBack: true,
          titleColor: AppColors.black,
          leadingColor: AppColors.black,
          title: "تعديل الحساب",
        ),
        body: Column(
          children: [
            50.verticalSpace,
            Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.sp),
                      topLeft: Radius.circular(20.sp),
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.all(16),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            clipBehavior: Clip.none,
                            children: [
                          getIt<CacheService>().getUserImage() ==null?
                              Container(
                                width: 100.w,
                                height: 100.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      //fit: BoxFit.fitHeight,
                                      image:NetworkImage("https://cdn-icons-png.flaticon.com/128/149/149071.png")
                                  ),
                                ),
                              )
                                  :
                              CircleAvatar(
                                radius: 60.r,
                                backgroundImage: FileImage(File(getIt<CacheService>().getUserImage()??"")),
                              ),
                              Positioned(
                                right: -15.w,
                                bottom: -10.h,
                                child: CircleAvatar(
                                  backgroundColor: AppColors.mainColor,
                                  child: IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            width: double.infinity,
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(16),
                                                  topRight: Radius.circular(16),
                                                )
                                            ),
                                            //height: 200.h,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 20.h
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextWidget(
                                                  title: "chosePicture".tr(),
                                                  titleAlign: TextAlign.center,
                                                  titleSize: 20.sp,
                                                  titleColor: Colors.black,
                                                ),
                                                20.verticalSpace,
                                                Row(
                                                  mainAxisAlignment : MainAxisAlignment.spaceAround,
                                                  children: [
                                                    IconButton(
                                                      onPressed:() async{
                                                        Navigator.pop(context);
                                                        await ImagePickerService.getImage(imageSource: ImageSource.camera).then((value) {
                                                          userImage = value;
                                                          if(value != null){
                                                            setState(() {
                                                              getIt<CacheService>().setUserImage(image: value.path);
                                                            });
                                                          }
                                                        });
                                                      },
                                                      icon: Icon(
                                                        Icons.camera_alt_rounded,
                                                        color: Colors.black,
                                                        size:25.sp ,
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed:()async {
                                                        Navigator.pop(context);
                                                        await ImagePickerService.getImage(imageSource: ImageSource.gallery).then((value) {
                                                          userImage = value;
                                                          if(value != null){
                                                            setState(() {
                                                              getIt<CacheService>().setUserImage(image: value.path);
                                                            });
                                                          }
                                                        });
                                                      },
                                                      icon: Icon(
                                                        Icons.photo_library_rounded,
                                                        color: Colors.black,
                                                        size:25.sp ,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    icon: Icon(
                                      Icons.camera_alt_outlined,
                                      size: 25.sp,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          40.verticalSpace,
                           CustomFormField(
                            header: "اسمك",
                            controller: nameController,
                          ),
                          16.verticalSpace,
                           CustomFormField(
                            header: "رقم التلفون",
                            keyboardType: TextInputType.phone,
                             controller: phoneController,
                          ),
                          16.verticalSpace,
                           CustomFormField(
                            header: "البريد الخاص بك",
                            keyboardType: TextInputType.emailAddress,
                             controller: emailController,
                          ),
                          60.verticalSpace,
                          ButtonWidget(
                            text: "حفظ",
                            onPressed: () {
                              if(formKey.currentState!.validate()){
                            showToast(msg: "تم التعديل بنجاح",);
                            goBack();
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
            )
          ],
        )

    );
  }
}
