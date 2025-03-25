import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/app/services/cache_service.dart';
import 'package:graduation_project/app/utils/app_assets.dart';
import 'package:graduation_project/app/utils/app_colors.dart';
import 'package:graduation_project/app/widgets/button_widget.dart';
import 'package:graduation_project/app/widgets/default_app_bar_widget.dart';
import 'package:graduation_project/app/widgets/image_widget.dart';
import 'package:graduation_project/app/widgets/loading.dart';
import 'package:graduation_project/app/widgets/text_widget.dart';
import 'package:graduation_project/features/scan_feature/presentation/widgets/custom_scan_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';

import '../../../../app/services/image_picker_service/image_picker_service.dart';
import '../../../../app/utils/get_it_injection.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  File? userImage;
  String ? selectedType;
  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }
   loadModel() async {
    await Tflite.loadModel(
      model: "assets/model/model_unquant.tflite",
      labels: "assets/model/labels.txt",
      isAsset: true,
    );
  }
  Future detectimage(File image) async {
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      selectedType = recognitions?[0]["label"].substring(2);
      // dataList = List<Map<String, dynamic>>.from(jsonDecode(v));
    });
    print("${recognitions?[0]["label"].substring(2)}");
  }
  bool hasResult = false;
  var url ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:const DefaultAppBarWidget(
        leadingColor: AppColors.mainColor,
        title: "افحص نباتك",
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.sp,vertical: 20.h),
        child:hasResult?
        StreamBuilder(
            stream: FirebaseFirestore.instance.collection("scan").where(
              "type",isEqualTo: selectedType
            ).snapshots(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        TextWidget(
                          title:"نتائج الفحص",
                          titleSize: 18.sp,
                          titleColor: AppColors.black,
                          titleFontWeight: FontWeight.bold,

                        ),
                      ],
                    ),
                    20.verticalSpace,
                    Container(
                      width: 200.w,
                      height: 200.h,
                      padding: EdgeInsets.all(16.sp),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(File(userImage!.path)),
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: AppColors.mainColor,
                        ),
                      ),
                    ),
                    12.verticalSpace,
                    Row(
                      children: [
                        TextWidget(
                          title:"نوع النبات : ".tr(),
                          titleSize: 16.sp,
                          titleColor: AppColors.black,
                          titleFontWeight: FontWeight.bold,
                        ),
                        5.horizontalSpace,
                        TextWidget(
                          title:snapshot.data?.docs[0]["type2"]??"",
                          titleSize: 17.sp,
                          titleColor: AppColors.mainColor,
                          titleFontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    Row(
                      children: [
                        TextWidget(
                          title:"اسم المرض : ".tr(),
                          titleSize: 16.sp,
                          titleColor: AppColors.black,
                          titleFontWeight: FontWeight.bold,
                        ),
                        5.horizontalSpace,
                        TextWidget(
                          title:snapshot.data?.docs[0]["type"]??"",
                          titleSize: 17.sp,
                          titleColor: AppColors.mainColor,
                          titleFontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    Row(
                      children: [
                        TextWidget(
                          title:"الاسم الشائع للمرض : ".tr(),
                          titleSize: 16.sp,
                          titleColor: AppColors.black,
                          titleFontWeight: FontWeight.bold,
                        ),
                        5.horizontalSpace,
                        TextWidget(
                          title:snapshot.data?.docs[0]["name2"]??"",
                          titleSize: 17.sp,
                          titleColor: AppColors.mainColor,
                          titleFontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          title:"الوصف : ".tr(),
                          titleSize: 16.sp,
                          titleColor: AppColors.black,
                          titleFontWeight: FontWeight.bold,
                        ),
                        5.horizontalSpace,
                        Expanded(
                          child: TextWidget(
                            title:snapshot.data?.docs[0]["desc"]??"",
                            titleSize: 17.sp,
                            titleMaxLines: 50,
                            titleColor: AppColors.mainColor,
                            titleFontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    Row(
                      children: [
                        TextWidget(
                          title:"العلاج : ".tr(),
                          titleSize: 16.sp,
                          titleColor: AppColors.black,
                          titleFontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    12.verticalSpace,
                    SizedBox(
                      height: 250.h,
                      child: ListView.separated(
                        itemCount: snapshot.data?.docs.length??0,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 250.w,
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
        )
            :
        Column(
          children: [
            Row(
              children: [
                TextWidget(
                    title:"اختار طريقة الفحص",
                    titleSize: 18.sp,
                    titleColor: AppColors.black,
                  titleFontWeight: FontWeight.bold,

                ),
              ],
            ),
            50.verticalSpace,
            userImage==null?
            Container(
              width: 300.w,
              height: 300.h,
              padding: EdgeInsets.all(16.sp),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:
                  AssetImage(AppImages.scan),
                ),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: AppColors.mainColor,
                ),
              ),
            )
            :
            Container(
              width: 300.w,
              height: 300.h,
              padding: EdgeInsets.all(16.sp),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: FileImage(File(userImage!.path)),
                ),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: AppColors.mainColor,
                ),
              ),
            ),
            // TextWidget(
            //   title:userImage?.path?? "لا يوجد صوره للفحص من فضلك اختار طريقة الفحص".tr(),
            //   titleSize: 15.sp,
            //   titleColor: AppColors.black,
            //   titleFontWeight: FontWeight.bold,
            // ),
          ],
        ),
      ),
      bottomNavigationBar: hasResult?
          null:
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20.sp,vertical: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ButtonWidget(
                text: "الكاميرا",
                color: AppColors.mainColor2,
                onPressed: ()async{ {
                  await ImagePickerService.getImage(imageSource: ImageSource.camera).then((value) {
                    userImage = File(value?.path??"");
                    if(value != null){
                      setState(() {
                        detectimage(File(userImage!.path)).then((value)async {
                          hasResult = true;
                          var rand = Random().nextInt(800000000);
                          var name = userImage?.path ?? "";
                          name = rand.toString() + name;
                          var refStorage = FirebaseStorage.instance.ref("scans/$name");
                          await refStorage.putFile(userImage!);
                          url = await refStorage.getDownloadURL();
                          setState(() {

                          });
                        },);
                      });
                    }
                  });
                }
                },
              ),
            ),
            16.horizontalSpace,
            Expanded(
              child: ButtonWidget(
                text: "معرض الصور",
                onPressed: ()async{ {
                  print(FirebaseAuth.instance.currentUser?.uid);
                  await ImagePickerService.getImage(imageSource: ImageSource.gallery).then((value)async {
                    userImage = File(value?.path??"");
                    if(value != null) {
                      setState(() {
                        detectimage(File(userImage!.path)).then((value)async {
                            hasResult = true;
                            var rand = Random().nextInt(800000000);
                            var name = userImage?.path ?? "";
                            name = rand.toString() + name;
                            var refStorage = FirebaseStorage.instance.ref("scans/$name");
                            await refStorage.putFile(userImage!);
                         url=await refStorage.getDownloadURL();
                         setState(() {});
                            FirebaseFirestore.instance.collection("collectionPath").doc().set({
                              "desc" :"مرض فطرى يسبب ظهور خطوط افقيه بنيه على الاوراق",
                              "effective": "Azoxystrobin",
                              "image":"https://i0.wp.com/agricash.app/wp-content/uploads/2024/01/%D8%B4%D9%88%D8%B1%D9%8A-105.jpg?fit=1248%2C1248&ssl=1",
                              "image2":url,
                              "name": "Amistar Top 32.5% اميستار توب",
                              "name2": "شعوطه",
                              "type": "brown_rust",
                              "type2": "القمح",
                              "id": getIt<CacheService>().getUserData()?.email,
                              "use": "25 سم / 100 لتر ماء "
                            });
                        },);
                      });
                    }
                  });
                }
                },
              ),
            ),
          ],
        ),
      ),

    );
  }
}
